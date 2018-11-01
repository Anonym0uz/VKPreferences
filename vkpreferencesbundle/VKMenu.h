#import <Preferences/Preferences.h>
#import <Preferences/PSSpecifier.h>
#import "UITableView+LongPressReorder/UITableView+LongPressReorder.h"
#import "VKPPaths.h"

@interface PSViewController (Menu)
@property (nonatomic, retain) UIView *view;
- (void)viewDidLoad;
@end

@interface VKMenu : PSViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
+(VKMenu *) sharedInstance;

@property (nonatomic, strong) NSMutableArray *enabled;
@property (nonatomic, strong) NSMutableArray *disabled;

@property(nonatomic) BOOL showsReorderControl;
- (UITableView *)tableView;
@end