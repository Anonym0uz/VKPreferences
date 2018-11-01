//#import <Preferences/Preferences.h>
//Для надписи сверху, 2 библиотеки снизу.
//#import <Preferences/PSViewController.h>
//#import <Preferences/PSDetailController.h>
//#import <Preferences/PSTableCell.h>
//#import <Preferences/PSSpecifier.h>
//#import <UIKit/UIKit.h>
//#import <UIKit/UIViewController.h>
//#import "VKPrefsPasscode.h"
//For logo
#import "VKPreferencesLogo.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


//NSMutableDictionary *VKPSettings;
UISwitch *pinSwitch;
NSMutableDictionary *passcodeFDict;

/*
//Нужно для надписи сверху контроллера
@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(id)arg1;
@end
//Нужно для надписи сверху контроллера
@interface PSTableCell ()
- (id)initWithStyle:(int)style reuseIdentifier:(id)arg2;
@end
*/

//#define settingsPath @"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"
NSMutableDictionary *settings;

//@interface VKPreferencesBundleListController: PSListController {
//}
//@end


@implementation VKPreferencesBundleListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"VKPreferencesBundle" target:self] retain];
	}
	return _specifiers;
}
- (id)init {
    if (self = [super init])
    {
        
    }
    return self;
}

//Chear application cache
- (void)clearCache:(id)sender
{
    //NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString *localizationMessage;
    NSString *localizationMessage2;
    NSString *localizationAgreeBtn;
    NSString *localizationCancelBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationMessage = @"Вы действительно хотите очистить кэш приложения?\n Будет удалена музыка и прочие временные файлы. После очистки, потребуется перезагрузить приложение.";
        localizationMessage2 = @"Перезагрузить приложение.";
        localizationAgreeBtn = @"Да";
        localizationCancelBtn = @"Нет";
    } else {
        localizationMessage = @"Do you want to clear the app cache?\n Will be remotely music and other temporary files. After cleaning, application need a reboot.";
        localizationMessage2 = @"Reboot app.";
        localizationAgreeBtn = @"Yes";
        localizationCancelBtn = @"Nope";
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSString *stickersFolderPath = [documentFolderPath stringByAppendingPathComponent:@"stickers"];
    NSString *dbAudPath = [documentFolderPath stringByAppendingPathComponent:@"AudioCache.db"];
    NSString *bdPath = [documentFolderPath stringByAppendingPathComponent:@"database3.bd"];
    NSString *libraryFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/"];
    NSString *pDocumentFolderPath = [libraryFolderPath stringByAppendingPathComponent:@"Private Documents/"];
    NSString *webDataFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"WebKit/WebsiteData/LocalStorage/"];
    NSArray *sticksFileArray = [fileManager contentsOfDirectoryAtPath:stickersFolderPath error:nil];
    NSArray *pDocumentsFileArray = [fileManager contentsOfDirectoryAtPath:pDocumentFolderPath error:nil];
    NSArray *wDataFileArray = [fileManager contentsOfDirectoryAtPath:webDataFolderPath error:nil];
    
    [UIAlertView showWithTitle:@"VKPreferences"
                       message:localizationMessage
             cancelButtonTitle:localizationCancelBtn
             otherButtonTitles:@[localizationAgreeBtn]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex])
                          {
                          }
                          else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationAgreeBtn])
                          {
                              BOOL clearCompl = NO;
                              NSError *error;
                              [fileManager removeItemAtPath:dbAudPath error:&error];
                              [fileManager removeItemAtPath:bdPath error:&error];
                              for (NSString *filename in sticksFileArray)  {
                                  [fileManager removeItemAtPath:[stickersFolderPath stringByAppendingPathComponent:filename] error:NULL];
                              }
                              for (NSString *filename in pDocumentsFileArray)  {
                                  [fileManager removeItemAtPath:[pDocumentFolderPath stringByAppendingPathComponent:filename] error:NULL];
                                  clearCompl = YES;
                              }
                              for (NSString *filename in wDataFileArray)  {
                                  [fileManager removeItemAtPath:[webDataFolderPath stringByAppendingPathComponent:filename] error:NULL];
                              }
                              if (clearCompl == YES)
                              {
                                  [UIAlertView showWithTitle:@"VKPreferences"
                                                     message:localizationMessage2
                                           cancelButtonTitle:localizationAgreeBtn
                                           otherButtonTitles:nil
                                                    tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                        if (buttonIndex == [alertView cancelButtonIndex])
                                                        {
                                                            exit(0);
                                                        }
                                                    }];
                              }
                          }
                      }];
}

//Twitter Link
- (void)twitter {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=Anonym0uzOS"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=Anonym0uzOS"]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/Anonym0uzOS"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/Anonym0uzOS"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Anonym0uzOS"]];
    }
}

//Telegram OS
-(void)linkTelegramOS
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tg://resolve?domain=OneScriptVK"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tg://resolve?domain=OneScriptVK"]];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://t.me/OneScriptVK"]];
}

//VK Group Link
- (void)linkGR
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/cr0wapps"]];
}

//Создание файла настроек .plist, если его нету.
static void loadSettings()
{
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:prefsFile])
    {
        NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
        [settings writeToFile:prefsFile atomically:YES];
    }
    
}
/*
//Версия твика (В зависимости от билда)
- (NSString *)valueForSpecifierVersion:(PSSpecifier *)specifier
{
    //return @"0.9.7-only for testing";
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments:[NSArray arrayWithObjects: @"-c", @"dpkg -s ru.anonz.vkpreferences | grep 'Version'", nil]];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task launch];
    
    NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    version = [version stringByReplacingOccurrencesOfString:@"Version: " withString:@""];
    //version = [version stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return version;
}
*/
-(NSString*)tweakVersion:(PSSpecifier *)specifier
{
    return @"2.1.3";
}
-(NSString*)vkhdVersion:(PSSpecifier *)specifier
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

- (BOOL)canAuthenticateByTouchId {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        return [[[LAContext alloc] init] canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    }
    return NO;
}

- (NSString*) getExpiry:(PSSpecifier *)specifier{
    
    NSString *profilePath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    NSString *expirateDate = nil;
    // Check provisioning profile existence
    if (profilePath)
    {
        // Get hex representation
        NSData *profileData = [NSData dataWithContentsOfFile:profilePath];
        NSString *profileString = [NSString stringWithFormat:@"%@", profileData];
        
        // Remove brackets at beginning and end
        profileString = [profileString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        profileString = [profileString stringByReplacingCharactersInRange:NSMakeRange(profileString.length - 1, 1) withString:@""];
        
        // Remove spaces
        profileString = [profileString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        // Convert hex values to readable characters
        NSMutableString *profileText = [NSMutableString new];
        for (int i = 0; i < profileString.length; i += 2)
        {
            NSString *hexChar = [profileString substringWithRange:NSMakeRange(i, 2)];
            int value = 0;
            sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
            [profileText appendFormat:@"%c", (char)value];
        }
        
        // Remove whitespaces and new lines characters
        NSArray *profileWords = [profileText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //There must be a better word to search through this as a structure! Need 'date' sibling to <key>ExpirationDate</key>, or use regex
        BOOL sibling = false;
        for (NSString* word in profileWords){
            if ([word isEqualToString:@"<key>ExpirationDate</key>"]){
                //NSLog(@"Got to the key, now need the date!");
                sibling = true;
            }
            if (sibling && ([word rangeOfString:@"<date>"].location != NSNotFound)) {
                //NSLog(@"Found it, you win!");
                //NSLog(@"Expires: %@",word);
                NSString *noNeedStrings = [word stringByReplacingOccurrencesOfString:@"date" withString:@""];
                NSString *noNeedStrings1 = [noNeedStrings stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                NSString *noNeedStrings2 = [noNeedStrings1 stringByReplacingOccurrencesOfString:@"Z" withString:@""];
                NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"<>/"];
                NSString *noNeedSymbols = [[noNeedStrings2 componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
                expirateDate = [NSString stringWithFormat:@"%@",noNeedSymbols];
                return expirateDate;
            }
        }
        
    }
    
    return @"";
}

/*
- (BOOL)hasTouchID
{
    //size_t size;
    //sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    //char *model = malloc(size);
    //sysctlbyname("hw.machine", model, &size, NULL, 0);
    //NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    NSArray *touchIDModels = @[ @"iPad1,1", //iPad
                                @"iPad2,1", //iPad 2
                                @"iPad2,2",
                                @"iPad2,3",
                                @"iPad2,4",// iPad mini 1G
                                @"iPad2,5",
                                @"iPad2,5",
                                @"iPad2,7",
                                @"iPad3,1", //iPad 3
                                @"iPad3,2",
                                @"iPad3,3",
                                @"iPad3,4", //iPad 4
                                @"iPad3,5",
                                @"iPad3,6",
                                @"iPad4,1", //iPad Air
                                @"iPad4,2",
                                @"iPad4,3",
                                @"iPad4,4", //iPad mini 2
                                @"iPad4,5",
                                @"iPad4,6" ];
    
    NSString *model = [self modelIdentifier];
    
    return [touchIDModels containsObject:model];
}
 */

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)spec
{
    loadSettings();
    /*
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    NSString *key = spec.properties[@"key"];
    
    if([key isEqualToString:@"delButton"])
    {
        passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
        {
            BOOL enableCell = YES;
            UITableViewCellSelectionStyle selectionStyle = UITableViewCellSelectionStyleDefault;
            UITableViewCell *cell = [super tableView:(UITableView *)self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:22 inSection:0]];
            cell.selectionStyle = selectionStyle;
            cell.userInteractionEnabled = enableCell;
            cell.textLabel.enabled = enableCell;
            cell.detailTextLabel.enabled = enableCell;
            
            cell = [super tableView:(UITableView *)self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:22 inSection:0]];
            cell.selectionStyle = selectionStyle;
            cell.userInteractionEnabled = enableCell;
            cell.textLabel.enabled = enableCell;
            cell.detailTextLabel.enabled = enableCell;
            
            [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsFile]];
            [defaults setObject:value forKey:key];
            [defaults writeToFile:prefsFile atomically:YES];
        }
        CFStringRef toPost = (CFStringRef)spec.properties[@"PostNotification"];
        if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
        */
    if([[spec propertyForKey:@"key"] isEqualToString:@"sTouchID"])
    {
        if([value intValue] == 1)
        {
            NSString *localizationMessage;
            NSString *localizationCancelBtn;
            NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
            if ([language isEqualToString:@"ru"]) {
                localizationMessage = @"Ваше устройство не поддерживает Touch ID! Настройка выключена.";
                localizationCancelBtn = @"OK";
            } else {
                localizationMessage = @"Your device doesn't support Touch ID! Switch is off.";
                localizationCancelBtn = @"OK";
            }
            if (self.canAuthenticateByTouchId == YES)
            {
                
            }
            else if (self.canAuthenticateByTouchId == NO)
            {
                [UIAlertView showWithTitle:@"VKPreferences"
                                   message:localizationMessage
                         cancelButtonTitle:localizationCancelBtn
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex])
                                      {
                                          NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                                          [settings setValue:@NO forKey:@"sTouchID"];
                                          [settings writeToFile:prefsFile atomically:NO];
                                      }
                                  }];

            }
        }
      }
    
    if([[spec propertyForKey:@"key"] isEqualToString:@"sPINEnabled"])
    {
        if([value intValue] == 1)
        {
            NSString *localizationMessage;
            NSString *localizationCancelBtn;
            NSString *localizationOtherBtn;
            NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
            if ([language isEqualToString:@"ru"]) {
                localizationMessage = @"Пароля не существует, сначала создайте пароль!";
                localizationCancelBtn = @"OK";
                localizationOtherBtn = @"Создать пароль";
            } else {
                localizationMessage = @"Password doesn't exist, first create a password!";
                localizationCancelBtn = @"OK";
                localizationOtherBtn = @"Create password";
            }
            passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
            if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
            {
                [UIAlertView showWithTitle:@"VKPreferences"
                                   message:localizationMessage
                         cancelButtonTitle:localizationCancelBtn
                         otherButtonTitles:@[localizationOtherBtn]
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex])
                                      {
                                          NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                                          [settings setValue:@NO forKey:@"sPINEnabled"];
                                          [settings writeToFile:prefsFile atomically:NO];
                                      }
                                      else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn])
                                      {
                                          BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] setPINVC];
                                          UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
                                          [navController setModalPresentationStyle:UIModalPresentationFormSheet];
                                          [self presentViewController:navController animated:YES completion:nil];
                                      }
                                  }];
            }
            else if ([[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
            {
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkDisablePINVC];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
                [navController setModalPresentationStyle:UIModalPresentationFormSheet];
                [self presentViewController:navController animated:YES completion:nil];
                [settings setValue:@YES forKey:@"sPINEnabled"];
                [settings writeToFile:prefsFile atomically:NO];
            }
        }
         
        else if ([value intValue] == 0 && [[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
        {
            BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkDisablePINVC];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [navController setModalPresentationStyle:UIModalPresentationFormSheet];
            [self presentViewController:navController animated:YES completion:nil];
            NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
            [settings setValue:@NO forKey:@"sPINEnabled"];
            [settings writeToFile:prefsFile atomically:NO];
        }
    }
    if([[spec propertyForKey:@"key"] isEqualToString:@"sPINVKEnabled"])
    {
        if([value intValue] == 1)
        {
            NSString *localizationMessage;
            NSString *localizationCancelBtn;
            NSString *localizationOtherBtn;
            NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
            if ([language isEqualToString:@"ru"]) {
                localizationMessage = @"Пароля не существует, сначала создайте пароль!";
                localizationCancelBtn = @"OK";
                localizationOtherBtn = @"Создать пароль";
            } else {
                localizationMessage = @"Password doesn't exist, first create a password!";
                localizationCancelBtn = @"OK";
                localizationOtherBtn = @"Create password";
            }
            passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
            if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
            {
                [UIAlertView showWithTitle:@"VKPreferences"
                                    message:localizationMessage
                            cancelButtonTitle:localizationCancelBtn
                            otherButtonTitles:@[localizationOtherBtn]
                                    tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                        if (buttonIndex == [alertView cancelButtonIndex])
                                        {
                                            NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                                            [settings setValue:@NO forKey:@"sPINVKEnabled"];
                                            [settings writeToFile:prefsFile atomically:NO];
                                        }
                                        else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn])
                                        {
                                            BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] setPINVC];
                                            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
                                            [navController setModalPresentationStyle:UIModalPresentationFormSheet];
                                            [self presentViewController:navController animated:YES completion:nil];
                                            NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                                            [settings setValue:@YES forKey:@"sPINEnabled"];
                                            [settings setValue:@YES forKey:@"sPINVKEnabled"];
                                            [settings writeToFile:prefsFile atomically:NO];
                                        }
                                    }];
            }
            else if ([[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
            {
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
                [navController setModalPresentationStyle:UIModalPresentationFormSheet];
                [self presentViewController:navController animated:YES completion:nil];
                [settings setValue:@YES forKey:@"sPINEnabled"];
                [settings setValue:@YES forKey:@"sPINVKEnabled"];
                [settings writeToFile:prefsFile atomically:NO];
            }
        }
        else if ([value intValue] == 0 && [[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
        {
            BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkDisableVKPINVC];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [navController setModalPresentationStyle:UIModalPresentationFormSheet];
            [self presentViewController:navController animated:YES completion:nil];
            NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
            [settings setValue:@NO forKey:@"sPINVKEnabled"];
            [settings writeToFile:prefsFile atomically:NO];
        }
    }
    if([[spec propertyForKey:@"key"] isEqualToString:@"sPINHard"])
    {
        if([value intValue] == 1)
        {
            BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] changePINVC];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [self presentViewController:navController animated:YES completion:nil];
            viewController.passcodeStyle = ([value intValue] == 1) ? BKPasscodeInputViewNormalPasscodeStyle : BKPasscodeInputViewNumericPasscodeStyle;
            //viewController.passcodeStyle = BKPasscodeInputViewNormalPasscodeStyle;
        }
        else
        {
            BKPasscodeViewController *viewController3 = [[VKPrefsPasscode sharedInstance] changePINVC];
            UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
            [self presentViewController:navController3 animated:YES completion:nil];
            //viewController3.passcodeStyle = BKPasscodeInputViewNumericPasscodeStyle;
            //viewController3.type = BKPasscodeViewControllerChangePasscodeType;
            viewController3.passcodeStyle = ([value intValue] == 0) ? BKPasscodeInputViewNumericPasscodeStyle : BKPasscodeInputViewNormalPasscodeStyle;
        }
    }
    /*
    if([[spec propertyForKey:@"id"] isEqualToString:@"delButton"])
    {
        passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
        {
            //NSMutableDictionary *bundleSettings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
            //[bundleSettings setValue:@NO forKey:@"enabled"];
            //[spec setProperty:[NSNumber numberWithBool: FALSE] forKey:@"enabled"];
            [spec setProperty: [NSNumber numberWithBool:NO] forKey: @"enabled"];
            //[bundleSettings writeToFile:prefsFile atomically:NO];
        }
    }
        else
        {
            [spec setValue:@YES forKey:@"enabled"];
        }
     */
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
    [settings setValue:value forKey:[spec propertyForKey:@"key"]];
    [settings writeToFile:prefsFile atomically: NO];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("ru.anonz.vkpreferencesbundle.post"), NULL, NULL, YES);
}

-(id)getPreferenceValue:(PSSpecifier*)spec
{
    /*
    NSString *key = spec.properties[@"key"];
    
    id defaultValue = spec.properties[@"default"];
    id plistValue = [settings objectForKey:key];
    
    if (!plistValue) plistValue = defaultValue;
    
    if([key isEqualToString:@"delButton"])
    {
        passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
        {
            BOOL enableCell = YES;
            UITableViewCellSelectionStyle selectionStyle = UITableViewCellSelectionStyleDefault;
            UITableViewCell *cell = [super tableView:(UITableView *)self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:20 inSection:0]];
            cell.selectionStyle = selectionStyle;
            cell.userInteractionEnabled = enableCell;
            cell.textLabel.enabled = enableCell;
            cell.detailTextLabel.enabled = enableCell;
            
            cell = [super tableView:(UITableView *)self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:20 inSection:0]];
            cell.selectionStyle = selectionStyle;
            cell.userInteractionEnabled = enableCell;
            cell.textLabel.enabled = enableCell;
            cell.detailTextLabel.enabled = enableCell;
        }
        //
        else if (self.canAuthenticateByTouchId == NO)
        {
            BOOL enableCell = YES;
            UITableViewCellSelectionStyle selectionStyle = UITableViewCellSelectionStyleNone;
            UITableViewCell *cell = [super tableView:(UITableView *)self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:20 inSection:0]];
            cell.selectionStyle = selectionStyle;
            cell.userInteractionEnabled = enableCell;
            cell.textLabel.enabled = enableCell;
            cell.detailTextLabel.enabled = enableCell;
            
            cell = [super tableView:(UITableView *)self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:20 inSection:0]];
            cell.selectionStyle = selectionStyle;
            cell.userInteractionEnabled = enableCell;
            cell.textLabel.enabled = enableCell;
            cell.detailTextLabel.enabled = enableCell;
        }
     
        return plistValue;
    } 
     */
   loadSettings();
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
    return [settings objectForKey:[spec propertyForKey:@"key"]];
}

-(void)setPINVC
{
    NSString *localizationMessage;
    NSString *localizationCancelBtn;
    NSString *localizationOtherBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationMessage = @"Пароля не существует, сначала создайте пароль!";
        localizationCancelBtn = @"OK";
        localizationOtherBtn = @"Создать пароль";
    } else {
        localizationMessage = @"Password doesn't exist, first create a password!";
        localizationCancelBtn = @"OK";
        localizationOtherBtn = @"Create password";
    }
    passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
    {
        [UIAlertView showWithTitle:@"VKPreferences"
                           message:localizationMessage
                 cancelButtonTitle:localizationCancelBtn
                 otherButtonTitles:@[localizationOtherBtn]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex])
                              {
                                  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                                  [settings setValue:@NO forKey:@"sPINEnabled"];
                                  [settings writeToFile:prefsFile atomically:NO];
                              }
                              else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn])
                              {
                                  BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] setPINVC];
                                  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
                                  [navController setModalPresentationStyle:UIModalPresentationFormSheet];
                                  [self presentViewController:navController animated:YES completion:nil];
                              }
                          }];
    }
    else
    {
        BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] changePINVC];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navController setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentViewController:navController animated:YES completion:nil];
    }
}


-(void)deletePINVC
{
    NSString *localizationMessage;
    NSString *localizationCancelBtn;
    NSString *localizationOtherBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationMessage = @"Пароля не существует, сначала создайте пароль!";
        localizationCancelBtn = @"OK";
        localizationOtherBtn = @"Создать пароль";
    } else {
        localizationMessage = @"Password doesn't exist, first create a password!";
        localizationCancelBtn = @"OK";
        localizationOtherBtn = @"Create password";
    }
    passcodeFDict = [[NSMutableDictionary alloc] initWithContentsOfFile:passcodeFPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:passcodeFPath])
    {
        [UIAlertView showWithTitle:@"VKPreferences"
                           message:localizationMessage
                 cancelButtonTitle:localizationCancelBtn
                 otherButtonTitles:@[localizationOtherBtn]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex])
                              {
                              }
                              else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn])
                              {
                                  BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] setPINVC];
                                  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
                                  [navController setModalPresentationStyle:UIModalPresentationFormSheet];
                                  [self presentViewController:navController animated:YES completion:nil];
                                  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
                                  [settings setValue:@YES forKey:@"sPINEnabled"];
                                  [settings writeToFile:prefsFile atomically:NO];
                              }
                          }];
    }
    else
    {
        BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] deletePINVC];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navController setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentViewController:navController animated:YES completion:nil];
    }
}
@end

@interface CustomCell : PSTableCell <PreferencesTableCustomView> {
    UILabel *_label;
}
@end

@implementation CustomCell
- (id)initWithSpecifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (self) {
        _label = [[UILabel alloc] initWithFrame:[self frame]];
        [_label setNumberOfLines:0];
        [_label setText:@"You can use attributed text to make this prettier."];
        [_label setBackgroundColor:[UIColor redColor]];
        [_label setShadowColor:[UIColor whiteColor]];
        [_label setShadowOffset:CGSizeMake(0,1)];
        
        [self addSubview:_label];
        [_label release];
    }
    return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
    // Return a custom cell height.
    return 60.f;
}
@end
/*
@interface TitleCell : PSTableCell <PreferencesTableCustomView> {
    UILabel *tweakTitle;
    UILabel *tweakSubtitle;
}

@end

@implementation TitleCell

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (self) {
        
        //int width = [[UIScreen mainScreen] bounds].size.width;
        
        //frame (100 = Отступ, 20 = , высота, граница от начала экрана = 60)
        //CGRect frame = CGRectMake(50, 20, width, 60);
        //CGRect subtitleFrame = CGRectMake(0, 55, width, 60);
        //tweakTitle = [[UILabel alloc] initWithFrame:frame];
        //[tweakTitle setNumberOfLines:0];
        //[tweakTitle setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:48]];
        //[tweakTitle setText:@""];
        //[tweakTitle setBackgroundColor:[UIColor clearColor]];
        //[tweakTitle setTextColor:[UIColor blackColor]];
        //[tweakTitle setTextAlignment:NSTextAlignmentLeft];
        UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"/Library/Application Support/VKPIcons/logo.png"]]];
        logo.frame = CGRectMake(50, 20, 400, 100);
        logo.center = CGPointMake(self.center.x, logo.center.y);
        [self addSubview:logo];
        
        //CGRect remainingSize = CGRectMake(0, logo.frame.size.height, self.frame.size.width, self.frame.size.height - logo.frame.size.height);
        
        //
        if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait)
        {
            tweakSubtitle = [[UILabel alloc] initWithFrame:subtitleFrame];
        }
        else
        {
            tweakSubtitle = [[UILabel alloc] initWithFrame:subtitleFrame1];
        }
        [tweakSubtitle setNumberOfLines:1];
        [tweakSubtitle setFont:[UIFont fontWithName:@"IowanOldStyle-Italic" size:16]];
        [tweakSubtitle setText:@"Настрой цвет VK для себя!"];
        [tweakSubtitle setBackgroundColor:[UIColor clearColor]];
        [tweakSubtitle setTextColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
        [tweakSubtitle setTextAlignment:NSTextAlignmentLeft];
        //
        //[self addSubview:tweakTitle];
        //[self addSubview:tweakSubtitle];
    }
    
    return self;
}


- (CGFloat)preferredHeightForWidth:(CGFloat)arg1{
    return 100.0f;
}


@end
*/

//For logo

@implementation VKPreferencesLogo
@synthesize logoImageView;

- (id)initWithSpecifier:(PSSpecifier *)specifier {
    
    //self = [super initWithFrame:CGRectZero];
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VKPreferencesLogo"];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        /////NON JB///////
        //
        NSBundle* vkhdBundle = [NSBundle mainBundle];
        NSString* logoVKPImage = [vkhdBundle pathForResource:@"logoVKP" ofType:@"png"];
        UIImage *logoImage = [[UIImage alloc] initWithContentsOfFile:logoVKPImage];
        //
        ////////JB////////
        /*
        UIImage *logoImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/Application Support/VKPIcons"] pathForResource:@"logo" ofType:@"png"]];
         */
        self.logoImageView = [[UIImageView alloc] initWithImage:logoImage];
        self.logoImageView.frame = CGRectMake(0,0,80,80);
         
        /*
        self.logoImageView.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.logoImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.logoImageView.layer.shadowOffset = CGSizeMake(0, 1);
        self.logoImageView.layer.shadowOpacity = 0.2;
        self.logoImageView.layer.shadowRadius = 1.0;
        */
        self.logoImageView.clipsToBounds = NO;
         
        [self addSubview:self.logoImageView];
        [self.logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.85 constant:0]];
        
    }
    
    return self;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1
{
    return 40.0f;
}

@end
/*
@interface HeaderCell : PSTableCell{
    UIImageView *_background;
}
@end
@implementation VKPreferencesLogo
- (id)initWithSpecifier:(PSSpecifier *)specifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell" specifier:specifier];
    
    if (self) {
        
        UIImage *bkIm = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/FancierSettings.bundle"] pathForResource:@"fancierHeader" ofType:@"png"]];
        
        _background = [[UIImageView alloc] initWithImage:bkIm];
        
        [self addSubview:_background];
    }
    
    return self;
}

- (float)preferredHeightForWidth:(float)arg1{
    return 100.f;
}
@end
 */
// vim:ft=objc
