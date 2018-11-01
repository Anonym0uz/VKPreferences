#import "VKAccounts.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
/////////////////////////////////////////////
///////////////VKHD APP NON-JB///////////////
/////////////////////////////////////////////
//#define prefsAccounts [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkaccounts.plist"]
//#define prefsFile [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpreferencesbundle.plist"]
/////////////////////////////////////////////
/////////////////VKHD APP JB/////////////////
/////////////////////////////////////////////
#define prefsAccounts @"/var/mobile/Library/Preferences/ru.anonz.vkaccounts.plist"
#define testPrefs @"/var/mobile/Library/Preferences/ru.anonz.vkaccountstest.plist"
#define prefsFile @"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"

#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES256

@implementation VKAccounts
int numA2 = 0;
int row;
UITextField *textField;
UITextField *textField2;
UITextField *textField3;
NSMutableArray *root;
NSMutableDictionary *dict;
NSMutableDictionary *passcodeFile;
NSMutableDictionary *accounts;
NSMutableDictionary *accountsTest;
NSIndexPath *selectIndexPath;
@synthesize all;
- (void)loadPrefs
{
    
    root = [[NSMutableArray alloc] initWithContentsOfFile:prefsAccounts];
    
    dict = [[NSMutableDictionary alloc] init];
    
    accounts = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsAccounts];
    
    accountsTest = [[NSMutableDictionary alloc] initWithContentsOfFile:testPrefs];
}

static void loadAccounts()
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:prefsAccounts])
    {
        //NSLog(@"Accounts file created!");
        accounts = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsAccounts];
        [accounts writeToFile:prefsAccounts atomically:NO];
        accountsTest = [[NSMutableDictionary alloc] initWithContentsOfFile:testPrefs];
        [accountsTest writeToFile:testPrefs atomically:NO];
    }
    //NSLog(@"Accounts already exists! Reloading accounts...");
    root = [[NSMutableArray alloc] initWithContentsOfFile:prefsAccounts];
    [root writeToFile:prefsAccounts atomically:NO];
    accountsTest = [[NSMutableDictionary alloc] initWithContentsOfFile:testPrefs];
    [accountsTest writeToFile:testPrefs atomically:NO];
}

static void loadPasscode()
{
    passcodeFile = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodePath];
    //if (![[NSFileManager defaultManager] fileExistsAtPath:passcodePath])
    //{
    //    passcodeFile = [NSMutableDictionary new];
    //    [passcodeFile writeToFile:passcodePath atomically:NO];
    //}
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
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
    if([[settings objectForKey:@"sPINEnabled"] boolValue])
    {
        loadPasscode();
        BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
        //LTHPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] setPIN];
        //LTHPasscodeViewController *viewController = [LTHPasscodeViewController new];
        //[self showLockViewForEnablingPasscode];
        //[self presentModalViewController:viewController withTransition:1];
        [self setRootController: [self rootController]];
        [self setParentController: [self parentController]];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        //UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setCancelPIN:)];
        //[viewController.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:cancelButton, nil]];
        [self presentViewController:navController animated:YES completion:nil];
        //[viewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self loadPrefs];
    
    loadAccounts();
    
    //accounts = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsAccounts];
    
    [super viewDidLoad];
    NSString *localizationTitle;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationTitle = @"Меню аккаунтов";
    } else {
        localizationTitle = @"Accounts menu";
    }
    [self.navigationItem setTitle:localizationTitle];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    UIBarButtonItem *addsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addsAccount)];
    //UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setEditing:)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setEdit:)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:editButton, addsButton, nil]];
    
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = 1;
    //tableView.editing = YES;
    tableView.allowsSelectionDuringEditing = NO;
    //tableView.longPressReorderEnabled = YES;
    self.view = tableView;
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
    
    //avz.alertViewStyle = UIAlertViewStylePlainTextInput;
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
    
    
    // textField.placeholder=@" Account name";
    //textField2.placeholder=@" VK Login";
    //textField3.placeholder=@" Password";
    
    [view addSubview:accName];
    [view addSubview:username];
    [view addSubview:password];
    view.backgroundColor = [UIColor clearColor];
    [av setValue:view forKey:@"accessoryView"];
    [av show];
    /*
    NSString *localizationMessage;
    NSString *localizationCancelBtn;
    NSString *localizationOtherBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationMessage = @"Введите название аккаунта.";
        localizationCancelBtn = @"Отмена";
        localizationOtherBtn = @"OK";
    } else {
        localizationMessage = @"Enter account name or yourself name.";
        localizationCancelBtn = @"Cancel";
        localizationOtherBtn = @"OK";
    }
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"VK Preferences"
                                                 message:localizationMessage
                                                delegate:self
                                       cancelButtonTitle:localizationCancelBtn
                       
                                       otherButtonTitles:localizationOtherBtn, nil];
    
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    av.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == alertView.firstOtherButtonIndex)
        {
            NSString *localizationMessage;
            NSString *localizationCancelBtn;
            NSString *localizationOtherBtn;
            NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
            if ([language isEqualToString:@"ru"]) {
                localizationMessage = @"Введите E-Mail(или телефон) и пароль от страницы в VK";
                localizationCancelBtn = @"Отмена";
                localizationOtherBtn = @"OK";
            } else {
                localizationMessage = @"Enter e-mail(phone) and password from your page in VK";
                localizationCancelBtn = @"Cancel";
                localizationOtherBtn = @"OK";
            }
            
            UITextField *accName = [alertView textFieldAtIndex:0];
            
            UIAlertView *av2 = [[UIAlertView alloc] initWithTitle:@"VK Preferences"
                                                          message:localizationMessage
                                                         delegate:self
                                                cancelButtonTitle:localizationCancelBtn
                                                otherButtonTitles:localizationOtherBtn, nil];
            
            av2.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [[av2 textFieldAtIndex:1] setSecureTextEntry:NO];
            
            av2.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == alertView.firstOtherButtonIndex) {
                    UITextField *username = [alertView textFieldAtIndex:0];
                    
                    UITextField *password = [alertView textFieldAtIndex:1];
                    
                    NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
                    NSString* usernameEncrypted = [FBEncryptorAES encryptBase64String:username.text keyString:key separateLines:YES];
                    NSString* passwordEncrypted = [FBEncryptorAES encryptBase64String:password.text keyString:key separateLines:YES];
                    [root addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameEncrypted, @"Login", passwordEncrypted, @"Password", accName.text, @"Name", nil]];
                    [root writeToFile:prefsAccounts atomically:NO];
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[accounts count]] withRowAnimation:UITableViewRowAnimationFade];
                    
                }
                else if (buttonIndex == alertView.cancelButtonIndex)
                {

                }
            };
            
            av2.shouldEnableFirstOtherButtonBlock = ^BOOL(UIAlertView *alertView) {
                return ([[[alertView textFieldAtIndex:1] text] length] > 0);
            };
            
            [av2 show];
        }
        else if (buttonIndex == alertView.cancelButtonIndex)
        {
            
        }
    };
    
    av.shouldEnableFirstOtherButtonBlock = ^BOOL(UIAlertView *alertView) {
        return ([[[alertView textFieldAtIndex:0] text] length] > 0);
    };
    
    [av show];
     */
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
                               numA2 = row;
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
    return @[ deleteAction ];//, configureAction ];
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
    row = indexPath.row;
    if (row)
    {
        [cell setSelected:YES animated:NO];
        [cell setHighlighted:YES animated:NO];
    }
    else if (!row)
    {
        [cell setSelected:NO animated:NO];
        [cell setHighlighted:NO animated:NO];
    }
    if (row >= 0)
    {
        numA2 = row;
        [self editAccount];
    }
        
}

- (void)editAccount
{
    
    NSString *name = [[root objectAtIndex:numA2] objectForKey:@"Name"];
    NSString *login = [[root objectAtIndex:numA2] objectForKey:@"Login"];
    NSString *passwords = [[root objectAtIndex:numA2] objectForKey:@"Password"];
    
    NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
    NSString *usernameDecrypted = [FBEncryptorAES decryptBase64String:login keyString:key];
    NSString *passwordDecrypted = [FBEncryptorAES decryptBase64String:passwords keyString:key];
    
    /*
    NSString *localizationName;
    NSString *localizationLogin;
    NSString *localizationPassword;
    NSString *localizationSaveBtn;
    NSString *localizationCancelBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationName = @"Имя:";
        localizationLogin = @"Логин:";
        localizationPassword = @"Пароль:";
        localizationSaveBtn = @"Сохранить";
        localizationCancelBtn = @"Отменить";
    } else {
        localizationName = @"Name:";
        localizationLogin = @"Login:";
        localizationPassword = @"Password:";
        localizationSaveBtn = @"Save";
        localizationCancelBtn = @"Cancel";
    }
    */
    
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
    
    //avz.alertViewStyle = UIAlertViewStylePlainTextInput;
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
            numA2 = row;
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
    
    
    // textField.placeholder=@" Account name";
    //textField2.placeholder=@" VK Login";
    //textField3.placeholder=@" Password";
    
    [view addSubview:textField];
    [view addSubview:textField2];
    [view addSubview:textField3];
    view.backgroundColor = [UIColor clearColor];
    [avz setValue:view forKey:@"accessoryView"];
    [avz show];
    
    
    
    /*
    [UIAlertView showWithTitle:@"VK Preferences"
                       message:@""
             cancelButtonTitle:@"234"
             otherButtonTitles:nil//@[localizationOtherBtn]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex])
                          {
                              
                          }
     
                          else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn]) {
                              [[VKPreferences sharedInstance] saveSettings];
                              id request = [[objc_getClass("account_setOffline_req") alloc] init];
                              id controller = [objc_getClass("VKAPIController") sharedInstance];
                              [controller sendRequest:request];
                              [switchView setOn:YES animated:NO];
                              [settings setValue:@YES forKey:@"sOffline"];
                              [settings writeToFile:prefsFile atomically:NO];
                          }
     }];
     */
    
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"VKPreferences" message:@"Change name, login and password." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
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
     
    
   // textField.placeholder=@" Account name";
    //textField2.placeholder=@" VK Login";
    //textField3.placeholder=@" Password";
    
    [view addSubview:textField];
    [view addSubview:textField2];
    [view addSubview:textField3];
    [alertView setValue:view forKey:@"accessoryView"];
    view.backgroundColor = [UIColor clearColor];
    [alertView show];
     
     */
    
    /*
    NSString *name = [[root objectAtIndex:numA2] objectForKey:@"Name"];
    NSString *login = [[root objectAtIndex:numA2] objectForKey:@"Login"];
    NSString *passwords = [[root objectAtIndex:numA2] objectForKey:@"Password"];
    
    NSString *localizationName;
    NSString *localizationLogin;
    NSString *localizationPassword;
    NSString *localizationSaveBtn;
    NSString *localizationCancelBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationName = @"Имя:";
        localizationLogin = @"Логин:";
        localizationPassword = @"Пароль:";
        localizationSaveBtn = @"Сохранить";
        localizationCancelBtn = @"Отменить";
    } else {
        localizationName = @"Name:";
        localizationLogin = @"Login:";
        localizationPassword = @"Password:";
        localizationSaveBtn = @"Save";
        localizationCancelBtn = @"Cancel";
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 240, 40)];
    
    [title setTextColor:[UIColor blackColor]];
    [title setText:@"VKPreferences"];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont systemFontOfSize:17]];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, 240, 40)];
    
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setText:localizationName];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[UIFont systemFontOfSize:15]];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 140, 240, 40)];
    
    [loginLabel setTextColor:[UIColor blackColor]];
    [loginLabel setText:localizationLogin];
    [loginLabel setBackgroundColor:[UIColor clearColor]];
    [loginLabel setFont:[UIFont systemFontOfSize:15]];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 210, 240, 40)];
    
    [passwordLabel setTextColor:[UIColor blackColor]];
    [passwordLabel setText:localizationPassword];
    [passwordLabel setBackgroundColor:[UIColor clearColor]];
    [passwordLabel setFont:[UIFont systemFontOfSize:15]];
    
    
    UIView *myCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 280, 350)];
    [myCustomView setBackgroundColor:[UIColor colorWithRed:23.0f green:23.0f blue:23.0f alpha:0.9f]];
    [myCustomView setAlpha:0.0f];
    
    myCustomView.center = CGPointMake(self.view.frame.size.width  / 2,
                                      self.view.frame.size.height / 2);
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dismissButton addTarget:self action:@selector(dismissCustomView:) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton setTitle:localizationCancelBtn forState:UIControlStateNormal];
    [dismissButton setFrame:CGRectMake(90, 300, 240, 40)];
    [myCustomView addSubview:dismissButton];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton addTarget:self action:@selector(saveCustomView:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:localizationSaveBtn forState:UIControlStateNormal];
    [saveButton setFrame:CGRectMake(0, 300, 150, 40)];
    [myCustomView addSubview:saveButton];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 240, 35)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [myCustomView addSubview:textField];
    
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(20, 170, 240, 35)];
    [textField2 setBorderStyle:UITextBorderStyleRoundedRect];
    [myCustomView addSubview:textField2];
    
    textField3 = [[UITextField alloc] initWithFrame:CGRectMake(20, 240, 240, 35)];
    [textField3 setBorderStyle:UITextBorderStyleRoundedRect];
    [myCustomView addSubview:textField3];
    
    NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
    NSString* usernameDecrypted = [FBEncryptorAES decryptBase64String:login keyString:key];
    NSString* passwordDecrypted = [FBEncryptorAES decryptBase64String:passwords keyString:key];
    
    textField.text = name;
    textField2.text = usernameDecrypted;
    textField3.text = passwordDecrypted;
    
    [myCustomView addSubview:title];
    [myCustomView addSubview:nameLabel];
    [myCustomView addSubview:loginLabel];
    [myCustomView addSubview:passwordLabel];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:myCustomView];
    
    [UIView animateWithDuration:0.2f animations:^{
        [myCustomView setAlpha:1.0f];
    }];
     */
}
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        if (row >= 0)
        {
            numA2 = row;
            [root removeObjectAtIndex:numA2];
            NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
            NSString* usernameEncrypted = [FBEncryptorAES encryptBase64String:textField2.text keyString:key separateLines:YES];
            NSString* passwordEncrypted = [FBEncryptorAES encryptBase64String:textField3.text keyString:key separateLines:YES];
            [root addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameEncrypted, @"Login", passwordEncrypted, @"Password", textField.text, @"Name", nil]];
            [root writeToFile:prefsAccounts atomically:NO];
            [self.tableView reloadData];
        }
    }
    else
    {
        if (row >= 0)
        {
            numA2 = row;
            [root removeObjectAtIndex:numA2];
            NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
            NSString* usernameEncrypted = [FBEncryptorAES encryptBase64String:textField2.text keyString:key separateLines:YES];
            NSString* passwordEncrypted = [FBEncryptorAES encryptBase64String:textField3.text keyString:key separateLines:YES];
            [root addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameEncrypted, @"Login", passwordEncrypted, @"Password", textField.text, @"Name", nil]];
            [root writeToFile:prefsAccounts atomically:NO];
            [self.tableView reloadData];
        }
    }
}
*/
/*
- (void)dismissCustomView:(UIButton *)sender
{
    [UIView animateWithDuration:0.2f animations:^{
        [sender.superview setAlpha:0.0f];
    }completion:^(BOOL done){
        self.view.userInteractionEnabled = YES;
        self.view.backgroundColor = [UIColor colorWithRed:240.0f green:239.0f blue:245.0f alpha:0.85f];
        [sender.superview removeFromSuperview];
    }];
}
*/
- (void)saveCustomView:(UIButton *)sender
{
    if (row >= 0)
    {
        numA2 = row;
        [root removeObjectAtIndex:numA2];
        NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
        NSString* usernameEncrypted = [FBEncryptorAES encryptBase64String:textField2.text keyString:key separateLines:YES];
        NSString* passwordEncrypted = [FBEncryptorAES encryptBase64String:textField3.text keyString:key separateLines:YES];
        [root addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameEncrypted, @"Login", passwordEncrypted, @"Password", textField.text, @"Name", nil]];
        [root writeToFile:prefsAccounts atomically:NO];
        [self.tableView reloadData];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        [sender.superview setAlpha:0.0f];
    }completion:^(BOOL done){
        self.view.userInteractionEnabled = YES;
        self.view.backgroundColor = [UIColor colorWithRed:240.0f green:239.0f blue:245.0f alpha:0.85f];
        [sender.superview removeFromSuperview];
    }];
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
    
    if (row >= 0)
    {
        numA2 = row;
    }
    
    NSDictionary *dict2 = [root objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict2 objectForKey: @"Name"];
    cell.showsReorderControl = YES;
    cell.editing = YES;
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
