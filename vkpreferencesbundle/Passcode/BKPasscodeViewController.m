//
//  BKPasscodeViewController.m
//  BKPasscodeViewDemo
//
//  Created by Byungkook Jang on 2014. 4. 20..
//  Copyright (c) 2014년 Byungkook Jang. All rights reserved.
//

#import "BKPasscodeViewController.h"
#import "BKShiftingView.h"
#import "AFViewShaker.h"
#import "BKPasscodeUtils.h"
NSMutableDictionary *passcodeF;

typedef enum : NSUInteger {
    BKPasscodeViewControllerStateUnknown,
    BKPasscodeViewControllerStateCheckPassword,
    BKPasscodeViewControllerStateInputPassword,
    BKPasscodeViewControllerStateReinputPassword
} BKPasscodeViewControllerState;

#define kBKPasscodeOneMinuteInSeconds           (60)
#define kBKPasscodeDefaultKeyboardHeight        (216)

@interface BKPasscodeViewController ()

@property (nonatomic, strong) BKShiftingView                *shiftingView;

@property (nonatomic) BKPasscodeViewControllerState         currentState;
@property (nonatomic, strong) NSString                      *oldPasscode;
@property (nonatomic, strong) NSString                      *theNewPasscode;
@property (nonatomic, strong) NSTimer                       *lockStateUpdateTimer;
@property (nonatomic) CGFloat                               keyboardHeight;
@property (nonatomic, strong) AFViewShaker                  *viewShaker;

@property (nonatomic) BOOL                                  promptingTouchID;

@end

@implementation BKPasscodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // init state
        _type = BKPasscodeViewControllerNewPasscodeType;
        _currentState = BKPasscodeViewControllerStateInputPassword;
        
        // create shifting view
        self.shiftingView = [[BKShiftingView alloc] init];
        self.shiftingView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.shiftingView.currentView = [self instantiatePasscodeInputView];
        
        // keyboard notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveKeyboardWillShowHideNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveKeyboardWillShowHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveApplicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        self.keyboardHeight = kBKPasscodeDefaultKeyboardHeight;      // sometimes keyboard notification is not posted at all. so setting default value.
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [self.lockStateUpdateTimer invalidate];
    self.lockStateUpdateTimer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setType:(BKPasscodeViewControllerType)type
{
    if (_type == type) {
        return;
    }
    
    _type = type;
    
    switch (type) {
        case BKPasscodeViewControllerNewPasscodeType:
            self.currentState = BKPasscodeViewControllerStateInputPassword;
            break;
        default:
            self.currentState = BKPasscodeViewControllerStateCheckPassword;
            break;
    }
}

- (BKPasscodeInputView *)passcodeInputView
{
    if (NO == [self.shiftingView.currentView isKindOfClass:[BKPasscodeInputView class]]) {
        return nil;
    }
    
    return (BKPasscodeInputView *)self.shiftingView.currentView;
}

- (BKPasscodeInputView *)instantiatePasscodeInputView
{
    BKPasscodeInputView *view = [[BKPasscodeInputView alloc] init];
    view.delegate = self;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return view;
}

- (void)customizePasscodeInputView:(BKPasscodeInputView *)aPasscodeInputView
{
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
   
    [self updatePasscodeInputViewTitle:self.passcodeInputView];
    
    [self customizePasscodeInputView:self.passcodeInputView];
    
    [self.view addSubview:self.shiftingView];
    
    [self lockIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.passcodeInputView.isEnabled) {
        [self startTouchIDAuthenticationIfPossible];
    }
    
    [self.passcodeInputView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    
    CGFloat topBarOffset = 0;
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        topBarOffset = [self.topLayoutGuide length];
    }
    
    frame.origin.y += topBarOffset;
    frame.size.height -= (topBarOffset + self.keyboardHeight);

    self.shiftingView.frame = frame;
}

#pragma mark - Public methods

- (void)setPasscodeStyle:(BKPasscodeInputViewPasscodeStyle)passcodeStyle
{
    self.passcodeInputView.passcodeStyle = passcodeStyle;
}

- (BKPasscodeInputViewPasscodeStyle)passcodeStyle
{
    return self.passcodeInputView.passcodeStyle;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    self.passcodeInputView.keyboardType = keyboardType;
}

- (UIKeyboardType)keyboardType
{
    return self.passcodeInputView.keyboardType;
}

- (void)showLockMessageWithLockUntilDate:(NSDate *)lockUntil
{
    NSTimeInterval timeInterval = [lockUntil timeIntervalSinceNow];
    NSUInteger minutes = ceilf(timeInterval / 60.0f);
    
    NSString *localizationOMin;
    NSString *localizationMMin;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationOMin = @"Попробуйте еще раз через 1 минуту";
        localizationMMin = @"Попробуйте еще раз через %d минут";
    } else {
        localizationOMin = @"Try again in 1 minute";
        localizationMMin = @"Try again in %d minutes";
    }
    
    BKPasscodeInputView *inputView = self.passcodeInputView;
    inputView.enabled = NO;
    
    if (minutes == 1) {
        inputView.title = NSLocalizedStringFromTable(localizationOMin, @"BKPasscodeView", @"1분 후에 다시 시도");
    } else {
        inputView.title = [NSString stringWithFormat:NSLocalizedStringFromTable(localizationMMin, @"BKPasscodeView", @"%d분 후에 다시 시도"), minutes];
    }
    
    NSUInteger numberOfFailedAttempts = [self.delegate passcodeViewControllerNumberOfFailedAttempts:self];
    
    [self showFailedAttemptsCount:numberOfFailedAttempts inputView:inputView];
    
    if (self.lockStateUpdateTimer == nil) {
        
        NSTimeInterval delay = timeInterval + kBKPasscodeOneMinuteInSeconds - (kBKPasscodeOneMinuteInSeconds * (NSTimeInterval)minutes);
        
        self.lockStateUpdateTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:delay]
                                                             interval:60.f
                                                               target:self
                                                             selector:@selector(lockStateUpdateTimerFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.lockStateUpdateTimer forMode:NSDefaultRunLoopMode];
    }
}

- (BOOL)lockIfNeeded
{
    if (self.currentState != BKPasscodeViewControllerStateCheckPassword) {
        return NO;
    }
    
    if (NO == [self.delegate respondsToSelector:@selector(passcodeViewControllerLockUntilDate:)]) {
        return NO;
    }
    
    NSDate *lockUntil = [self.delegate passcodeViewControllerLockUntilDate:self];
    if (lockUntil == nil || [lockUntil timeIntervalSinceNow] < 0) {
        return NO;
    }
    
    [self showLockMessageWithLockUntilDate:lockUntil];
    
    return YES;
}

- (void)updateLockMessageOrUnlockIfNeeded
{
    if (self.currentState != BKPasscodeViewControllerStateCheckPassword) {
        return;
    }
    
    if (NO == [self.delegate respondsToSelector:@selector(passcodeViewControllerLockUntilDate:)]) {
        return;
    }
    
    BKPasscodeInputView *inputView = self.passcodeInputView;
    
    NSDate *lockUntil = [self.delegate passcodeViewControllerLockUntilDate:self];

    if (lockUntil == nil || [lockUntil timeIntervalSinceNow] < 0) {
        
        // invalidate timer
        [self.lockStateUpdateTimer invalidate];
        self.lockStateUpdateTimer = nil;
        
        [self updatePasscodeInputViewTitle:inputView];
        
        inputView.enabled = YES;
        
    } else {
        [self showLockMessageWithLockUntilDate:lockUntil];
    }
}

- (void)lockStateUpdateTimerFired:(NSTimer *)timer
{
    [self updateLockMessageOrUnlockIfNeeded];
}

- (void)startTouchIDAuthenticationIfPossible
{
    [self startTouchIDAuthenticationIfPossible:nil];
}

- (void)startTouchIDAuthenticationIfPossible:(void (^)(BOOL))aCompletionBlock
{
    if (NO == [self canAuthenticateWithTouchID]) {
        if (aCompletionBlock) {
            aCompletionBlock(NO);
        }
        return;
    }
    
    self.promptingTouchID = YES;
    
    [self.touchIDManager loadPasscodeWithCompletionBlock:^(NSString *passcode) {
        
        self.promptingTouchID = NO;
        
        if (passcode) {
            
            self.passcodeInputView.passcode = passcode;
            
            [self passcodeInputViewDidFinish:self.passcodeInputView];
        }
            
        if (aCompletionBlock) {
            aCompletionBlock(YES);
        }
    }];
}

#pragma mark - Private methods

- (void)updatePasscodeInputViewTitle:(BKPasscodeInputView *)passcodeInputView
{
    NSString *localizationNewTitle;
    NSString *localizationTitle;
    NSString *localizationReenterTitle;
    NSString *localizationOldTitle;
    NSString *localizationCheckTitle;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationNewTitle = @"Введите новый пароль";
        localizationTitle = @"Введите пароль";
        localizationReenterTitle = @"Повторите пароль";
        localizationOldTitle = @"Введите старый пароль";
        localizationCheckTitle = @"Введите Ваш пароль";
    } else {
        localizationNewTitle = @"Enter your new passcode";
        localizationTitle = @"Enter a passcode";
        localizationReenterTitle = @"Re-enter your passcode";
        localizationOldTitle = @"Enter your old passcode";
        localizationCheckTitle = @"Enter your passcode";
    }
    switch (self.currentState) {
        case BKPasscodeViewControllerStateCheckPassword:
            if (self.type == BKPasscodeViewControllerChangePasscodeType) {
                passcodeInputView.title = NSLocalizedStringFromTable(localizationOldTitle, @"BKPasscodeView", @"기존 암호 입력");
            } else {
                passcodeInputView.title = NSLocalizedStringFromTable(localizationCheckTitle, @"BKPasscodeView", @"암호 입력");
            }
            break;
            
        case BKPasscodeViewControllerStateInputPassword:
            if (self.type == BKPasscodeViewControllerChangePasscodeType) {
                passcodeInputView.title = NSLocalizedStringFromTable(localizationNewTitle, @"BKPasscodeView", @"새로운 암호 입력");
            } else {
                passcodeInputView.title = NSLocalizedStringFromTable(localizationTitle, @"BKPasscodeView", @"암호 입력");
            }
            break;
            
        case BKPasscodeViewControllerStateReinputPassword:
            passcodeInputView.title = NSLocalizedStringFromTable(localizationReenterTitle, @"BKPasscodeView", @"암호 재입력");
            break;
            
        default:
            break;
    }
}

- (void)showFailedAttemptsCount:(NSUInteger)failCount inputView:(BKPasscodeInputView *)aInputView
{
    NSString *localizationInvalid;
    NSString *localizationFAttempt;
    NSString *localizationMAttempt;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationInvalid = @"Неверный пароль";
        localizationFAttempt = @"Пароль введен неверно: 1 раз";
        localizationMAttempt = @"Пароль введен неверно: %d раз(а)";
    } else {
        localizationInvalid = @"Invalid Passcode";
        localizationFAttempt = @"1 Failed Passcode Attempt";
        localizationMAttempt = @"%d Failed Passcode Attempts";
    }
    if (failCount == 0) {
        aInputView.errorMessage = NSLocalizedStringFromTable(localizationInvalid, @"BKPasscodeView", @"잘못된 암호");
    } else if (failCount == 1) {
        aInputView.errorMessage = NSLocalizedStringFromTable(localizationFAttempt, @"BKPasscodeView", @"1번의 암호 입력 시도 실패");
    } else {
        aInputView.errorMessage = [NSString stringWithFormat:NSLocalizedStringFromTable(localizationMAttempt, @"BKPasscodeView", @"%d번의 암호 입력 시도 실패"), failCount];
    }
}

- (void)showTouchIDSwitchView
{
    BKTouchIDSwitchView *view = [[BKTouchIDSwitchView alloc] init];
    view.delegate = self;
    view.touchIDSwitch.on = self.touchIDManager.isTouchIDEnabled;
    
    [self.shiftingView showView:view withDirection:BKShiftingDirectionForward];
}

- (BOOL)canAuthenticateWithTouchID
{
    if (NO == [BKTouchIDManager canUseTouchID]) {
        return NO;
    }
    
    if (self.type != BKPasscodeViewControllerCheckPasscodeType) {
        return NO;
    }
   
    if (nil == self.touchIDManager || NO == self.touchIDManager.isTouchIDEnabled) {
        return NO;
    }
    
    if (self.promptingTouchID) {
        return NO;
    }
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        return NO;
    }
    
    return YES;
}

#pragma mark - BKPasscodeInputViewDelegate

- (void)passcodeInputViewDidFinish:(BKPasscodeInputView *)aInputView
{
    NSString *passcode = aInputView.passcode;
    NSString *localizationReuse;
    NSString *localizationDontMatch;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationReuse = @"Введите другой пароль. Нельзя использовать один и тот же пароль несколько раз.";
        localizationDontMatch = @"Пароли не совпадают. \nПопробуйте еще раз.";
    } else {
        localizationReuse = @"Enter a different passcode. Cannot re-use the same passcode.";
        localizationDontMatch = @"Passcodes did not match.\nTry again.";
    }
    
    switch (self.currentState) {
        case BKPasscodeViewControllerStateCheckPassword:
        {
            NSAssert([self.delegate respondsToSelector:@selector(passcodeViewController:authenticatePasscode:resultHandler:)],
                     @"delegate must implement passcodeViewController:authenticatePasscode:resultHandler:");
            
            [self.delegate passcodeViewController:self authenticatePasscode:passcode resultHandler:^(BOOL succeed) {
                
                NSAssert([NSThread isMainThread], @"you must invoke result handler in main thread.");
                
                if (succeed) {
                    
                    if (self.type == BKPasscodeViewControllerChangePasscodeType) {
                        
                        self.oldPasscode = passcode;
                        self.currentState = BKPasscodeViewControllerStateInputPassword;
                        
                        BKPasscodeInputView *newPasscodeInputView = [self.passcodeInputView copy];
                        
                        [self customizePasscodeInputView:newPasscodeInputView];
                        
                        [self updatePasscodeInputViewTitle:newPasscodeInputView];
                        [self.shiftingView showView:newPasscodeInputView withDirection:BKShiftingDirectionForward];
                        
                        [self.passcodeInputView becomeFirstResponder];
                        
                    } else {
                        [self.delegate passcodeViewController:self didFinishWithPasscode:passcode];
                        
                    }
                    
                } else {
                    
                    if ([self.delegate respondsToSelector:@selector(passcodeViewControllerDidFailAttempt:)]) {
                        [self.delegate passcodeViewControllerDidFailAttempt:self];
                    }
                    
                    NSUInteger failCount = 0;
                    
                    if ([self.delegate respondsToSelector:@selector(passcodeViewControllerNumberOfFailedAttempts:)]) {
                        failCount = [self.delegate passcodeViewControllerNumberOfFailedAttempts:self];
                    }
                    
                    [self showFailedAttemptsCount:failCount inputView:aInputView];
                    
                    // reset entered passcode
                    aInputView.passcode = nil;
                    
                    // shake
                    self.viewShaker = [[AFViewShaker alloc] initWithView:aInputView.passcodeField];
                    [self.viewShaker shakeWithDuration:0.5f completion:nil];
                    
                    
                    // lock if needed
                    if ([self.delegate respondsToSelector:@selector(passcodeViewControllerLockUntilDate:)]) {
                        NSDate *lockUntilDate = [self.delegate passcodeViewControllerLockUntilDate:self];
                        if (lockUntilDate != nil) {
                            [self showLockMessageWithLockUntilDate:lockUntilDate];
                        }
                    }
                    
                }
            }];
            
            break;
        }
        case BKPasscodeViewControllerStateInputPassword:
        {
            if (self.type == BKPasscodeViewControllerChangePasscodeType && [self.oldPasscode isEqualToString:passcode]) {
                
                aInputView.passcode = nil;
                aInputView.message = NSLocalizedStringFromTable(localizationReuse, @"BKPasscodeView", @"다른 암호를 입력하십시오. 동일한 암호를 다시 사용할 수 없습니다.");
                
            } else {
                
                self.theNewPasscode = passcode;
                self.currentState = BKPasscodeViewControllerStateReinputPassword;
                
                BKPasscodeInputView *newPasscodeInputView = [self.passcodeInputView copy];
                
                [self customizePasscodeInputView:newPasscodeInputView];
                
                [self updatePasscodeInputViewTitle:newPasscodeInputView];
                [self.shiftingView showView:newPasscodeInputView withDirection:BKShiftingDirectionForward];
                
                [self.passcodeInputView becomeFirstResponder];
            }
            
            break;
        }
        case BKPasscodeViewControllerStateReinputPassword:
        {
            if ([passcode isEqualToString:self.theNewPasscode]) {
                
                if (self.touchIDManager && [BKTouchIDManager canUseTouchID])
                {
                    if (![[NSFileManager defaultManager] fileExistsAtPath:passcodePath])
                    {
                        passcodeF = [NSMutableDictionary new];
                        NSString *key = @"here encrypt key";
                        NSString *passcodeEncrypted = [FBEncryptorAES encryptBase64String:passcode keyString:key separateLines:YES];
                        passcodeF = [NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil];
                        //[passcodeF addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil]];
                        [passcodeF writeToFile:passcodePath atomically:NO];
                        //[self showTouchIDSwitchView];
                    }
                    else
                    {
                        NSString *key = @"here encrypt key";
                        NSString *passcodeEncrypted = [FBEncryptorAES encryptBase64String:passcode keyString:key separateLines:YES];
                        passcodeF = [NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil];
                        //[passcodeF addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil]];
                        [passcodeF writeToFile:passcodePath atomically:NO];
                        //[self showTouchIDSwitchView];
                    }
                    [self showTouchIDSwitchView];
                } else {
                    [self.delegate passcodeViewController:self didFinishWithPasscode:passcode];
                    //passcodeF = [NSMutableDictionary dictionaryWithObjectsAndKeys:passcode, @"Passcode", nil];
                    if (![[NSFileManager defaultManager] fileExistsAtPath:passcodePath])
                    {
                        passcodeF = [NSMutableDictionary new];
                        NSString *key = @"here encrypt key";
                        NSString *passcodeEncrypted = [FBEncryptorAES encryptBase64String:passcode keyString:key separateLines:YES];
                        passcodeF = [NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil];
                        //[passcodeF addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil]];
                        [passcodeF writeToFile:passcodePath atomically:NO];
                    }
                    else
                    {
                        NSString *key = @"here encrypt key";
                        NSString *passcodeEncrypted = [FBEncryptorAES encryptBase64String:passcode keyString:key separateLines:YES];
                        passcodeF = [NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil];
                        //[passcodeF addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:passcodeEncrypted, @"Passcode", nil]];
                        [passcodeF writeToFile:passcodePath atomically:NO];
                    }
                }
                
            } else {
                
                self.currentState = BKPasscodeViewControllerStateInputPassword;
                
                BKPasscodeInputView *newPasscodeInputView = [self.passcodeInputView copy];
                
                [self customizePasscodeInputView:newPasscodeInputView];
                
                [self updatePasscodeInputViewTitle:newPasscodeInputView];
                
                newPasscodeInputView.message = NSLocalizedStringFromTable(localizationDontMatch, @"BKPasscodeView", @"암호가 일치하지 않습니다.\n다시 시도하십시오.");
                
                [self.shiftingView showView:newPasscodeInputView withDirection:BKShiftingDirectionBackward];
                
                [self.passcodeInputView becomeFirstResponder];
                
                //[self showTouchIDSwitchView];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - BKTouchIDSwitchViewDelegate

- (void)touchIDSwitchViewDidPressDoneButton:(BKTouchIDSwitchView *)view
{
    BOOL enabled = view.touchIDSwitch.isOn;
    
    if (enabled)
    {
        [self.touchIDManager savePasscode:self.theNewPasscode completionBlock:^(BOOL success) {
            if (success) {
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsBundleFile];
                [settings setValue:@YES forKey:@"sTouchID"];
                [settings writeToFile:prefsBundleFile atomically:NO];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate passcodeViewController:self didFinishWithPasscode:self.theNewPasscode];
                /*
            } else {
                if ([self.delegate respondsToSelector:@selector(passcodeViewControllerDidFailTouchIDKeychainOperation:)]) {
                    [self.delegate passcodeViewControllerDidFailTouchIDKeychainOperation:self];
                }
                 */
            }
        }];
        
    } 
    else
    {
        
        [self.touchIDManager deletePasscodeWithCompletionBlock:^(BOOL success) {
            if (success) {
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsBundleFile];
                [settings setValue:@NO forKey:@"sTouchID"];
                [settings writeToFile:prefsBundleFile atomically:NO];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate passcodeViewController:self didFinishWithPasscode:self.theNewPasscode];
            } /*
               else {
                if ([self.delegate respondsToSelector:@selector(passcodeViewControllerDidFailTouchIDKeychainOperation:)]) {
                    [self.delegate passcodeViewControllerDidFailTouchIDKeychainOperation:self];
                }
            }*/
        }];
        
    }
}

#pragma mark - Notifications

- (void)didReceiveKeyboardWillShowHideNotification:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        self.keyboardHeight = UIInterfaceOrientationIsPortrait(statusBarOrientation) ? CGRectGetHeight(keyboardRect) : CGRectGetWidth(keyboardRect);
    } else {
        self.keyboardHeight = CGRectGetHeight(keyboardRect);
    }
    
    [self.view setNeedsLayout];
}

- (void)didReceiveApplicationWillEnterForegroundNotification:(NSNotification *)notification
{
    [self startTouchIDAuthenticationIfPossible];
}

@end
