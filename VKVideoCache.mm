#import "VKVideoCache.h"

@implementation VKVideoCache

+(VKVideoCache *) sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&p, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(void)viewDidLoad
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [super viewDidLoad];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = 1;
    tableView.allowsSelectionDuringEditing = NO;
    self.view = tableView;
}


@end
// vim:ft=objc
