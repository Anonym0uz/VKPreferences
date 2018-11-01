#import "VKPreferences.h"

//@class VKRequest;
//@class VKSession;
@implementation VKPreferences
@synthesize settings;
/////////////CELLS AND CACHE SWITCH
@synthesize newsCell;
@synthesize feedbackCell;
@synthesize messagesCell;
@synthesize friendsCell;
@synthesize groupsCell;
@synthesize photoFeedCell;
@synthesize videosCell;
@synthesize audioCell;
@synthesize favoritesCell;
@synthesize settingsCell;
@synthesize accountsCell;
@synthesize VKPSettingsCell;
@synthesize offlineCell;
@synthesize invokeOfflineCell;
@synthesize dontReadCell;
@synthesize hideTypeCell;
@synthesize cacheCell;
@synthesize testCell;
//@synthesize timer;s
@synthesize offlineTimer;
@synthesize refreshTimer;
@synthesize tableView;
@synthesize messCount;
@synthesize vkpsettingscontr;
int timerWorking;
UITableView *tableView;
@synthesize cacheSwitch;
UISwitch *switchView;
UISwitch *switchView2;
UISwitch *switchView3;
UISwitch *switchView4;
UISwitch *switchView5;
BOOL closeController;
int numA = 0;
static NSString *CellIdentifier = @"CustomCells";

+(VKPreferences *) sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&p, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}
//
-(VKPreferences *) init
{
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    self.provisioningProfile = [VKPreferences getProvisioningProfileForPath:[[vkhdBundle resourcePath] stringByAppendingString:@"/embedded.mobileprovision"]];
    return self;
}

+(NSString*) getTeamIdForProfile:(NSDictionary*)profile
{
    NSArray *teams = [profile objectForKey:@"TeamIdentifier"];
    return teams[0];
}

+(NSDictionary*) getProvisioningProfileForPath:(NSString*)path;
{
    NSData *rawData = [NSData dataWithContentsOfFile:path];
    NSString* rawString = [[NSString alloc] initWithData:rawData encoding:NSASCIIStringEncoding];
    NSString* plistString = [VKPreferences substringString:rawString from:@"<!DOCTYPE plist" to:@"</plist>"];
    NSData* plistData = [plistString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSPropertyListFormat format;
    NSDictionary* plistDict = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&format error:&error];
    
    if(!plistDict){
        return nil;
    }
    
    return plistDict;
}

+(NSString*) substringString:(NSString*)string from:(NSString*)prefix to:(NSString*)suffix
{
    NSRange prefixRange = [string rangeOfString:prefix];
    NSRange suffixRange = [[string substringFromIndex:prefixRange.location] rangeOfString:suffix];
    NSRange resultRange = NSMakeRange(prefixRange.location, suffixRange.location + suffix.length);
    NSString *result = [string substringWithRange:resultRange];
    return result;
}

+(NSArray*) teamIDReferences
{
    return @[
             Obfuscate._6.G.Q._6.M._9._4._4.A.F, //ISHIM
             Obfuscate._2.M.S.J._3.D._4.W._7.H,
             Obfuscate.P.Z._9.U.B.Z._5._8.W.E,
             Obfuscate._2._9.K.S.Q.P.R.B.J.K,
             Obfuscate.H._3.M.D.K._6.Q._3.B.Y,
             Obfuscate._5.L.T._6.F.E.M.N.T.K, //IKA
             Obfuscate.E._5.M.J.A.U._5._4.L.U,
             Obfuscate._7._7.M.K.X._5._6.S.V.K
             ];
}
//
/*
+(BOOL)JBcheck
{
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]])
    {
        #define prefsFile @"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"
        #define menuFile @"/var/mobile/Library/Preferences/ru.anonz.vkmenu.plist"
        #define accountsPath @"/var/mobile/Library/Preferences/ru.anonz.vkaccounts.plist"
        #define versionsPath @"/var/mobile/Library/Preferences/ru.anonz.vkpversion.plist"
        
        [UIAlertView showWithTitle:@"VKPreferences"
                           message:@"JailBreaked iPad!"
                 cancelButtonTitle:@"👍"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex])
                              {
                                  
                              }
                          }];
        return YES;
        
    }
    else if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]])
    {
        //#define prefsFile [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpreferencesbundle.plist"]
        //#define menuFile [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkmenu.plist"]
        //#define accountsPath [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkaccounts.plist"]
        //#define versionsPath [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpversion.plist"]
        
        [UIAlertView showWithTitle:@"VKPreferences"
                           message:@"Non-JailBreaked iPad!"
                 cancelButtonTitle:@"👍"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex])
                              {
                                  
                              }
                          }];
        
        return NO;
    }
    return NO;
}
*/

-(void)loadSettings
{
    [[VKPreferences sharedInstance] settings];
    //NSLog (@"Settings is loaded.");
}

+(void)checkSettings
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:prefsFile])
    {
        NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
        [settings setValue:@YES forKey:@"sOffline"];
        [settings setValue:@YES forKey:@"sDontRead"];
        [settings setValue:@YES forKey:@"sHideTyping"];
        [settings setValue:@NO forKey:@"sCacheOn"];
        [settings setValue:@NO forKey:@"sMenuChange"];
        [settings setValue:@NO forKey:@"sAdultOff"];
        [settings setValue:@NO forKey:@"sAnswers"];
        [settings setValue:@NO forKey:@"sTouchID"];
        [settings writeToFile:prefsFile atomically:NO];
    }
}

+(void)checkAccounts
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:accountsPath])
    {
        NSMutableArray *accounts = [NSMutableArray new];
        [accounts writeToFile:accountsPath atomically:NO];
    }
}

+(void)checkMenu
{
    NSMutableDictionary *menu;
    NSArray *enabled;
    NSArray *disabled;
    
    menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:menuFile])
    {
        menu = [NSMutableDictionary new];
        disabled = [NSArray arrayWithObjects:@"Помощь", nil];
        enabled = [NSArray arrayWithObjects:
                   @"Моя страница",
                   @"Новости",
                   @"Ответы",
                   @"Сообщения",
                   @"Друзья",
                   @"Группы",
                   @"Фотографии",
                   @"Видеозаписи",
                   @"Аудиозаписи",
                   @"Закладки",
                   @"Настройки",
                   @"Оффлайн",
                   @"Не читать",
                   @"Скрыть набор",
                   @"Сменить аккаунт",
                   @"Настройки VKP", nil];
        [menu setObject:enabled forKey:@"enabled"];
        [menu setObject:disabled forKey:@"disabled"];
        [menu writeToFile:menuFile atomically:NO];
    }
}

+(void)updateMenu
{
    [tableView beginUpdates];
    [tableView reloadData];
    [tableView endUpdates];
}

//PostNotification (NEED)
-(void)updateSettings {
    CFNotificationCenterPostNotification (CFNotificationCenterGetDarwinNotifyCenter(),
                                          CFSTR("ru.anonz.vkpreferencesbundle.post"),
                                          NULL,
                                          NULL,
                                          false);
    [[VKPreferences sharedInstance] saveSettings];
}
-(void)saveSettings
{
    [settings writeToFile:prefsFile atomically:NO];
}

////////////////////////
///////SWITCHES/////////
////////////////////////
-(void)offlineSwitch:(id)sender
{
    //Offline switch
    UISwitch* switchControl = sender;
    if(switchControl.on)
    {
        /*
        NSString *localizationMessage;
        NSString *localizationCancelBtn;
        NSString *localizationOtherBtn;
        NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
        if ([language isEqualToString:@"ru"]) {
            localizationMessage = @"Через сколько Вы хотите стать оффлайн?";
            localizationCancelBtn = @"15 мин.";
            localizationOtherBtn = @"Мгновенно";
        } else {
            localizationMessage = @"Across how much time you want be offline?";
            localizationCancelBtn = @"15 min.";
            localizationOtherBtn = @"Instantly";
        }
        
        [UIAlertView showWithTitle:@"VKPreferences"
                           message:localizationMessage
                 cancelButtonTitle:localizationCancelBtn
                 otherButtonTitles:@[localizationOtherBtn]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  
                                  [switchView setOn:YES animated:NO];
                                  [settings setValue:@YES forKey:@"sOffline"];
                                  [settings writeToFile:prefsFile atomically:NO];
                              }
                              else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn]) {
                                  */
                                  [[VKPreferences sharedInstance] saveSettings];
                                  id request = [[objc_getClass("account_setOffline_req") alloc] init];
                                  id controller = [objc_getClass("VKAPIController") sharedInstance];
                                  [controller sendRequest:request];
                                  [settings setValue:@YES forKey:@"sOffline"];
                                  [settings writeToFile:prefsFile atomically:NO];
    }
    else
    {
        [[VKPreferences sharedInstance] saveSettings];
        id request = [[objc_getClass("account_setOffline_req") alloc] init];
        id controller = [objc_getClass("VKAPIController") sharedInstance];
        [controller sendRequest:request];
        [settings setValue:@NO forKey:@"sOffline"];
        [settings writeToFile:prefsFile atomically:NO];
    }
                              //}
                          //}];
    
    //}
        /*
    else
    {
        NSString *localizationMessage;
        NSString *localizationCancelBtn;
        NSString *localizationOtherBtn;
        NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
        if ([language isEqualToString:@"ru"]) {
            localizationMessage = @"Вы действительно хотите стать онлайн?";
            localizationCancelBtn = @"Нет";
            localizationOtherBtn = @"Да";
        } else {
            localizationMessage = @"Would you really want to be online?";
            localizationCancelBtn = @"Nope";
            localizationOtherBtn = @"Yes";
        }
        [UIAlertView showWithTitle:@"VKPreferences"
         //message:(RusLang) ? @"Вы действительно хотите стать онлайн?" :
                           message:localizationMessage
                 cancelButtonTitle:localizationCancelBtn
                 otherButtonTitles:@[localizationOtherBtn]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  
                                  [switchView setOn:YES animated:YES];
                                  [settings setValue:@YES forKey:@"sOffline"];
                                  [settings writeToFile:prefsFile atomically:NO];
                                  //[[VKPreferences sharedInstance] updateSettings];
                                  //NSLog (@"Leave in offline!");
                              }
                              else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationOtherBtn]) {
                                  [[VKPreferences sharedInstance] saveSettings];
                                  id request = [[objc_getClass("account_setOnline_req") alloc] init];
                                  id controller = [objc_getClass("VKAPIController") sharedInstance];
                                  [controller sendRequest:request];
                                  
                                  [switchView setOn:NO animated:YES];
                                  [settings setValue:@NO forKey:@"sOffline"];
                                  [settings writeToFile:prefsFile atomically:NO];
                                  //[[VKPreferences sharedInstance] updateSettings];
                                  //NSLog (@"Offline OFF");
                              }
                          }];
    }
         */
    [[VKPreferences sharedInstance] loadSettings];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [[VKPreferences sharedInstance] updateSettings];

}
-(void)dontReadSwitch:(id)sender
{
    //Don't read switch
    UISwitch* switchControl = sender;
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sDontRead"];
        [settings writeToFile:prefsFile atomically:NO];
        //NSLog (@"Dont Read ON");
    }
    else
    {
        [settings setValue:@NO forKey:@"sDontRead"];
        [settings writeToFile:prefsFile atomically:NO];
        //NSLog (@"Dont Read OFF");
    }
    [[VKPreferences sharedInstance] loadSettings];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [[VKPreferences sharedInstance] updateSettings];
}
-(void)dontTypeSwitch:(id)sender
{
    //Hide type switch
    UISwitch* switchControl = sender;
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sHideTyping"];
        [settings writeToFile:prefsFile atomically:NO];
        //NSLog (@"Dont Type ON");
    }
    else
    {
        [settings setValue:@NO forKey:@"sHideTyping"];
        [settings writeToFile:prefsFile atomically:NO];
        //NSLog (@"Dont Type OFF");
    }
    [[VKPreferences sharedInstance] loadSettings];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [[VKPreferences sharedInstance] updateSettings];
}

- (void)cacheOn:(id)sender {
    
    //Cache switch
    UISwitch* switchControl = sender;
    if(switchControl.on)
    {
        //NSLog(@"=========== |Cache is enable| ===========");
        [settings setValue:@YES forKey:@"sCacheAudio"];
        [settings writeToFile:prefsFile atomically:NO];
        
    }
    else
    {
        //NSLog(@"=========== |Cache is disable| ===========");
        [settings setValue:@NO forKey:@"sCacheAudio"];
        [settings writeToFile:prefsFile atomically:NO];
    }
    [[VKPreferences sharedInstance] loadSettings];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [[VKPreferences sharedInstance] updateSettings];
}

-(void)invokeSwitch:(id)sender
{
    //Phantom switch
    UISwitch* switchControl = sender;
    if(switchControl.on)
    {
        [[VKPreferences sharedInstance] saveSettings];
        id request = [[objc_getClass("account_setOffline_req") alloc] init];
        id controller = [objc_getClass("VKAPIController") sharedInstance];
        [controller sendRequest:request];
        [[VKPreferences sharedInstance] offlineTimer];
        //[[VKPreferences sharedInstance] invokeTimer];
        [settings setValue:@YES forKey:@"sInvoke"];
        [[VKPreferences sharedInstance] loadSettings];
        [settings writeToFile:prefsFile atomically:NO];
        [[VKPreferences sharedInstance] saveSettings];
        [[VKPreferences sharedInstance] updateSettings];
        //NSLog (@"Invoke ON");
    }
    else
    {
        //[[VKPreferences sharedInstance] invokeTimer];
        [settings setValue:@NO forKey:@"sInvoke"];
        [settings writeToFile:prefsFile atomically:NO];
        //NSLog (@"Invoke OFF");
    }
    [[VKPreferences sharedInstance] loadSettings];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [[VKPreferences sharedInstance] updateSettings];
}

-(void)halfOffline
{
    id request = [[objc_getClass("account_setOffline_req") alloc] init];
    id controller = [objc_getClass("VKAPIController") sharedInstance];
    [controller sendRequest:request];
}

-(NSTimer*)offlineTimer
{
    self.offlineTimer = [NSTimer scheduledTimerWithTimeInterval:25.0f  target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    [[VKPreferences sharedInstance] saveSettings];
    id request = [[objc_getClass("account_setOffline_req") alloc] init];
    id controller = [objc_getClass("VKAPIController") sharedInstance];
    [controller sendRequest:request];
    return offlineTimer;
}

- (void)stopOfflineTimer {
    [offlineTimer invalidate];
    self.offlineTimer = nil;
}

- (void)updateTimer:(NSTimer *)theTimer {
    if ([[[[VKPreferences sharedInstance] settings] objectForKey:@"sInvoke"] boolValue])
    {
        [[VKPreferences sharedInstance] saveSettings];
        id request = [[objc_getClass("account_setOffline_req") alloc] init];
        id controller = [objc_getClass("VKAPIController") sharedInstance];
        [controller sendRequest:request];
        //NSLog (@"Timer has been work!");
    }
    else
    {
        [[VKPreferences sharedInstance] stopOfflineTimer];
        //NSLog(@"Timer end");
    }
}

-(void)adultOff
{
    if ([[[[VKPreferences sharedInstance] settings] objectForKey:@"sAdultOff"] boolValue])
    {
        id controller = [objc_getClass("VKAPIController") sharedInstance];
        id videoSearch = [[objc_getClass("video_search_req") alloc] init];
        [videoSearch setAdult:0];
        [controller sendRequest:videoSearch];
        id groupSearch = [[objc_getClass("VKGroup") alloc] init];
        [groupSearch setIs_adult:0];
        [controller sendRequest:groupSearch];
        id grSort = [[objc_getClass("groups_search_req") alloc] init];
        [grSort setSort:1];
        [controller sendRequest:grSort];
    }
}
/*
-(void)smartPost
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sPostPone"] boolValue])
    {
        id controller = [objc_getClass("VKAPIController") sharedInstance];
        id wallPBD = [[objc_getClass("wall_post_req") alloc] init];
        id wallPBDS =  [[objc_getClass("wall_post_res") alloc] init];
        id request = [[objc_getClass("account_setOffline_req") alloc] init];
        [controller sendRequest:request];
        [wallPBD setPublish_date:nil];
        //[wallPBD setOwner_id:nil];
        [wallPBDS setPost_id:nil];
        [controller sendRequest:wallPBD];
        [controller sendRequest:wallPBDS];
    }
}
*/
/*
-(id)customsCells
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell.textLabel.text = (RusLang) ? @"Оффлайн" : @"Offline";
    cell.textLabel.text = (RusLang) ? @"Оффлайн" : @"Оффлайн";
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Offline.png"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    //customsCells = cell;
    [[VKPreferences sharedInstance] loadSettings];
    return cell;

}
*/

-(double)dateReturn
{
    /*
    double i;
    time_t unixTime = (time_t) [[NSDate date] timeIntervalSince1970];
    i = unixTime + 300;
    return i;
    NSLog (@"Res: %ld", unixTime);
    NSLog (@"Res w/+: %f", i);
     */
    double its;
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    its = currentTime + 0000000005;
    NSLog (@"Res: %ld", (long)currentTime);
    NSLog (@"Res + 0.2: %ld", (long)its);
    return its;
    //return currentTime;
}

-(void)logout
{
    [[objc_getClass("iPadMainViewController") sharedInstance] doLogout];
    //[[objc_getClass("VKAPIController") sharedInstance] logout];
}

-(void)reloadCounts
{
    id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
    id messCounts = [messContr counters];
    id counter = [messCounts messages];
    int counts = [counter integerValue];
    NSLog(@"Messages: %ld", (long)counts);
    
    id grCounter = [messCounts groups];
    int grCounts = [grCounter integerValue];
    NSLog(@"Groups: %ld", (long)grCounts);
    
    id frCounter = [messCounts friends];
    int frCounts = [frCounter integerValue];
    NSLog(@"Friends: %ld", (long)frCounts);
}

-(NSTimer*)refreshTimer
{
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f  target:self selector:@selector(updateTimerz:) userInfo:nil repeats:YES];
    //[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //[[VKPreferences sharedInstance] reloadCounts];
    return refreshTimer;
}

- (void)updateTimerz:(NSTimer *)theTimer
{
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //[[VKPreferences sharedInstance] reloadCounts];
}

-(void)accountChange
{
    //[[VKPreferences sharedInstance] logout];
    id loadingLog = [[objc_getClass("LoadingViewController") sharedLoadingView] retain];
    [loadingLog showSelfInWindow];
    NSArray *accsArray = [[NSArray alloc] initWithContentsOfFile:accountsPath];
    
    NSString *login = [[accsArray objectAtIndex:numA] objectForKey:@"Login"];
    NSString *password = [[accsArray objectAtIndex:numA] objectForKey:@"Password"];
    
    NSString *key = @"hsaJdHscancJHc*(723&%RT^sfdjh^UIHfw4iu9812Rtasjc96sdfJKHfdsnfscy7(*&^nsfnerofj^8werh*%efwJKkdsDs";
    NSString* usernameDecrypted = [FBEncryptorAES decryptBase64String:login keyString:key];
    NSString* passwordDecrypted = [FBEncryptorAES decryptBase64String:password keyString:key];

    id auth = [[objc_getClass("auth_login_req") alloc] init];
    [auth setPassword:passwordDecrypted];
    [auth setUsername:usernameDecrypted];
    [auth setClient_id:@"3682744"];
    [auth setClient_secret:@"mY6CDUswIVdJLCD3j15n"];
    [auth setScope:@"notify,friends,photos,audio,video,docs,notes,wall,groups,messages,notifications,activity,status,pages,stats,nohttps,adsint"];
    [auth setDidFinishBlock:^(id response) {
    [[[objc_getClass("iPadLoginViewController") alloc] init] processAuthorizationResponse:response];
        }];
    id requestAuth = [[objc_getClass("VKAPIController") sharedInstance] retain];
    [requestAuth sendRequest:auth viaHTTPS:0x1];
    //BOOL reloginComplete = YES;
    //[[VKPreferences sharedInstance] reloadAll];
    [loadingLog release];
    [requestAuth release];
    [auth release];
    
    NSTimeInterval delayInSeconds = 3.0;
    NSTimeInterval delayInSecondsTwo = 7.0;
    NSTimeInterval delayInSecondsThree = 12.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [[VKPreferences sharedInstance] reloadAll];
    });
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTwo * NSEC_PER_SEC);
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        
        [[VKPreferences sharedInstance] reloadAll];
    });
    dispatch_time_t popTime3 = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsThree * NSEC_PER_SEC);
    dispatch_after(popTime3, dispatch_get_main_queue(), ^(void){
        
        [[VKPreferences sharedInstance] reloadAll];
    });
    /*
    if (auth)
    {
        [UIAlertView showWithTitle:@"VK Preferences"
                           message:@"После смены аккаунта, нужен перезапуск сервисов VK."
                 cancelButtonTitle:@"Перезапустить"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  [[VKPreferences sharedInstance] reloadAll];
                              }
                          }];
    }
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
    [self.tableView reloadData];
    //[getsUM checkUnreadMessages];
    [getsLongPoll release];
    [controller release];
}

-(void)loginAlert
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    [mainController checkIfRightSlideRequired];
    [mainController closeMenuTap:0x0];
    [mainController pushBaseViewController:[[VKAccounts alloc] init]];
    /*
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    NSArray *values=[[NSArray alloc] initWithContentsOfFile:accountsPath];
    NSMutableArray *keysez = [values valueForKey:@"Name"];
    
    NSString *localizationTitle;
    NSString *localizationMessage;
    NSString *localizationCancelBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationTitle = @"Смена аккаунта";
        localizationMessage = @"Выберите аккаунт (название аккаунта)";
        localizationCancelBtn = @"Отмена";
    } else {
        localizationTitle = @"Account change";
        localizationMessage = @"Choose account (account name)";
        localizationCancelBtn = @"Cancel";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:localizationTitle
                          //message: (RusLang) ? @"Выберите аккаунт (название аккаунта)" : @"Select account (name account)"
                                                   message:localizationMessage
                                                  delegate: self
                          //cancelButtonTitle: (RusLang) ? @"Отмена" : @"Cancel"
                                         cancelButtonTitle:localizationCancelBtn
                                         otherButtonTitles: nil];
    for(NSString *buttonTitle in keysez)
    {
        [alert addButtonWithTitle:buttonTitle];
    }
    [alert show];
    [mainController closeMenuTap:0x0];
     */
}
/*
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else if (buttonIndex == 1)
    {
        numA = 0;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 2)
    {
        numA = 1;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 3)
    {
        numA = 2;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 4)
    {
        numA = 3;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 5)
    {
        numA = 4;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 6)
    {
        numA = 5;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 7)
    {
        numA = 6;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 8)
    {
        numA = 7;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 9)
    {
        numA = 8;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 10)
    {
        numA = 9;
        [[VKPreferences sharedInstance] accountChange];
    }
    else if (buttonIndex == 11)
    {
        numA = 10;
        [[VKPreferences sharedInstance] accountChange];
    }
}
 */


-(void)openFriends
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id contacts = [[objc_getClass("iPadContactsView") alloc] init];
    [mainController checkIfRightSlideRequired];
    [mainController pushBaseViewController:contacts];
    [mainController closeMenuTap:0x0];

    //[mainController slideMenuClosed];
}
-(void)openNews
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id news = [[objc_getClass("iPadNewsViewController") alloc] init];
    [mainController checkIfRightSlideRequired];
    [mainController pushBaseViewController:news];
    [news updateButtonFired:FALSE];
    [news updateNews:FALSE];
    [mainController closeMenuTap:0x0];
}
-(void)openMessagez
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    //id messagez = [[objc_getClass("MessagesContainerViewController") alloc] init];
    [mainController checkIfRightSlideRequired];
    [mainController prepareMessagesForOpen];
    //[mainController didShowViewController:messagez];
    //[mainController presentViewController:messagez animated:YES completion:nil];
    [mainController openMessages];
    [mainController closeMenuTap:0x0];
}
-(void)openAudios
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    //id audios = [[objc_getClass("iPadAudioViewController") alloc] init];
    [mainController checkIfRightSlideRequired];
    [mainController openAudioView];

}
-(void)openFeedbacks
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    //id feedback = [[objc_getClass("iPadFeedbackViewController") alloc] init];
    //[mainController pushBaseViewController:feedback];
    [mainController openFeedback];
    id news = [[objc_getClass("iPadNewsViewController") alloc] init];
    [news viewDidDisappear:TRUE];
    [mainController closeMenuTap:0x0];

}
-(void)openGroupsez
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    //id groups = [[objc_getClass("iPadGroupsViewController") alloc] init];
    //[mainController pushBaseViewController:groups];
    //id reloadGroups = [[objc_getClass("NSNotificationCenter") defaultCenter] retain];
    //[reloadGroups postNotificationName:@"kNotificationReloadGroups" object:0x0];
    //[groups updateDataSources];    
    [mainController openGroups];
    [mainController closeMenuTap:0x0];
}
-(void)openSelf
{
    /*
    id apistor = [[objc_getClass("APIStorage") sharedStorage] retain];
    id controller = [[objc_getClass("VKAPIController") sharedInstance] retain];
    id getSelf = [[objc_getClass("account_getProfileInfo_req") alloc] init];
    id getSelf2 = [[objc_getClass("account_getInfo_req") alloc] init];
    id getWall = [[objc_getClass("wall_get_req") alloc] init];
    
    id user = [controller user_id];
    [apistor getUser:user];
    
    [controller sendRequest:getSelf];
    [controller sendRequest:getSelf2];
    [controller sendRequest:getWall];
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id wall = [[objc_getClass("iPadWallViewController") alloc] init];
    [mainController pushBaseViewController:wall];
     */
}
-(void)openFavorites
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id favorites = [[objc_getClass("iPadFavoritesViewController") alloc] init];
    [mainController checkIfRightSlideRequired];
    [mainController pushBaseViewController:favorites];
    [mainController closeMenuTap:0x0];
}
-(void)openSettings
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id settingsController = [[objc_getClass("SettingsViewController") alloc] init];
    [settingsController showSelfInWindow];
    [mainController closeMenuTap:0x0];
}
-(void)openPhotoFeed
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id photoFeed = [[objc_getClass("PhotofeedViewController") alloc] init];
    [mainController closeMenuTap:0x0];
    [mainController checkIfRightSlideRequired];
    [mainController pushBaseViewController:photoFeed];
}
-(void)openVideos
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    id videos = [[objc_getClass("VideoViewController") alloc] init];
    [mainController closeMenuTap:0x0];
    [mainController checkIfRightSlideRequired];
    [mainController pushBaseViewController:videos];
}
-(void)openVKPAccounts
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    [mainController checkIfRightSlideRequired];
    [mainController closeMenuTap:0x0];
    //[mainController pushBaseViewController:[[objc_getClass("VKAccounts") alloc] init]];
    [mainController pushBaseViewController:[[VKAccounts alloc] init]];
}
-(void)openVKPMenu
{
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    [mainController checkIfRightSlideRequired];
    [mainController closeMenuTap:0x0];
    //[mainController pushBaseViewController:[[objc_getClass("VKMenu") alloc] init]];
    [mainController pushBaseViewController:[[VKMenu alloc] init]];
}

-(void)openVKPSettings
{
    ///////////VKHD NON-JB//////////
    
    id mainController = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    [mainController checkIfRightSlideRequired];
    [mainController closeMenuTap:0x0];
    //VKPreferencesBundleListController *vkpcontroller = [[VKPreferencesBundleListController alloc] init];
    //vkpsettingscontr = [[VKPreferencesBundleListController alloc] init];
    [mainController pushBaseViewController:[[VKPreferencesBundleListController alloc] init]];
    [[VKPreferences sharedInstance] loadSettings];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [[VKPreferences sharedInstance] updateSettings];
    [self.tableView reloadData];
     
    
    //////////////VKHD JB////////////
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=VKPREFERENCES_ID"]];
}
 
/*
-(int)postPone
{
    int i;
    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
    i = seconds + 10;
    return i;
    //return date1 + 120;
    /
    if ([date1 timeIntervalSince1970] < 120)
    {
        
    }
    else if ([date1 timeIntervalSince1970] < 600)
    {
        
    }
 
}
*/
/*
- (void)invokeTimer
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sInvoke"] boolValue] && !timerWorking)
    {
            timerWorking = TRUE;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[VKPreferences sharedInstance] saveSettings];
                id request = [[objc_getClass("account_setOffline_req") alloc] init];
                id controller = [objc_getClass("VKAPIController") sharedInstance];
                [controller sendRequest:request];
                NSLog (@"Timer now work!");

            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 29 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            timerWorking = FALSE;
            [self invokeTimer];
                NSLog (@"Timer off!");
        });
    }
}
 */
/*
- (void)invokerTimer {
    
    [[VKPreferences sharedInstance] saveSettings];
    id request = [[objc_getClass("account_setOffline_req") alloc] init];
    id controller = [objc_getClass("VKAPIController") sharedInstance];
    [controller sendRequest:request];
}
*/
/*
-(void)functionsCells:(id)sender
{
    //[[VKPreferences sharedInstance] loadSettings];
    id offline = sender;
    id dontRead = sender;
    id dontType = sender;

    if(sender == offline)
    {
        //Offline switch
        UISwitch* switchControl = sender;
    
        if(switchControl.on)
        {
            [settings setValue:@YES forKey:@"sOffline"];
            [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        
        }
        else
        {
            [settings setValue:@NO forKey:@"sOffline"];
            [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        }
        sender = offline;
        //return sender;
    }
    else if (sender == dontRead)
    {
    //Don't read switch
    UISwitch* switchControl = sender;
    
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sDontRead"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
    else
    {
        [settings setValue:@NO forKey:@"sDontRead"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
        sender = dontRead;
    }
    else if (sender == dontType)
    {
    //Hide type switch
    UISwitch* switchControl = sender;
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sHideTyping"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
    else
    {
        [settings setValue:@NO forKey:@"sHideTyping"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
        sender = dontType;
    }
    [[VKPreferences sharedInstance] loadSettings];
}
*/

-(void)getUser
{
    id api = [[objc_getClass("APIStorage") sharedStorage] retain];
    id response = [[objc_getClass("VKAPIController") sharedInstance] retain];
    id user = [response user_id];
    [api getUser:user];
    id backup = [[objc_getClass("BackupImageView") alloc] retain];
    id image = [backup initWithFrame:CGRectMake(2, 2, 2, 2)];
    [image setImage:backup];
}

/////////////////////
////////CELLS////////
/////////////////////
-(UITableViewCell*)newsCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Новости";
    } else {
        localizationString = @"News";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkNewsImage = [vkhdBundle pathForResource:@"ios7-menunews" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkNewsImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    newsCell = cell;
    return cell;
}

-(UITableViewCell*)feedbackCell
{
    TDBadgedCell *cell = [[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell)
    //{
    //    return cell;
    //}
    //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Ответы";
    } else {
        localizationString = @"Feedback";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkFeedImage = [vkhdBundle pathForResource:@"ios7-menufeedback" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkFeedImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    
    [tableView beginUpdates];
    
    id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
    id notificationsCounts = [messContr counters];
    id counter = [notificationsCounts notifications];
    __block int counts = [counter integerValue];
    int str = counts;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
        id notificationsCounts = [messContr counters];
        id counter = [notificationsCounts notifications];
        counts = [counter integerValue];
        //cell.badgeString = [NSString stringWithFormat:@"%i",counts];
    });
    if(counts == 0)
    {
        cell.badgeColor = nil;
        cell.badgeTextColor = nil;
        cell.badgeTextColorHighlighted = nil;
        cell.badgeColorHighlighted = nil;
        cell.badgeString = nil;
    }
    else {
        
        cell.badgeColor = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];//[UIColor colorWithRed:92.0f green:104.0f blue:118.0f alpha:1.0f];
        cell.badgeTextColor = [UIColor whiteColor];
        cell.badgeTextColorHighlighted = [UIColor whiteColor];
        cell.badgeColorHighlighted = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];
        cell.badge.fontSize = 15;
        cell.badge.radius = 11;
        cell.badgeString = [NSString stringWithFormat:@"%i",str];
        //cell.badgeLeftOffset = 10;
        cell.badgeRightOffset = 17;
    }
    [tableView reloadData];
    [tableView endUpdates];
    feedbackCell = cell;
    return cell;
    
}

-(UITableViewCell*)messagesCell
{
    TDBadgedCell *cell = [[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell)
    //{
    //    return cell;
    //}
    //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Сообщения";
    } else {
        localizationString = @"Messages";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkMessImage = [vkhdBundle pathForResource:@"ios7-menumessages" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkMessImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    
    [tableView beginUpdates];
    
    id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
    id messCounts = [messContr counters];
    id counter = [messCounts messages];
    __block int counts = [counter integerValue];
    int str = counts;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
        id messCounts = [messContr counters];
        id counter = [messCounts messages];
        counts = [counter integerValue];
        //int z = counts;
        //cell.badgeString = [NSString stringWithFormat:@"%i",counts];
    });
    if(counts == 0)
    {
        cell.badgeColor = nil;
        cell.badgeTextColor = nil;
        cell.badgeTextColorHighlighted = nil;
        cell.badgeColorHighlighted = nil;
        cell.badgeString = nil;
    }
    else {
        
        cell.badgeColor = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];//[UIColor colorWithRed:92.0f green:104.0f blue:118.0f alpha:1.0f];
        cell.badgeTextColor = [UIColor whiteColor];
        cell.badgeTextColorHighlighted = [UIColor whiteColor];
        cell.badgeColorHighlighted = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];
        cell.badge.fontSize = 15;
        cell.badge.radius = 11;
        cell.badgeString = [NSString stringWithFormat:@"%i",str];
        //cell.badgeLeftOffset = 10;
        cell.badgeRightOffset = 17;
    }
    [tableView endUpdates];
    //[tableView reloadData];
    messagesCell = cell;
    return cell;
    
}

-(UITableViewCell*)friendsCell
{
    TDBadgedCell *cell = [[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell)
    //{
    //    return cell;
    //}
    //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Друзья";
    } else {
        localizationString = @"Friends";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkFriendsImage = [vkhdBundle pathForResource:@"ios7-menufriends" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkFriendsImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    
    [tableView beginUpdates];
    
    id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
    id friendsCounts = [messContr counters];
    id counter = [friendsCounts friends];
    __block int counts = [counter integerValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
        id friendsCounts = [messContr counters];
        id counter = [friendsCounts friends];
        counts = [counter integerValue];
        //cell.badgeString = [NSString stringWithFormat:@"%i",counts];
    });
    if(counts == 0)
    {
        cell.badgeColor = nil;
        cell.badgeTextColor = nil;
        cell.badgeTextColorHighlighted = nil;
        cell.badgeColorHighlighted = nil;
        cell.badgeString = nil;
    }
    else
    {
        cell.badgeColor = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];
        cell.badgeTextColor = [UIColor whiteColor];
        cell.badgeTextColorHighlighted = [UIColor whiteColor];
        cell.badgeColorHighlighted = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];
        cell.badge.fontSize = 15;
        cell.badge.radius = 11;
        cell.badgeString = [NSString stringWithFormat:@"%i",counts];
        cell.badgeRightOffset = 17;
    }
    [tableView reloadData];
    [tableView endUpdates];
    friendsCell = cell;
    return cell;
    
}

-(UITableViewCell*)groupsCell
{
    TDBadgedCell *cell = [[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell)
    //{
    //    return cell;
    //}
    //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Группы";
    } else {
        localizationString = @"Groups";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkCommsImage = [vkhdBundle pathForResource:@"ios7-menucommunities" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkCommsImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    
    [tableView beginUpdates];
    
    id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
    id groupsCounts = [messContr counters];
    id counter = [groupsCounts groups];
    __block int counts = [counter integerValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id messContr = [[objc_getClass("MessagesController") sharedInstance] retain];
        id groupsCounts = [messContr counters];
        id counter = [groupsCounts groups];
        counts = [counter integerValue];
        //cell.badgeString = [NSString stringWithFormat:@"%i",counts];
    });
    if(counts == 0)
    {
        cell.badgeColor = nil;
        cell.badgeTextColor = nil;
        cell.badgeTextColorHighlighted = nil;
        cell.badgeColorHighlighted = nil;
        cell.badgeString = nil;
    }
    else
    {
        cell.badgeColor = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];
        cell.badgeTextColor = [UIColor whiteColor];
        cell.badgeTextColorHighlighted = [UIColor whiteColor];
        cell.badgeColorHighlighted = [UIColor colorWithRed:97.0/255.0 green:107.0/255.0 blue:118.0/255.0 alpha:1];
        cell.badge.fontSize = 15;
        cell.badge.radius = 11;
        cell.badgeString = [NSString stringWithFormat:@"%i",counts];
        cell.badgeRightOffset = 17;
    }
    [tableView reloadData];
    [tableView endUpdates];
    groupsCell = cell;
    return cell;
}

-(UITableViewCell*)photoFeedCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Фотографии";
    } else {
        localizationString = @"Photos";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkPhotoImage = [vkhdBundle pathForResource:@"ios7-menuphotos" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkPhotoImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    photoFeedCell = cell;
    return cell;
    
}

-(UITableViewCell*)videosCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Видеозаписи";
    } else {
        localizationString = @"Video";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkVideoImage = [vkhdBundle pathForResource:@"ios7-menuvideos" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkVideoImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    videosCell = cell;
    return cell;
    
}

-(UITableViewCell*)audioCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Аудиозаписи";
    } else {
        localizationString = @"Audio";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkAudioImage = [vkhdBundle pathForResource:@"ios7-menumusic" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkAudioImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    audioCell = cell;
    return cell;
    
}

-(UITableViewCell*)favoritesCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //TDBadgedCell *cell = [[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Закладки";
    } else {
        localizationString = @"Favorites";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkFavImage = [vkhdBundle pathForResource:@"ios7-menufavorites" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkFavImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    favoritesCell = cell;
    return cell;
}

-(UITableViewCell*)settingsCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Настройки";
    } else {
        localizationString = @"Settings";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkSettingsImage = [vkhdBundle pathForResource:@"ios7-menusettings" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkSettingsImage];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    settingsCell = cell;
    return cell;
    
}

-(UITableViewCell*)accountsCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Смена аккаунта";
    } else {
        localizationString = @"Account change";
    }
    
    cell.textLabel.text = localizationString;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    ///////////NON JB////////////
    //
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkMyImage = [vkhdBundle pathForResource:@"Accounts" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkMyImage];
     //
    //////////////JB/////////////
    //cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Accounts.png"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    accountsCell = cell;
    return cell;
    
}

-(UITableViewCell*)VKPSettingsCell
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Настройки VKP";
    } else {
        localizationString = @"VKP settings";
    }
    
    cell.textLabel.text = localizationString;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    ///////////NON JB////////////
    //
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* vkpsettingsImage = [vkhdBundle pathForResource:@"VKPreferences" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:vkpsettingsImage];
    //
    //////////////JB/////////////
    //cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/VKPreferences.png"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    VKPSettingsCell = cell;
    return cell;
    
}

-(UITableViewCell*)offlineCell
{
    
    //static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell)
    {
        return cell;
    }
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell.textLabel.text = (RusLang) ? @"Оффлайн" : @"Offline";
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Полу-оффлайн";
    } else {
        localizationString = @"Half-offline";
    }
    
    cell.textLabel.text = localizationString;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    ///////////NON JB////////////
    //
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* offlineImage = [vkhdBundle pathForResource:@"Offline" ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:offlineImage];
    //
    //////////////JB/////////////
    //cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Offline.png"];
    //cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/zhdun.png"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell.selectedBackgroundView =  customColorView;
    switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    cell.accessoryView = switchView;
    if (switchView && [[settings objectForKey:@"sOffline"] boolValue]) [switchView setOn:YES animated:NO];
  		else [switchView setOn:NO animated:NO];
    //[[VKPreferences sharedInstance] loadSettings];
    [switchView addTarget:self action:@selector(offlineSwitch:) forControlEvents:UIControlEventValueChanged];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [switchView setOnTintColor:[UIColor colorWithRed:89.0f/255.0f green:125.0f/255.0f blue:163.0f/255.0f alpha:1]];
    [switchView autorelease];
    //NSLog (@"=========== |Offline cell created.| ===========");
    offlineCell = cell;
    [[VKPreferences sharedInstance] updateSettings];
    [[VKPreferences sharedInstance] loadSettings];
    return cell;
}

-(UITableViewCell*)dontReadCell
{
    //NSLog(@"=========== |Don't read cell created.| ===========");
    
    //static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell2 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell2.textLabel.text = (RusLang) ? @"Не читать" : @"Don't read";
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Не читать";
    } else {
        localizationString = @"Don't read";
    }
    
    cell2.textLabel.text = localizationString;
    cell2.textLabel.font = [UIFont systemFontOfSize:17];
    ///////////NON JB////////////
    //
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* dontreadImage = [vkhdBundle pathForResource:@"Dontread" ofType:@"png"];
    cell2.imageView.image = [UIImage imageWithContentsOfFile:dontreadImage];
    //
    //////////////JB/////////////
    //cell2.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Dontread.png"];
    
    cell2.backgroundColor = [UIColor clearColor];
    cell2.textLabel.backgroundColor = [UIColor clearColor];
    cell2.textLabel.textColor = [UIColor whiteColor];
    cell2.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell2.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell2.selectedBackgroundView =  customColorView;
    
    //Add switch for cell 2
    switchView2 = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell2.accessoryView = switchView2;
    if (switchView2 && [[settings objectForKey:@"sDontRead"] boolValue]) [switchView2 setOn:YES animated:NO];
    else [switchView2 setOn:NO animated:NO];
    //[[VKPreferences sharedInstance] loadSettings];
    [switchView2 addTarget:self action:@selector(dontReadSwitch:) forControlEvents:UIControlEventValueChanged];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [switchView2 setOnTintColor:[UIColor colorWithRed:89.0f/255.0f green:125.0f/255.0f blue:163.0f/255.0f alpha:1]];
    [switchView2 autorelease];
    //[tableView reloadData];
    dontReadCell = cell2;
    [[VKPreferences sharedInstance] updateSettings];
    [[VKPreferences sharedInstance] loadSettings];
    return cell2;
}

-(UITableViewCell*)hideTypeCell
{
    //NSLog(@"=========== |Don't type cell created.| ===========");
    //[[VKPreferences sharedInstance] loadSettings];
    //static NSString *CellIdentifier = @"Cell3";
    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell3 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell3.textLabel.text = (RusLang) ? @"Скрыть набор" : @"Hide typing";
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Скрыть набор";
    } else {
        localizationString = @"Hide typing...";
    }
    
    cell3.textLabel.text = localizationString;
    cell3.textLabel.font = [UIFont systemFontOfSize:17];
    ///////////NON JB////////////
    //
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* donttypeImage = [vkhdBundle pathForResource:@"Donttype" ofType:@"png"];
    cell3.imageView.image = [UIImage imageWithContentsOfFile:donttypeImage];
    //
    //////////////JB/////////////
    //cell3.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Donttype.png"];
    
    cell3.backgroundColor = [UIColor clearColor];
    cell3.textLabel.backgroundColor = [UIColor clearColor];
    cell3.textLabel.textColor = [UIColor whiteColor];
    cell3.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell3.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell3.selectedBackgroundView =  customColorView;
    
    //Add switch for cell 3.
    switchView3 = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell3.accessoryView = switchView3;
    if (switchView3 && [[settings objectForKey:@"sHideTyping"] boolValue]) [switchView3 setOn:YES animated:NO];
    else [switchView3 setOn:NO animated:NO];
    //[[VKPreferences sharedInstance] loadSettings];
    [switchView3 addTarget:self action:@selector(dontTypeSwitch:) forControlEvents:UIControlEventValueChanged];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    //switchView3.backgroundColor = [UIColor redColor];
    [switchView3 setOnTintColor:[UIColor colorWithRed:89.0f/255.0f green:125.0f/255.0f blue:163.0f/255.0f alpha:1]];
    [switchView3 autorelease];
    hideTypeCell = cell3;
    [[VKPreferences sharedInstance] updateSettings];
    [[VKPreferences sharedInstance] loadSettings];
    return cell3;
}

-(UITableViewCell*)testCell
{
    //NSLog(@"=========== |Test cell created.| ===========");
    [[VKPreferences sharedInstance] loadSettings];
    //static NSString *CellIdentifier = @"Cell4";
    UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell4 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell3.textLabel.text = (RusLang) ? @"Скрыть набор" : @"Hide typing";
    //cell4.tag = 325;
    //[cell4 addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(cell4.frame.origin.x + 180, cell4.frame.origin.y + 9, 100, 30)];
    [button addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 325;
    [cell4.contentView addSubview:button];
    
    //id contr = [[objc_getClass("iPadMainViewController") sharedInstance] init];
    //[contr openFeedback];
    cell4.textLabel.text = @"2.1 Beta";
    cell4.textLabel.font = [UIFont systemFontOfSize:17];
    cell4.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/VKPreferences.png"];
    cell4.backgroundColor = [UIColor clearColor];
    cell4.textLabel.backgroundColor = [UIColor clearColor];
    cell4.textLabel.textColor = [UIColor whiteColor];
    cell4.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;
    testCell = cell4;
    return cell4;
}
/*
-(void)yourButtonClicked:(UIButton*)sender
{
    BOOL clicked=1;
    if(clicked)
    {
        id contr = [[objc_getClass("iPadMainViewController") sharedInstance] init];
        [contr openFeedback];
    }
    
}
*/
-(UITableViewCell*)invokeOfflineCell
{
    //NSLog(@"=========== |Phantom offline cell created.| ===========");
    //[[VKPreferences sharedInstance] loadSettings];
    //static NSString *CellIdentifier = @"Cell5";
    UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell5 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell5.textLabel.text = (RusLang) ? @"Мнимый онлайн" : @"Phantom online";
    
    NSString *localizationString;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationString = @"Мнимый онлайн";
    } else {
        localizationString = @"Phantom online";
    }
    
    cell5.textLabel.text = localizationString;
    cell5.textLabel.font = [UIFont systemFontOfSize:17];
    ///////////NON JB////////////
    /*
    NSBundle* vkhdBundle = [NSBundle mainBundle];
    NSString* invokeImage = [vkhdBundle pathForResource:@"Phantom" ofType:@"png"];
    cell5.imageView.image = [UIImage imageWithContentsOfFile:invokeImage];
    */
    //////////////JB/////////////
    cell5.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Phantom.png"];
    
    cell5.backgroundColor = [UIColor clearColor];
    cell5.textLabel.backgroundColor = [UIColor clearColor];
    cell5.textLabel.textColor = [UIColor whiteColor];
    cell5.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell5.selectionStyle = UITableViewCellSelectionStyleGray;
    UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = backPressedColor;
    cell5.selectedBackgroundView =  customColorView;
    
    
    //Add switch for cell 5.
    switchView5 = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell5.accessoryView = switchView5;
    if (switchView5 && [[settings objectForKey:@"sInvoke"] boolValue]) [switchView5 setOn:YES animated:NO];
    else [switchView5 setOn:NO animated:NO];
    //[[VKPreferences sharedInstance] loadSettings];
    [switchView5 addTarget:self action:@selector(invokeSwitch:) forControlEvents:UIControlEventValueChanged];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    if ([[[[VKPreferences sharedInstance] settings] objectForKey:@"sColorChange"] boolValue])
    {
        [switchView5 setOnTintColor:[UIColor colorWithRed:89.0f/255.0f green:125.0f/255.0f blue:163.0f/255.0f alpha:1]];
        //[switchView5 setTintColor:[UIColor yellowColor]];
    }
    [switchView5 autorelease];
    invokeOfflineCell = cell5;
    [[VKPreferences sharedInstance] updateSettings];
    [[VKPreferences sharedInstance] loadSettings];
    return cell5;
}

-(UISwitch*)cacheSwitch
{
    [[VKPreferences sharedInstance] loadSettings];
    switchView4 = [[UISwitch alloc] initWithFrame:CGRectZero];
    if (switchView4 && [[settings objectForKey:@"sCacheAudio"] boolValue]) [switchView4 setOn:YES animated:NO];
    else [switchView4 setOn:NO animated:NO];
    [switchView4 addTarget:self action:@selector(cacheOn:) forControlEvents:UIControlEventValueChanged];
    [settings writeToFile:prefsFile atomically:NO];
    [[VKPreferences sharedInstance] saveSettings];
    [switchView4 setOnTintColor:[UIColor colorWithRed:89.0f/255.0f green:125.0f/255.0f blue:163.0f/255.0f alpha:1]];
    [switchView4 autorelease];
    [[VKPreferences sharedInstance] updateSettings];
    [[VKPreferences sharedInstance] loadSettings];
    cacheSwitch = switchView4;
    return switchView4;
    //NSLog(@"=========== |Switch created ^^| ===========");
}
/*
-(void)initCells
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //cell2.textLabel.text = (RusLang) ? @"Не читать" : @"Don't read";
    cell.textLabel.text = @"Не читать";
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Dontread.png"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.accessoryView = switchView;
    if (switchView && [[settings objectForKey:@"sOffline"] boolValue]) [switchView setOn:YES animated:NO];
  		else [switchView setOn:NO animated:NO];
    [switchView addTarget:self action:@selector(offlineOn:) forControlEvents:UIControlEventValueChanged];
    [settings writeToFile:prefsFile atomically:NO];
    [switchView autorelease];
    offlineCell = cell;
    [[VKPreferences sharedInstance] offlineCell];
}
*/

+(void)alertTest
{
    //AlerView
 
    [UIAlertView showWithTitle:@"VKPreferences"
                       message:@"VKPreferences 2.1.1 beta test. Welcome 😄🙌!"
             cancelButtonTitle:@"👍"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex])
                          {
                              
                          }
                      }];
}
/*
    //ActionSheet(NOT WORK)

    [UIActionSheet showInView:self.view
                    withTitle:@"Are you sure you want to delete all the things?"
            cancelButtonTitle:@"Cancel"
       destructiveButtonTitle:@"Delete all the things"
            otherButtonTitles:@[@"Just some of the things", @"Most of the things"]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                         NSLog(@"Chose %@", [actionSheet buttonTitleAtIndex:buttonIndex]);
                     }];

}
 */
@end
