#import "../Passcode/BKPasscodeField.h"
#import "../Passcode/BKPasscodeInputView.h"
#import "../Passcode/BKPasscodeViewController.h"
#import "../Passcode/BKShiftingView.h"
#import "../Passcode/BKPasscodeLockScreenManager.h"
#import "../Passcode/BKPasscodeDummyViewController.h"
#import "../Passcode/BKTouchIDManager.h"
#import "../Passcode/BKTouchIDSwitchView.h"
#import <LocalAuthentication/LocalAuthentication.h>
//#import "../VKPreferences.h"

/*
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
*/

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
#import "../FBEncrypt/FBEncryptorAES.h"
#import "../FBEncrypt/NSData+Base64.h"
#import "VKPPaths.h"

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
@end