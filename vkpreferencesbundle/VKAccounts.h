#import <Preferences/Preferences.h>
#import <Preferences/PSViewController.h>
#import <Preferences/PSDetailController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>
#import "UIAlertView+Blocks.h"
#import "VKPrefsPasscode.h"
#import <objc/runtime.h>
#import <sys/utsname.h>
#import "../VKHDClass.h"
#import "VKPPaths.h"
//#import "Passcode/FBEncryptorAES.h"
//#import "Passcode/NSData+Base64.h"
#define RusLang [[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ru"]

@interface PSViewController (Accounts)
@property (nonatomic, retain) UIView *view;
- (void)viewDidLoad;
@end

@interface VKAccounts : PSViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *all;

@property(nonatomic) BOOL showsReorderControl;
- (void)loadAccounts;
- (void)saveAccounts;
- (IBAction)setEdit:(id)sender;
- (void)loadPrefs;
- (void)addsAccount;
- (UITableView *)tableView;
@end