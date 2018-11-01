#import "VKAccounts.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES256

@implementation VKAccounts
int numA2 = 0;
int rowAcc;
UITextField *textField;
UITextField *textField2;
UITextField *textField3;
NSMutableArray *root;
NSMutableDictionary *dict;
NSMutableDictionary *passcodeFile;
NSMutableDictionary *accounts;
NSIndexPath *selectIndexPath;
@synthesize all;
- (void)loadPrefs
{
    
    root = [[NSMutableArray alloc] initWithContentsOfFile:prefsAccounts];
    
    dict = [[NSMutableDictionary alloc] init];
    
    accounts = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsAccounts];
}

static void loadAccounts()
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:prefsAccounts])
    {
        accounts = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsAccounts];
        [accounts writeToFile:prefsAccounts atomically:NO];
    }
    root = [[NSMutableArray alloc] initWithContentsOfFile:prefsAccounts];
    [root writeToFile:prefsAccounts atomically:NO];
}

static void loadPasscode()
{
    passcodeFile = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodePath];
}
-(void)loadAccounts
{
    root = [[NSMutableArray alloc] initWithContentsOfFile:prefsAccounts];
}

-(void)saveAccounts
{
    [root writeToFile:prefsAccounts atomically:NO];
}

-(void)reloadPrefs
{
    [self loadPrefs];
    [root writeToFile:prefsAccounts atomically:NO];
}

-(void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
    if([[settings objectForKey:@"sPINEnabled"] boolValue])
    {
        loadPasscode();
        BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
        [self setRootController: [self rootController]];
        [self setParentController: [self parentController]];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
    
    [self loadPrefs];
    
    loadAccounts();
    
    
    [super viewDidLoad];
    NSString *localizationTitle;
    NSString *closeVC;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationTitle = @"Меню аккаунтов";
        closeVC = @"Закрыть";
    } else {
        localizationTitle = @"Accounts menu";
        closeVC = @"Close";
    }
    [self.navigationItem setTitle:localizationTitle];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    UIBarButtonItem *addsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addsAccount)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setEdit:)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:editButton, addsButton, nil]];
    
    /*
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                   initWithTitle:closeVC
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(closeView:)];
    self.navigationItem.leftBarButtonItem = closeButton;
    */
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = 1;
    tableView.allowsSelectionDuringEditing = NO;
    self.view = tableView;
}

-(void)closeView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setEdit:(id)sender
{
    NSString *localizationCancelBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationCancelBtn = @"Сохранить";
    } else {
        localizationCancelBtn = @"Save";
    }
    
    UIBarButtonItem *saveButton =
    [[[UIBarButtonItem alloc]
      initWithTitle:localizationCancelBtn
      style:UIBarButtonItemStyleDone
      target:self
      action:@selector(save:)]
     autorelease];
    [self.navigationItem setRightBarButtonItem:saveButton animated:NO];
    [self.tableView setEditing:YES animated:YES];
}

- (void)save:(id)sender
{
    NSString *localizationCancelBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationCancelBtn = @"Изменить";
    } else {
        localizationCancelBtn = @"Edit";
    }
    UIBarButtonItem *editButton =
    [[[UIBarButtonItem alloc]
      initWithTitle:localizationCancelBtn
      style:UIBarButtonItemStylePlain
      target:self
      action:@selector(setEdit:)]
     autorelease];
    [self.navigationItem setRightBarButtonItem:editButton animated:NO];
    [root writeToFile:prefsAccounts atomically:NO];
    [self.tableView setEditing:NO animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    if (editing) {
        [self.tableView setEditing:YES animated:YES];
        
    } else {
        [self.tableView setEditing:NO animated:YES];
    }
}

- (void)addsAccount
{
    [self loadPrefs];
    NSString *localizationMessage;
    NSString *localizationCancelBtn;
    NSString *localizationOtherBtn;
    NSString *placeholderAcc;
    NSString *placeholderUser;
    NSString *placeholderPass;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationMessage = @"Введите имя аккаунта, E-Mail(или телефон) и пароль от страницы в VK";
        localizationCancelBtn = @"Отмена";
        localizationOtherBtn = @"OK";
        placeholderAcc = @" Имя аккаунта";
        placeholderUser = @" Логин";
        placeholderPass = @" Пароль";
    }
    else
    {
        localizationMessage = @"Enter account name, e-mail(or phone) and password from your page in VK";
        localizationCancelBtn = @"Cancel";
        localizationOtherBtn = @"OK";
        placeholderAcc = @" Account name";
        placeholderUser = @" Login";
        placeholderPass = @" Password";
    }
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"VKPreferences"
                                                 message:localizationMessage
                                                delegate:self
                                       cancelButtonTitle:localizationCancelBtn
                       
                                       otherButtonTitles:localizationOtherBtn, nil];
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 600);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UITextField* accName = [[UITextField alloc] initWithFrame: CGRectMake(10, 10, 250, 30)];
    accName.backgroundColor=[UIColor whiteColor];
    
    UITextField* username = [[UITextField alloc] initWithFrame: CGRectMake(10, 45, 250, 30)];
    username.backgroundColor=[UIColor whiteColor];
    
    UITextField* password = [[UITextField alloc] initWithFrame: CGRectMake(10, 80, 250, 30)];
    password.backgroundColor=[UIColor whiteColor];
    
    accName.layer.borderColor=[UIColor lightGrayColor].CGColor;
    accName.layer.borderWidth=1;
    
    username.layer.borderColor=[UIColor lightGrayColor].CGColor;
    username.layer.borderWidth=1;
    
    password.layer.borderColor=[UIColor lightGrayColor].CGColor;
    password.layer.borderWidth=1;
    
    accName.placeholder = placeholderAcc;
    username.placeholder = placeholderUser;
    password.placeholder = placeholderPass;
    
    av.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex)
    {
        if (buttonIndex == alertView.firstOtherButtonIndex)
        {
            NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
            NSString* usernameEncrypted = [FBEncryptorAES encryptBase64String:username.text keyString:key separateLines:YES];
            NSString* passwordEncrypted = [FBEncryptorAES encryptBase64String:password.text keyString:key separateLines:YES];
            [root addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameEncrypted, @"Login", passwordEncrypted, @"Password", accName.text, @"Name", nil]];
            [root writeToFile:prefsAccounts atomically:NO];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[accounts count]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }
        else if (buttonIndex == alertView.cancelButtonIndex)
        {
            
        }
        av.shouldEnableFirstOtherButtonBlock = ^BOOL(UIAlertView *alertView)
        {
            return ([password.text length] > 0);
        };
    };
    
    [view addSubview:accName];
    [view addSubview:username];
    [view addSubview:password];
    view.backgroundColor = [UIColor clearColor];
    [av setValue:view forKey:@"accessoryView"];
    [av show];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *configureAction;
    configureAction = [UITableViewRowAction
                       rowActionWithStyle:UITableViewRowActionStyleNormal
                       title:@"Настроить"
                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                       {
                           [self loadPrefs];
                           if (indexPath.row >= 0)
                           {
                               numA2 = indexPath.row;
                               [self editAccount];
                               numA2 = rowAcc;
                           }
                           [self loadPrefs];
                           [self reloadPrefs];
                       }];
    
    UITableViewRowAction *deleteAction;
    deleteAction = [UITableViewRowAction
                       rowActionWithStyle:UITableViewRowActionStyleDestructive
                       title:@"Удалить"
                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                        {
                            [self loadPrefs];
                            [tableView beginUpdates];
                            [root removeObjectAtIndex:indexPath.row];
                            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
                            [root writeToFile:prefsAccounts atomically:NO];
                            [tableView reloadData];
                            [tableView endUpdates];
                            [root writeToFile:prefsAccounts atomically:NO];
                       }];
    [self reloadPrefs];
    return @[ deleteAction, configureAction ];
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self loadPrefs];
    [tableView beginUpdates];
    [root removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    [root writeToFile:prefsAccounts atomically:NO];
    [tableView reloadData];
    [tableView endUpdates];
    [root writeToFile:prefsAccounts atomically:NO];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadAccounts];
    [tableView reloadData];
    
    [tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionNone];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    rowAcc = indexPath.row;
    if (rowAcc)
    {
        [cell setSelected:YES animated:NO];
        [cell setHighlighted:YES animated:NO];
    }
    else if (!rowAcc)
    {
        [cell setSelected:NO animated:NO];
        [cell setHighlighted:NO animated:NO];
    }
    if (rowAcc >= 0)
    {
        numA2 = rowAcc;
        [self accountChoise];
        //[self editAccount];
    }
        
}

- (void)accountChoise
{
        numA2 = rowAcc;
        id loadingLog = [[objc_getClass("LoadingViewController") sharedLoadingView] retain];
        [loadingLog showSelfInWindow];
        NSMutableArray *accsArray = [[NSMutableArray alloc] initWithContentsOfFile:prefsAccounts];
        
        NSString *login = [[accsArray objectAtIndex:numA2] objectForKey:@"Login"];
        NSString *password = [[accsArray objectAtIndex:numA2] objectForKey:@"Password"];
        
        NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
        NSString* usernameDecrypted = [FBEncryptorAES decryptBase64String:login keyString:key];
        NSString* passwordDecrypted = [FBEncryptorAES decryptBase64String:password keyString:key];
        
        id auth = [[objc_getClass("auth_login_req") alloc] init];
        [auth setPassword:passwordDecrypted];
        [auth setUsername:usernameDecrypted];
        //NSLog (@"User: %@, Password:%@",usernameDecrypted, passwordDecrypted);
        [auth setClient_id:@"3682744"];
        [auth setClient_secret:@"mY6CDUswIVdJLCD3j15n"];
        [auth setScope:@"notify,friends,photos,audio,video,docs,notes,wall,groups,messages,notifications,activity,status,pages,stats,nohttps,adsint"];
        [auth setDidFinishBlock:^(id response) {
            [[[objc_getClass("iPadLoginViewController") alloc] init] processAuthorizationResponse:response];
            //NSLog (@"============Relogin complete! Info: %@===========", response);
        }];
        id requestAuth = [[objc_getClass("VKAPIController") sharedInstance] retain];
        [requestAuth sendRequest:auth viaHTTPS:0x1];
        //BOOL reloginComplete = YES;
        //[self reloadAll];
        //[loadingLog release];
        //[requestAuth release];
        //[auth release];
        /*
        NSTimeInterval delayInSeconds = 3.0;
        NSTimeInterval delayInSecondsTwo = 7.0;
        NSTimeInterval delayInSecondsThree = 12.0;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self reloadAll];
        });
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTwo * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            
            [self reloadAll];
        });
        dispatch_time_t popTime3 = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsThree * NSEC_PER_SEC);
        dispatch_after(popTime3, dispatch_get_main_queue(), ^(void){
            
            [self reloadAll];
        });hz
         */
}

-(void)reloadAll
{
    id regDev = [[objc_getClass("account_registerDevice_req") alloc] init];
    id counts = [[objc_getClass("account_getCounters_req") alloc] init];
    id LongPoll = [[objc_getClass("messages_getLongPollHistory_req") alloc] init];
    id LongPollServer = [[objc_getClass("messages_getLongPollServer_req") alloc] init];
    id push = [[objc_getClass("account_getPushSettings_req") alloc] init];
    id controller = [[objc_getClass("VKAPIController") sharedInstance] retain];
    id messagesHist = [[objc_getClass("messages_getHistory_req") alloc] init];
    id getWall = [[objc_getClass("wall_get_req") alloc] init];
    id getMess = [[objc_getClass("messages_get_req") alloc] init];
    id getNews = [[objc_getClass("newsfeed_get_req") alloc] init];
    id getsLongPoll = [[objc_getClass("MessagesController") sharedInstance] retain];
    id mainR = [[objc_getClass("iPadMainViewController") sharedInstance] retain];
    [mainR reloadData];
    [getsLongPoll connectToLongPollServer];
    [getsLongPoll getLongPollServer];
    [getsLongPoll currentLoadingDialogsInProgress];
    [getsLongPoll reloadAllDialogs];
    [getsLongPoll updateUnreadMessages];
    //id getsNews = [[objc_getClass("iPadNewsViewController") alloc] retain];
    //[getsNews updateButtonFired];
    //[getsNews updateNews:TRUE];
    //[getsNews updateNews];
    //id getsUM = [[objc_getClass("iPadChatViewController") alloc] retain];
    
    [controller wakeUpSession];
    [controller sendRequest:getNews];
    [controller sendRequest:messagesHist];
    [controller sendRequest:getWall];
    [controller sendRequest:getMess];
    [controller registerPush];
    [controller sendRequest:regDev];
    [controller sendRequest:counts];
    [controller sendRequest:LongPollServer];
    [controller sendRequest:LongPoll];
    [controller sendRequest:push];
    //[self.tableView reloadData];
    //[getsUM checkUnreadMessages];
    [getsLongPoll release];
    [controller release];
}

- (void)editAccount
{
    
    NSString *name = [[root objectAtIndex:numA2] objectForKey:@"Name"];
    NSString *login = [[root objectAtIndex:numA2] objectForKey:@"Login"];
    NSString *passwords = [[root objectAtIndex:numA2] objectForKey:@"Password"];
    
    NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
    NSString *usernameDecrypted = [FBEncryptorAES decryptBase64String:login keyString:key];
    NSString *passwordDecrypted = [FBEncryptorAES decryptBase64String:passwords keyString:key];
    
    NSString *localizationMessage;
    NSString *localizationCancelBtn;
    NSString *localizationOtherBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationMessage = @"Изменение данных аккаунта (Название, логин, пароль).";
        localizationCancelBtn = @"Отмена";
        localizationOtherBtn = @"Сохранить";
    } else {
        localizationMessage = @"Change account data (name, login, password).";
        localizationCancelBtn = @"Cancel";
        localizationOtherBtn = @"Save";
    }
    
    UIAlertView *avz = [[UIAlertView alloc] initWithTitle:@"VKPreferences"
                                                 message:localizationMessage
                                                delegate:self
                                       cancelButtonTitle:localizationCancelBtn
                       
                                       otherButtonTitles:localizationOtherBtn, nil];
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 600);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UITextField* textField = [[UITextField alloc] initWithFrame: CGRectMake(10, 10, 250, 30)];
    textField.backgroundColor=[UIColor whiteColor];
    UITextField* textField2 = [[UITextField alloc] initWithFrame: CGRectMake(10, 45, 250, 30)];
    textField2.backgroundColor=[UIColor whiteColor];
    UITextField* textField3 = [[UITextField alloc] initWithFrame: CGRectMake(10, 80, 250, 30)];
    textField3.backgroundColor=[UIColor whiteColor];
    textField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textField.layer.borderWidth=1;
    textField2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textField2.layer.borderWidth=1;
    textField3.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textField3.layer.borderWidth=1;
    
    textField.text = name;
    textField2.text = usernameDecrypted;
    textField3.text = passwordDecrypted;
    
    avz.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == alertView.firstOtherButtonIndex)
        {
            numA2 = rowAcc;
            [root removeObjectAtIndex:numA2];
            NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
            NSString* usernameEncrypted = [FBEncryptorAES encryptBase64String:textField2.text keyString:key separateLines:YES];
            NSString* passwordEncrypted = [FBEncryptorAES encryptBase64String:textField3.text keyString:key separateLines:YES];
            [root addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameEncrypted, @"Login", passwordEncrypted, @"Password", textField.text, @"Name", nil]];
            [root writeToFile:prefsAccounts atomically:NO];
            [self.tableView reloadData];
        }
        else if (buttonIndex == alertView.cancelButtonIndex)
        {
            
        }
    };
    
    [view addSubview:textField];
    [view addSubview:textField2];
    [view addSubview:textField3];
    view.backgroundColor = [UIColor clearColor];
    [avz setValue:view forKey:@"accessoryView"];
    [avz show];
}

-(UITableView*)tableView
{
    [self loadPrefs];
    loadAccounts();
    return (UITableView*)self.view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [root count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self loadPrefs];
    [self reloadPrefs];
    loadAccounts();
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        loadAccounts();
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (rowAcc >= 0)
    {
        numA2 = rowAcc;
    }
    
    NSDictionary *dict2 = [root objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict2 objectForKey: @"Name"];
    cell.showsReorderControl = YES;
    cell.editing = YES;
    //NON JB
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkpAccountsImage = [vkhdBundle pathForResource:@"Accounts" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkpAccountsImage];
    //JB
    //cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/OVKIcons/Accounts.png"];
    loadAccounts();
    [self reloadPrefs];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self loadPrefs];
    [self reloadPrefs];
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadPrefs];
    [self reloadPrefs];
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [root exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [root writeToFile:prefsAccounts atomically:NO];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadPrefs];
    [self reloadPrefs];
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadPrefs];
    [self reloadPrefs];
    return YES;
    
}

@end
