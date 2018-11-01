#import "vkpreferencesbundle/VKPrefsPasscode.h"
/*
#import "Passcode/BKPasscodeField.h"
#import "Passcode/BKPasscodeInputView.h"
#import "Passcode/BKPasscodeViewController.h"
#import "Passcode/BKShiftingView.h"
#import "Passcode/BKPasscodeLockScreenManager.h"
#import "Passcode/BKPasscodeDummyViewController.h"
#import "Passcode/BKTouchIDManager.h"
#import "Passcode/BKTouchIDSwitchView.h"

/
#import "PasscodeNew/DMKeychain.h"
#import "PasscodeNew/DMPasscode.h"
#import "PasscodeNew/DMPasscodeConfig.h"
#import "PasscodeNew/DMPasscodeInternalField.h"
#import "PasscodeNew/DMPasscodeInternalNavigationController.h"
#import "PasscodeNew/DMPasscodeInternalViewController.h"

//#import "LTHPasscodeViewController/LTHKeychainUtils.h"
//#import "LTHPasscodeViewController/LTHPasscodeViewController.h"
//#import "LockScreenViewController/JKLLockScreenNumber.h"
//#import "LockScreenViewController/JKLLockScreenPincodeView.h"
//#import "LockScreenViewController/JKLLockScreenViewController.h"

//LTHPasscodeViewController/LTHKeychainUtils.m LTHPasscodeViewController/LTHPasscodeViewController.m


#import <Preferences/Preferences.h>
#import <Preferences/PSViewController.h>
#import <Preferences/PSDetailController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <sys/utsname.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
//#import "Passcode/LTHPasscodeViewController.h"
//#import "Passcode/LTHKeychainUtils.h"
#import <UIKit/UIViewController.h>
#import "Passcode/FBEncryptorAES.h"
#import "Passcode/NSData+Base64.h"
/////////////////////////////////////////////
///////////////VKHD APP NON-JB///////////////
/////////////////////////////////////////////
//#define passcodePath [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpasscode.plist"]
//#define settingsPath [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpreferencesbundle.plist"]
/////////////////////////////////////////////
/////////////////VKHD APP JB/////////////////
/////////////////////////////////////////////
#define passcodePath @"/var/mobile/Library/Preferences/ru.anonz.vkpasscode.plist"
#define settingsPath @"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"

//Passcode/APPinViewController.m Passcode/BKPasscodeField.m Passcode/BKPasscodeInputView.m Passcode/BKPasscodeViewController.m Passcode/AFViewShaker.m Passcode/BKShiftingView.m VKPrefsPasscode.mm

extern NSString *const BKPasscodeKeychainServiceName;
@interface VKPrefsPasscode : PSViewController <BKPasscodeViewControllerDelegate>
@property (strong, nonatomic) NSString          *passcode;
@property (nonatomic) NSUInteger                failedAttempts;
@property (strong, nonatomic) NSDate            *lockUntilDate;
@property (strong, retain) NSMutableDictionary *passcodeFile;
@property (assign) BOOL deletePasscode;
@property (nonatomic, assign) BOOL disablePasscode;
@property (nonatomic, assign) BOOL disableVKPasscode;
//+(NSString *)passcode;
+(VKPrefsPasscode *) sharedInstance;
//+(void)passcodeSettings;
-(id)checkDisablePINVC;
-(id)checkDisableVKPINVC;
-(id)setPINVC;
-(id)changePINVC;
-(id)checkPINVC;
-(id)deletePINVC;
@end*/