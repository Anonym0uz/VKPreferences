#import <objc/runtime.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <Preferences/PSViewController.h>
#import <QuartzCore/QuartzCore.h>

@interface VKPreferencesMenu : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
+ (VKPreferencesMenu *) sharedInstance;
- (void)viewDidLoad;
- (UITableViewCell *)tableView:tableView cellForRowAtIndexPath:indexPath;
@end
