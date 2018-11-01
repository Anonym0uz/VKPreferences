//#import <UIKit/UIKit.h>
//#import <Preferences/Preferences.h>
//#import "substrate.h"
#import "VKPreferences.h"
//#import "Passcode/BKPasscodeField.h"
//#import "Passcode/BKPasscodeInputView.h"
//#import "Passcode/BKPasscodeViewController.h"
//#import "Passcode/BKShiftingView.h"
//#import "Passcode/BKPasscodeLockScreenManager.h"
//#import "Passcode/BKPasscodeDummyViewController.h"
//#import <UIKit/UIViewController.h>
#include <CoreFoundation/CFNotificationCenter.h>

NSNumber *testPostID;
NSNumber *testOwnerID;
NSNumber *testTime;
id currentAudio;
BOOL isCacheContr;

///////////VKHD NON-JB///////////
//
NSArray *values=[[NSArray alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkaccounts.plist"]];
NSMutableArray *keysez = [values valueForKey:@"Name"];
NSMutableDictionary *menu = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkmenu.plist"]];
NSMutableArray *enabled = [menu valueForKey:@"enabled"];
//
/////////////VKHD JB/////////////
/*
NSArray *values=[[NSArray alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkaccounts.plist"];
NSMutableArray *keysez = [values valueForKey:@"Name"];
NSMutableDictionary *menu; //= [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenu.plist"];
NSMutableArray *enabled; //= [menu valueForKey:@"enabled"];
*/

//NSBundle* myBundle = [NSBundle mainBundle];
//NSString* myImage = [myBundle pathForResource:@"ios7-menubadge" ofType:@"png"];

    //IF #import <objc/runtime.h>
    //[objc_getClass("VKPreferences") loadSettings];
    //IF +(void)loadSettings & not in tweak, but have app
    //[%c(VKPreferences) loadSettings];
    //IF -(void)loadSettings & not in tweak, but have app
    //[[%c(VKPreferences) sharedInstance].loadSettings method:loadSettings];

int cellIndex;
int cellIndexS;
int i;
UITableView *tableView;
BOOL firstStart = YES;
int saveButtonIndex;
int addButtonIndex;
BOOL pressedAnsw;
BOOL pressedGr;
int row2;
int prevRow;
//int counts;
//int counts2;
UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
NSIndexPath* newsCellIndexPath;
NSIndexPath *selectedIndexPath;
NSIndexPath *deselectedIndexPath;
NSIndexPath *prRow;
int messRow;
BOOL openMess = NO;
BOOL openAccChange = NO;
static NSString *CellIdentifier = @"MyCells";

///////////////////////////////////////////////
///////////////////HOOKS///////////////////////
///////////////////////////////////////////////
//Offline
%hook account_setOnline_req
-(id)getMethodName
{   
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] saveSettings];
    	return nil;
    }
    else
    {      
        [[VKPreferences sharedInstance] saveSettings];
        return %orig;
    }
}
%end
//
%hook auth_login_req
-(void)setClient_id:(NSString *)arg1
{
    //NSLog(@"CLIENT ID:%@", arg1);
    /*
    if(arg1)
    {
        NSNumber* type = (NSNumber*)[[[VKPreferences sharedInstance] settings] valueForKey: @"sClientType"];
        int idValue = [type intValue];
        switch(idValue)
        {
            case 0: // iPad
            arg1 = @"3682744";
            break;

            case 1: // iPhone
            arg1 = @"2274003";
            break;
            
            case 2: // Android
            arg1 = @"3140623";
            break;
        }   
    }
    */
    return %orig;
}
-(void)setClient_secret:(NSString *)arg1
{
    //NSLog(@"CLIENT SECRET:%@", arg1);
    /*
    if(arg1)
    {
        NSNumber* type = (NSNumber*)[[[VKPreferences sharedInstance] settings] valueForKey: @"sClientType"];
        int idValue = [type intValue];
        switch(idValue)
        {
            case 0: // iPad
            arg1 = @"mY6CDUswIVdJLCD3j15n";
            break;

            case 1: // iPhone
            arg1 = @"hHbZxrka2uZ6jB1inYsH";
            break;
            
            case 2: // Android
            arg1 = @"AlVXZFMUqyrnABp8ncuU";
            break;
        }   
    }
    */
    return %orig;
}
%end

//
//Don't read messages
%hook iPadChatViewController
-(void)markAsReadProc
{
    if(![[[[VKPreferences sharedInstance] settings] objectForKey:@"sDontRead"] boolValue])
    %orig;
}
%end

//Hide typing
%hook messages_setActivity_req
-(void)setType:(id)arg1
{
    if(![[[[VKPreferences sharedInstance] settings] objectForKey:@"sHideTyping"] boolValue])
    %orig;
}
%end

//Disable adult
%hook video_search_req
-(void)setFilters:(id)arg1
{
    if(![[[[VKPreferences sharedInstance] settings] objectForKey:@"sAdultOff"] boolValue])
    %orig;
}
%end

/*
%hook BufferedNavigationController
-(void)viewDidLoad
{
	%orig;
	NSNumber *myID = [[objc_getClass("VKUser") alloc] id];
	NSString *name = [[objc_getClass("VKUser") alloc] name];
	NSString *fName = [[objc_getClass("VKUser") alloc] first_name];
	NSString *sName = [[objc_getClass("VKUser") alloc] last_name];
	//[myID id:39391750];
	if([myID isEqual:@"39391750"] || [name isEqualToString:@"Александр Орлов"] || [fName isEqualToString:@"Александр"] && [sName isEqualToString:@"Орлов"])
	{
		[self.navigationItem setTitle:@"LOLZ"];
		//((UINavigationItem*)[self navigationItem]).titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"ios7-menubadge.png"]]];
		//UIImage *img = [UIImage imageNamed:@"1.png"];
		//UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		//[imgView setImage:img];
		// setContent mode aspect fit
		//[imgView setContentMode:UIViewContentModeScaleAspectFit];
		//self.navigationItem.titleView = imgView;
	}
}
%end
*/
/*
%hook wall_post_req

-(NSNumber *)publish_date
{
    NSDate *today = [NSDate date];
    //NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateComponents setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //int todayDay = [dateComponents day];
    //int todayMonth = [dateComponents month];
    //[dateComponents setMonth:arc4random_uniform(12) + todayMonth];
    //[dateComponents setDay:arc4random_uniform(days.length) + todayDay];

    //NSDate *startDate = [calendar dateFromComponents:dateComponentsFModTime];
    //NSDate *todayDate = [calendar dateFromComponents:dateComponents];
    NSDate *todayDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    
    
    //double ti = [startDate timeIntervalSince1970];
    double tid = [todayDate timeIntervalSince1970];
    //NSLog(@"Modified date:%f", ti);
    NSLog(@"Today date:%f", tid);



NSCalendar *cal = [NSCalendar currentCalendar];
NSDate *now = [NSDate date];
NSDateComponents *dc = [cal components: NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:now];
[dc setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
NSDate *newDate = [cal dateFromComponents:dc];

double tids = [newDate timeIntervalSince1970];
    //NSLog(@"Modified date:%f", ti);
    NSLog(@"Today date1:%f", tids);




    NSInteger numberOfSeconds = 5;
    NSDate *incrementedDate = [NSDate dateWithTimeInterval:numberOfSeconds sinceDate:newDate];
    double tsp = [incrementedDate timeIntervalSince1970];
    NSLog(@"Plus 30 seconds:%f", tsp);

    NSTimeInterval delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [[objc_getClass("iPadNewWallPostViewController") alloc] sendMessage];
                });
    NSNumber *test = [[NSNumber numberWithDouble:[incrementedDate timeIntervalSince1970]] retain];
    return test;

}
%end
*/

%hook messages_getHistory_req
- (id)getMethodName
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] halfOffline];
        return %orig;
    }
    else
        return %orig;
    
}
%end

%hook messages_send_req
-(id)init
{
    //NSLog(@"SEND INIT :%@",%orig);
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] halfOffline];
        return %orig;
    }
    else
        return %orig;
}
%end

%hook MessagesController
- (void)sendMessage:(id)arg1 withAttach:(id)arg2 withForwarded:(id)arg3
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] halfOffline];
        return %orig;
    }
    else
        return %orig;
}
%end

%hook messages_send_res
-(id)response
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] halfOffline];
        return %orig;
    }
    else
        return %orig;
}
%end

%hook VKRequest 
-(id)description
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] halfOffline];
        return %orig;
    }
    else
        return %orig;
}
%end
//EXECUTE
%hook execute_req
- (id)getMethodName
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sOffline"] boolValue]) 
    {
        [[VKPreferences sharedInstance] halfOffline];
        return %orig;
    }
    else
        return %orig;
}
%end
/*
%hook wall_post_res
-(void)setPost_id:(id)arg1
{
    %orig;
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sPostPone"] boolValue])
    {
        testPostID = arg1;
        NSLog(@"POST IDS:%@", arg1);
        return %orig(arg1);
    }
    else
    {
        return %orig(arg1);
    } 
}
%end

%hook iPadNewWallPostViewController
-(void)sendMessage
{
    [[objc_getClass("wall_post_res") alloc] setPost_id:testPostID];
    %orig;
    
}
%end
*/
%hook VKUser
-(int)blacklisted
{
    //NSLog(@"blacklisted:%i",%orig);
    return %orig;
}
%end

//Answers mark view
%hook notifications_markAsViewed_req
-(id)getMethodName
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sAnswers"] boolValue]) 
    {
    	return nil;
    }
    else
    {      
        return %orig;
    }
}
%end

//Remove user and groups adult.
%hook VKHTTPClient
-(NSMutableDictionary *)defaultHeaders
{
    /* GET MODEL + IOS VERSION + SYSTEM NAME
    NSString *platform = [UIDevice currentDevice].model;
    NSLog(@"[UIDevice currentDevice].model: %@",platform);
    NSLog(@"[UIDevice currentDevice].systemVersion: %@",[UIDevice currentDevice].systemVersion);
    NSLog(@"[UIDevice currentDevice].systemName: %@",[UIDevice currentDevice].systemName);
    */
    NSString *getIOSVer = [NSString stringWithFormat:@"com.vk.vkhd 10050 (VK app, iPhone OS %@, iPad, Scale/2)",[UIDevice currentDevice].systemVersion];
    NSMutableDictionary *defaultHeadDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
        @"gzip", @"Accept-Encoding", @"ru, en-us;q=0.8", @"Accept-Language", getIOSVer, @"User-Agent", nil];
    return defaultHeadDict;
}
%end

//Disable ADs
%hook adsint_hideAd_req
-(void)setAd_data:(id)arg1
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sDisableAd"] boolValue])
	   %orig(nil);
    else
        %orig;
}
%end

%hook VKPost
-(void)setAds:(id)arg1
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sDisableAd"] boolValue])
       %orig(nil);
    else
        %orig;
}
%end

//Return audio section
%hook ApplicationManager
+(BOOL)shouldHideMusicSection
{
	return FALSE;
}
+(BOOL)isMusicDisabled
{
	return FALSE;
}
+(BOOL)isCacheDisabled
{
    return FALSE;
}
+(void)disableCache:(BOOL)arg1
{
    return %orig(FALSE);
}
%end

%hook AudioPlayerController
-(id)playingAudio
{
    currentAudio = %orig;
    return %orig;
}
%end

%hook VKAudio
-(BOOL)ignoreCache
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sCacheAudio"] boolValue] && !isCacheContr)
    {
        [[%c(AudioPlayerController) sharedInstance] addAudioToCache:currentAudio];
        return FALSE;
    }
    else
        return TRUE;
}
%end

%hook CacheFileInfo
-(BOOL)updatingLink
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sCacheAudio"] boolValue] || !isCacheContr)
    {
        return TRUE;
    }
    else
        return FALSE;
}
%end

%hook iPadAudioListViewController
-(BOOL)isCache
{
    isCacheContr = YES;
    return %orig;
}
%end

//Switch to cache
%hook iPadCacheSwitch
-(void)setIsOn:(BOOL)arg1
{
    //NSLog(@"Cache orig switch is: %d", arg1);
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sCacheOn"] boolValue])
    {
        return %orig(TRUE);
        //NSLog(@"Cache switch is: %d", arg1);
    }
    else
        return %orig(FALSE);
    //NSLog(@"Cache switch is: %d", arg1);
}
-(BOOL)isOn
{
    //NSLog(@"Cache orig switch is: %d", %orig);
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sCacheOn"] boolValue])
    {
        //NSLog(@"Cache switch is: %d", %orig);
        return TRUE;
    }
    else
        return FALSE;
    //NSLog(@"Cache switch is: %d", %orig);
}
%end

%hook AppDelegate

- (void)applicationDidBecomeActive:(id)arg1
{
	%orig;
	[VKPreferences checkSettings];
    [VKPreferences checkAccounts];
    [VKPreferences checkMenu];
    menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
    enabled = [menu valueForKey:@"enabled"];
    [tableView reloadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

            //BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
        //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        //[self showModalViewController:navController];
    
    //if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sPINVKEnabled"] boolValue])
    //{    
    	//[VKPreferences isBiometricsAvailable];
    	//[VKPreferences touchIDOrPasswordEnable];
    	//BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
        //	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
       // 	[self showModalViewController:navController];	
    	
    	/*
        BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self showModalViewController:navController];
        */
    //}
    //if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sCheckUpdates"] boolValue])
    //{
        //[[VKPreferences sharedInstance] VKPTestVersion];
        //[[VKPreferences sharedInstance] dateReturn];
        //[[VKPreferences sharedInstance] reloadCounts];
        //[[VKPreferences sharedInstance] refreshTimer];
    //}
    //[[VKPreferences sharedInstance] dateReturn];
	//[VKPreferences alertTest];
        /*
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sInvoke"] boolValue])
	{
		//[[VKPreferences sharedInstance] invokeTimer];
		[[VKPreferences sharedInstance] offlineTimer];
	}
	*/
}
- (BOOL)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2
{
    //[VKPreferences JBcheck];
    NSString *localizationReason;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"])
    {
        localizationReason = @"Приложите палец для аутентификации.";
    }
    else
    {
        localizationReason = @"Scan your fingerprint for access.";
    }

    if ([[[[VKPreferences sharedInstance] settings] objectForKey:@"sTouchID"] boolValue])
    {
        LAContext *myContext = [[LAContext alloc] init];
        NSError *authError = nil;
        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {

        	BKPasscodeViewController *viewControllerCheckPin = [[VKPrefsPasscode sharedInstance] checkPINVC];
        	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewControllerCheckPin];
            [self showModalViewController:navController];
        
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                      localizedReason:localizationReason
                                reply:^(BOOL succes, NSError *error) {
                                
                                    if (succes) 
                                    {
                                    	[viewControllerCheckPin dismissViewControllerAnimated:YES completion:nil];
                                        //[self showMessage:@"Authentication is successful" withTitle:@"Success"];
                                        //NSLog(@"User authenticated");
                                    }
                                    else
                                    {
                                        switch (error.code) {
                                            case LAErrorAuthenticationFailed:
                                                [self showModalViewController:navController];
                                                break;
                                            
                                            case LAErrorUserCancel:
                                                [self showModalViewController:navController];
                                                //NSLog(@"User pressed Cancel button");
                                                break;
                                            
                                            case LAErrorUserFallback:
                                                [self showModalViewController:navController];
                                                //NSLog(@"User pressed \"Enter Password\"");
                                                break;
                                            
                                            case LAErrorTouchIDNotAvailable:
                                                [self showModalViewController:navController];
                                                //NSLog(@"Touch ID is not configured");
                                                break;

                                            case LAErrorTouchIDNotEnrolled:
                                                [self showModalViewController:navController];
                                                //[self showMessage:@"Touch ID is not configured" withTitle:@"Error"];
                                                //NSLog(@"Touch ID is not configured");
                                                break;
                                        }
                                    }
                                }];
        }
    }

    if ([[[[VKPreferences sharedInstance] settings] objectForKey:@"sTouchID"] boolValue] == NO && [[[[VKPreferences sharedInstance] settings] objectForKey:@"sPINVKEnabled"] boolValue])
    {
    	NSTimeInterval delayInSeconds = 2.0;
    	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BKPasscodeViewController *viewController = [[VKPrefsPasscode sharedInstance] checkPINVC];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self showModalViewController:navController];
    });
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return %orig;
}
%end

%hook iPadLoginViewController

-(void)TermsOfService:(id)arg1
{
    NSString *localizationCancelBtn;
    NSString *localizationAccChBtn;
    NSString *localizationRulesBtn;
    NSString *localizationCloseBtn;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationCancelBtn = @"Отмена";
        localizationAccChBtn = @"Сменить аккаунт";
        localizationRulesBtn = @"Правила сервиса";
        localizationCloseBtn = @"Закрыть";
    } else {
        localizationCancelBtn = @"Cancel";
        localizationAccChBtn = @"Accounts change";
        localizationRulesBtn = @"Rules";
        localizationCloseBtn = @"Close";
    }
    [UIAlertView showWithTitle:@"VKPreferences" message:nil cancelButtonTitle:localizationCancelBtn otherButtonTitles:@[localizationAccChBtn, localizationRulesBtn]
    tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            
        }
        else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationAccChBtn]) 
        {
        	UIViewController *accounts = [[VKAccounts alloc] init];
        	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:accounts];
        	//[navController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor yellowColor]}];
        	//[navController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor]]];
        	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                            initWithTitle:localizationCloseBtn
                                            style:UIBarButtonItemStyleBordered
                                            target:self
                                            action:@selector(closeView:)];
            accounts.navigationItem.leftBarButtonItem = closeButton;
        	[navController.navigationBar setTintColor:[UIColor whiteColor]];
        	[navController.navigationBar setBarTintColor:[UIColor colorWithRed:87.0/255.0 green:133.0/255.0 blue:183.0/255.0 alpha:1.0]];
        	[navController.navigationBar setTranslucent:NO];
        	[self presentViewController:navController animated:YES completion:nil];

            //[[VKPreferences sharedInstance] loginAlert];
        }
        else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:localizationRulesBtn]) 
        {
            %orig;
        }
    }];
}
%new
- (void)closeView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
%end
/*
//For add new button to %orig
@interface iPadFriendRequestsSelector : UIViewController
-(void)testMenu:(id)sender;
@end

%hook iPadChatViewController
-(void)viewDidLoad
{
    %orig;
    //UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Flip" style:UIBarButtonItemStyleBordered target:self action:@selector(flipView:)];
    //self.navigationItem.leftBarButtonItem = flipButton;
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testBtn:)];
    //UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setEditing:)];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:flipButton, nil]];
    //[flipButton release];
}
-(void)testBtn:(id)sender
{
}
%end
*/
/*
@interface VideoViewController : UIViewController
-(void)cacheMenu:(id)sender;
@end
%hook VideoViewController
-(void)viewDidLoad
{
    %orig;
    NSBundle* myBundle = [NSBundle mainBundle];
    NSString* myImage = [myBundle pathForResource:@"ios7-menuicon" ofType:@"png"];
    UIImage* imageMenu = [UIImage imageWithContentsOfFile:myImage];
    CGRect frameimg = CGRectMake(0,0,0,0);

    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageMenu forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(Back_btn:)
        forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];

    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    //UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Flip" style:UIBarButtonItemStyleBordered target:self action:@selector(flipView:)];
    //self.navigationItem.leftBarButtonItem = flipButton;
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testBtnz:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setEditing:)];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:mailbutton, flipButton, nil]];
    //[flipButton release];
}
%new
-(void)testBtnz:(id)sender
{
            UIViewController *videoCache = [[VKVideoCache alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:videoCache];
            //[navController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor yellowColor]}];
            //[navController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor]]];
            UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                            initWithTitle:@"Close"
                                            style:UIBarButtonItemStyleBordered
                                            target:self
                                            action:@selector(closeVideoCacheView:)];
            videoCache.navigationItem.leftBarButtonItem = closeButton;
            [navController.navigationBar setTintColor:[UIColor whiteColor]];
            [navController.navigationBar setBarTintColor:[UIColor colorWithRed:87.0/255.0 green:133.0/255.0 blue:183.0/255.0 alpha:1.0]];
            [navController.navigationBar setTranslucent:NO];
            [self presentViewController:navController animated:YES completion:nil];
}
%new
- (void)closeVideoCacheView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
%end
*/
/*
%hook iPadMainViewController 
-(id)pushBaseViewController:(id)arg1
{
    %orig;
    UINavigationController *navController = %orig;
    //UILabel *titleLabel = nil;
    //titleLabel.text = @"LOLZ";
    //navController.title = titleLabel.text;
    [navController setTitle:@"Some Title"];
    //if([navController.title isEqualToString:@"Александр Фомченко"])
    //{
        //navController.title = @"LOLZ";
    //    return navController.title = @"LOLZ";
    //}
    return navController.title;
}
%end
*/

@interface SidebarMenuController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *menuItems;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
-(void)createTableMenu;
-(void)viewDidLoad;
-(void)cofigureTableview;
@end

//HOOK IN UITableView left cell
%hook SidebarMenuController
/*
%new
- (void)viewWillAppear:(BOOL)animated {
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        //NSLog(@"Row 3 reloaded");
        [tableView endUpdates]; 
    });
    //
    //[self.tableView reloadData];
    //double delayInSeconds = 3.0;      
    //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);    
    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_after(popTime, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];

         });
       /// [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
      //  NSLog(@"Reload Complete!"); 
    //});
}

*/
-(void)loadView
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
    {   
        nil;
    }
    else
    {
    	%orig;
    }
}

-(void)viewDidLoad
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
    {
        //%orig;
        //nil;
    //[[VKSlideOutMenu sharedInstance] viewDidLoad];
    
    //[[VKPreferences sharedInstance] reloadCounts];
    menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
    enabled = [menu valueForKey:@"enabled"];	
    [tableView reloadData];
	[tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //id views = [UIView new];
    //[tableView setTableFooterView:views];
    tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [tableView setDelegate: self];
    [tableView setDataSource:self];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    [tableView release];
	UIColor *sepColor = [[UIColor colorWithRed:90.0f/255 green:90.0f/255 blue:90.0f/255 alpha:1] retain];
    [self setAutomaticallyAdjustsScrollViewInsets:FALSE];
    [self setEdgesForExtendedLayout:FALSE];
    [tableView setSeparatorColor:sepColor];
    [tableView setScrollsToTop:FALSE];
    [tableView setExclusiveTouch:TRUE];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.view = tableView;
    tableView.allowsSelection = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plistDidUpdate:) name:@"plistDidUpdate" object:nil];
    //[tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    //[tableView setTableView:self.tableView];
    //self.tableView = tableView;
    //dispatch_async(dispatch_get_main_queue(), ^{
     //   [tableView beginUpdates];
    //    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:messRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    //    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        //NSLog(@"Row 3 reloaded");
    //    [tableView endUpdates]; 
    //});
        //self.tableView.delegate = self;
        //self.tableView.dataSource = self;
        //NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        //[tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionBottom];
        //[[VKPreferences sharedInstance] reloadCounts];
        //[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        //self.tableView.longPressReorderEnabled = YES;
        //[tableView reloadData];
        //%orig;

    }
    
    else
    {
        //self.tableView.longPressReorderEnabled = YES;
        %orig;
    }

}
/*
%new
- (void)refresh:(UIRefreshControl *)refreshControl 
{
    //[[VKPreferences sharedInstance] reloadCounts];
    [self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom]; 
    [refreshControl endRefreshing];
}
*/
%new
- (UITableView *)tableView 
{
    menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
    enabled = [menu valueForKey:@"enabled"];
    return (UITableView *)self.view;
}

-(void)updateSelectedRow:(id)arg1
{
	//NSIndexPath *ipath = [tableView indexPathForSelectedRow];
	//[tableView reloadData];
	//[tableView selectRowAtIndexPath:ipath animated:NO scrollPosition:UITableViewScrollPositionNone];
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{ 
        nil;
		//[self.tableView reloadData];
	}
	else
	{
		%orig;
	}
	//%orig;
}
//

%new 
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
    {  
        
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 55, 0, 0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 55, 0, 0)];
    }
    }
}

/*
- (void)selectRow:(long long)arg1 userInteraction:(BOOL)arg2
{
	%orig;
	//[[VKPreferences sharedInstance] customsCells];
}

- (void)tableView:(id)arg1 didDeselectRowAtIndexPath:(id)arg2
{
	%orig;
	//[[VKPreferences sharedInstance] customsCells];
}
*/
%new
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
    	return YES;
    }
    else
    {
    	return NO;
    }
    
}

%new
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return UITableViewCellEditingStyleNone;
}

%new
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
    	return YES;
    }
    else
    {
    	return NO;
    }
}

%new
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
    	menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
    	enabled = [menu valueForKey:@"enabled"];
    	[tableView reloadSections:[NSIndexSet indexSetWithIndex:[enabled count]] withRowAnimation:UITableViewRowAnimationFade];
    	[tableView beginUpdates];
    	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    	[tableView reloadData];
    	[tableView endUpdates];
	}
}
/*
%new
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [enabled exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

%new
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
   		return YES;
   	}
   	else 
   	{
   		return NO;
   	}
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
        menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
        enabled = [menu valueForKey:@"enabled"];
        return enabled.count;
	}
	else
	{
		int a = %orig;
    	cellIndex = a;
    	return a + 4;
	}
}

%new
-(void)loginAlert
{
	[[VKPreferences sharedInstance] loginAlert];
    openAccChange = YES;
    //[[VKPreferences sharedInstance] openVKPAccounts];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
    {
        nil;
        prevRow = indexPath.row;
        prRow = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSLog(@"Prev selected row: %ld", (long)prevRow);
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else
    {
        %orig;
    }
}

- (long long)preferredStatusBarStyle
{
	return 1;
}

%new
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
    {
    //dispatch_async(dispatch_get_main_queue(), ^{
    
    //NSIndexPath *lastIndexPath = indexPath;
    //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, lastIndexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];

     //});
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    	[tableView reloadData];
    	[tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionNone];
    	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    	row2 = indexPath.row;
    	[tableView beginUpdates];
    	selectedIndexPath = [NSIndexPath indexPathForRow:row2 inSection:0];
    	deselectedIndexPath = [NSIndexPath indexPathForRow:prevRow inSection:0];
    	//NSLog(@"Prev selected row: %ld", (long)prevRow);
    	if (row2)
    	{
    		//[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
       		[cell setSelected:YES animated:NO];
       		[cell setHighlighted:YES animated:NO];
        	//cell.contentView.exclusiveTouch = YES;
        	//cell.exclusiveTouch = YES;
    	}
    	else if (prevRow)
    	{
        	[cell setSelected:NO animated:NO];
        	[cell setHighlighted:NO animated:NO];
    	}
    	[tableView endUpdates];
    
    	if([[enabled objectAtIndex:indexPath.row]isEqual:@"Моя страница"])
    	{
    	    [cell setHighlighted:YES animated:NO];
    	}
    
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Новости"])
    	{
    	    [[VKPreferences sharedInstance] openNews];
    	}
    
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Ответы"])
    	{
    	    [[VKPreferences sharedInstance] openFeedbacks];
    	    [tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionBottom];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Сообщения"])
    	{
    	    //cell.contentView.exclusiveTouch = YES;
    	    //cell.exclusiveTouch = YES;
    	    [[VKPreferences sharedInstance] openMessagez];
    	    [cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Друзья"])
    	{
    	    [[VKPreferences sharedInstance] openFriends];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Группы"])
    	{
    	    [[VKPreferences sharedInstance] openGroupsez];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Фотографии"])
    	{
    	    [[VKPreferences sharedInstance] openPhotoFeed];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Видеозаписи"])
    	{
    	    [[VKPreferences sharedInstance] openVideos];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Аудиозаписи"])
    	{
    	    [[VKPreferences sharedInstance] openAudios];        
    	    [cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Закладки"])
    	{
    	    [[VKPreferences sharedInstance] openFavorites];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Настройки"])
    	{
    	    [cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	    [[VKPreferences sharedInstance] openSettings];
    	    [tableView selectRowAtIndexPath:prRow animated:NO scrollPosition:UITableViewScrollPositionNone];
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Оффлайн"])
    	{
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];       
    	    [cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	}
    	/*
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Мнимый онлайн"])
    	{
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];       
    	    //[cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	}
    	*/
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Не читать"])
    	{
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];       
    	    [cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Скрыть набор"])
    	{
    	    //[tableView selectRowAtIndexPath:deselectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];       
    	    [cell setSelected:NO animated:NO];
    	    [cell setHighlighted:NO animated:NO];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Сменить аккаунт"])
    	{
    		//[cell setSelected:NO animated:NO];
    		//[tableView selectRowAtIndexPath:prRow animated:NO scrollPosition:UITableViewScrollPositionNone];
    	    [[VKPreferences sharedInstance] loginAlert];
    	}
    	else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"])
    	{
    	    [[VKPreferences sharedInstance] openVKPSettings];
    	    //[VKPreferences alertTest];
    	}
    
        [cell setNeedsLayout];
        [tableView layoutIfNeeded];
        //[tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"All rows: %ld, Selected row: %ld", (long)indexPath.row, (long)row2);
    }

    //else
    //{
    	//UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    	row2 = indexPath.row;
    	if(row2 == 14)
    	{
    		//[cell setSelected:NO animated:NO];
    		//[tableView selectRowAtIndexPath:prRow animated:NO scrollPosition:UITableViewScrollPositionNone];
    	    [[VKPreferences sharedInstance] loginAlert];
    	}
    	//else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"])
    	if(row2 == 15)
    	{
    	    [[VKPreferences sharedInstance] openVKPSettings];
    	    //[VKPreferences alertTest];
    	}
    //}
}
/*
%new
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isSelected]) {
        // Deselect manually.
        [tableView.delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];

        return nil;
    }

    return indexPath;
}
//
//
%new
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[
    if ([[enabled objectAtIndex:indexPath.row]isEqual:@"Новости"]) 
    {
        [cell setSelected:YES animated:NO];
    }
    else
    {
    	[cell setSelected:NO animated:NO];
    }
}
//
//
%new
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
 {
    [super setHighlighted:highlighted animated:animated];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath.row];
    if (highlighted)
    {
        
    }
    else
    {

    }
 }
*/
%new
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ( indexPath.section == 1 ) 
    {
    return nil;
    }
    return indexPath;
}
//
- (void)selectRow:(long long)arg1 userInteraction:(BOOL)arg2
{	
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
		arg1 = row2;
        //arg2 = arg2;
		//arg2 = FALSE;
		//nil;
	}
	else
	{
		%orig;
	}
}


-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    //NSIndexPath *ipath = [tableView indexPathForSelectedRow];
    //[tableView reloadData];
    //[tableView selectRowAtIndexPath:ipath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
    {
        //menu = [[NSMutableDictionary alloc] initWithContentsOfFile:menuFile];
        //enabled = [menu valueForKey:@"enabled"];
        //NSString *CellIdentifier = [enabled objectAtIndex:indexPath.row];
        nil;
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    	//UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    	if (!cell) 
    	{
    	    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    	}
    	cell.selectionStyle = UITableViewCellSelectionStyleGray;
    	UIView *customColorView = [[UIView alloc] init];
    	customColorView.backgroundColor = backPressedColor;
    	customColorView.layer.masksToBounds = YES;
    	cell.selectedBackgroundView =  customColorView;
    	cell.textLabel.font = [UIFont systemFontOfSize:17];
    	cell.backgroundColor = [UIColor clearColor];
	    cell.textLabel.textColor = [UIColor whiteColor];
	    cell.textLabel.backgroundColor = [UIColor clearColor];
	    //cell.textLabel.text = [enabled objectAtIndex:indexPath.row];

	    if([[enabled objectAtIndex:indexPath.row]isEqual:@"Моя страница"])
	    {
	        cell = %orig;
	        return cell;
	    }
	    //
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Новости"])
	    {
	        return [[VKPreferences sharedInstance] newsCell];    
	        /*
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
			*/
	    }    
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Ответы"])
	    {
	    return [[VKPreferences sharedInstance] feedbackCell];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Сообщения"])
	    {       
	    //messRow = [[enabled objectAtIndex:indexPath.row]isEqual:@"Сообщения"];
	        //cell.contentView.exclusiveTouch = YES;
	        //cell.exclusiveTouch = YES;
	        return [[VKPreferences sharedInstance] messagesCell];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Друзья"])
	    {
	    return [[VKPreferences sharedInstance] friendsCell];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Группы"])
	    {
	        return [[VKPreferences sharedInstance] groupsCell];
	    }   
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Фотографии"])
	    {
	        return [[VKPreferences sharedInstance] photoFeedCell];
	        /*
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
	        */
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Видеозаписи"])
	    {
	        return [[VKPreferences sharedInstance] videosCell];
	        /*
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
	        */
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Аудиозаписи"])
	    {
	        //cell.contentView.exclusiveTouch = YES;
	        //cell.exclusiveTouch = YES;
	        return [[VKPreferences sharedInstance] audioCell];
	        /*
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
	        */
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Закладки"])
	    {
	        return [[VKPreferences sharedInstance] favoritesCell];
	        /*
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
	        */
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Настройки"])
	    {
	        return [[VKPreferences sharedInstance] settingsCell];
	        /*
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
	        */
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Помощь"])
	    {
	        cell.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/OVKIcons/menuhelp.png"];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Оффлайн"])
	    {
	        return [[VKPreferences sharedInstance] offlineCell];
	    }
	    /*
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Мнимый онлайн"])
	    {
	        return [[VKPreferences sharedInstance] invokeOfflineCell];
	    }
	    */
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Не читать"])
	    {
	        return [[VKPreferences sharedInstance] dontReadCell];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Скрыть набор"])
	    {
	        return [[VKPreferences sharedInstance] hideTypeCell];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Сменить аккаунт"])
	    {
	        return [[VKPreferences sharedInstance] accountsCell];
	    }
	    else if([[enabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"])
	    {
	        return [[VKPreferences sharedInstance] VKPSettingsCell];
	    }    
	    //
	    //[cell release];
	    //[tableView release];
	    return cell;

	    }
		else
		{
			UITableViewCell *r = %orig;
		/*
		if(indexPath.row == cellIndex - 2)
		{
			UITableViewCell *cell6;
	    	cell6 = %orig;
	    	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	   	 	button.frame = CGRectMake(cell6.frame.origin.x + 180, cell6.frame.origin.y + 9, 100, 30);
	        UIImage* accountsImage = [UIImage imageNamed:@"Accounts.png"];
	        [button setImage:accountsImage forState:UIControlStateNormal];
	    	[button addTarget:self action:@selector(loginAlert) forControlEvents:UIControlEventTouchUpInside];
	    	button.backgroundColor= [UIColor clearColor];
	    	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sAccountsChange"] boolValue])
	    	{
	    		[cell6.contentView addSubview:button];
	    	}
	    	else
	    	{
	    		return cell6;
	    	}
    	return cell6;
		}
		*/
	
			if(indexPath.row == cellIndex - 1)
		    {
		    	return [[VKPreferences sharedInstance] offlineCell];
		    }
		    //else if (indexPath.row == cellIndex)
		    //{
		    	//return [[VKPreferences sharedInstance] invokeOfflineCell];
		    //}
		    else if (indexPath.row == cellIndex)
		    {
		    	return [[VKPreferences sharedInstance] dontReadCell];
		    }
		    else if (indexPath.row == cellIndex + 1)
		    {
		        return [[VKPreferences sharedInstance] hideTypeCell];
		    }
		    else if (indexPath.row == cellIndex + 2)
		    {
		        return [[VKPreferences sharedInstance] accountsCell];
		    }
		    else if (indexPath.row == cellIndex + 3)
		    {
		        return [[VKPreferences sharedInstance] VKPSettingsCell];
		    }
		    return r;
    	}
}
//}

%end

%hook iPadMainViewController
- (void)closeMessages
{
    %orig;
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
    	openMess = NO;
    }
}
- (void)openMessages
{
    %orig;
    if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
    	openMess = YES;
    }
}
- (void)unreadMessagesDidChanged:(id)arg1
{
	if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sMenuChange"] boolValue])
	{
	    if(openMess == YES)
	    {
	        [tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
	        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:prevRow inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionNone];
	    }
	    
	    else if (openMess == NO || openAccChange == YES)
	    {
	        [tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
	        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row2 inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionNone];
	        double delayInSeconds = 5.0;      
	        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);    
	        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	        dispatch_after(popTime, queue, ^{
	        dispatch_async(dispatch_get_main_queue(), ^{
	            openAccChange = NO;
	            //[tableView reloadData];
	            //[tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
	            //[tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionNone];
	        });
	    });
	    }
	}
	else
	{
		%orig;
	}
}
%end

//Hook in UITableViewCell cacheCell
%hook iPadAudioListViewController
/*
%new
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

       UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Cache" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
          //insert your editAction here
        [[%c(AudioPlayerController) sharedInstance] addAudioToCache:currentAudio];
       }];
       editAction.backgroundColor = [UIColor blueColor];

       UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Удалить"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
          //%orig;
       }];
       deleteAction.backgroundColor = [UIColor redColor];
return @[deleteAction,editAction];
}
*/
%end
%hook iPadAudioViewController
-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{   
	UITableViewCell *r = %orig;
    if(indexPath.row == 3 && indexPath.section == 0)
    {
   		//static NSString *CellIdentifier5 = @"Cell5";
    	UITableViewCell *cell5; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
    	cell5 = %orig;
    
    	//Add switch
        if([[[[VKPreferences sharedInstance] settings] objectForKey:@"sCacheOn"] boolValue])
        {
    	   cell5.accessoryView = [[VKPreferences sharedInstance] cacheSwitch];
        }
    	return cell5;
    }
    return r;
}
%end

%hook SettingsViewController
/*
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 6)
    {
        int a = %orig;
        cellIndexS = a;
        //NSLog(@"Rows in section 3 = %i", a);
        return a + 1;
    }
    return %orig;
}
-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    tableView = [[UITableView alloc] init];
    UITableViewCell *r = %orig;
    if (!r) 
        {
            r = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    if(indexPath.row == cellIndex)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell)
        {
            return cell;
        }
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    cell.textLabel.text = @"IGPreferences";
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    //NSBundle* vkhdBundle = [NSBundle mainBundle];
    //NSString* vkPhotoImage = [vkhdBundle pathForResource:@"ios7-menuphotos" ofType:@"png"];
    //cell.imageView.image = [UIImage imageWithContentsOfFile:vkPhotoImage];
    //cell.backgroundColor = [UIColor clearColor];
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //UIColor *backPressedColor = [UIColor colorWithRed:48.0/255.0 green:58.0/255.0 blue:70.0/255.0 alpha:1];
    //UIView *customColorView = [[UIView alloc] init];
    //customColorView.backgroundColor = backPressedColor;
    //cell.selectedBackgroundView =  customColorView;
    return cell;
    }
    return r;
}
- (long long)numberOfSectionsInTableView:(id)arg1
{
    NSLog(@"================Number of sections:%ld=====================", (long)%orig);
    return %orig;
}
*/
%end
//POSTNOTIFICATION
static void updateSettings(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	[VKPreferences sharedInstance].settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
}

//Constructor
%ctor
{
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
    [VKPreferences sharedInstance].settings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsFile];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updateSettings, CFSTR("ru.anonz.vkpreferencesbundle.post"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updateSettings, CFSTR("plistDidUpdate"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    //[VKPreferences checkAccounts];
    [VKPreferences checkSettings];
    [VKPreferences checkAccounts];
    [VKPreferences checkMenu];
    [VKPreferences updateMenu];
	[[VKPreferences sharedInstance] loadSettings];
	[[VKPreferences sharedInstance] updateSettings];
    if([[VKPreferences teamIDReferences] containsObject:[VKPreferences getTeamIdForProfile:[[VKPreferences sharedInstance] provisioningProfile]]]) 
        exit(0);
    [pool release];
}