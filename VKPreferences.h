#import <objc/runtime.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <Preferences/PSViewController.h>
#import <QuartzCore/QuartzCore.h>
#import "vkpreferencesbundle/UIAlertView+Blocks.h"
#import "compareVersion/NSString+CompareToVersion.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <notify.h>
#import "version.h"
//#import "VKVideoCache.h"
//#import "UITableView+LongPressReorder/UITableView+LongPressReorder.h"
#import <Foundation/NSTask.h>
#import "VKHDClass.h"
#import "AnyCounter.h"
#import "FBEncrypt/FBEncryptorAES.h"
#import "FBEncrypt/NSData+Base64.h"
#import "TDBadge/TDBadgedCell.h"
#import "vkpreferencesbundle/VKPreferencesLogo.h"
#import "vkpreferencesbundle/VKAccounts.h"
#import "VKPrefsPasscode.h"
#import "vkpreferencesbundle/VKMenu.h"
#import <Preferences/PSListController.h>
#import "VersionComparator/VersionComparator.h"
#import "vkpreferencesbundle/VKPPaths.h"
#import "UAObfuscatedString/UAObfuscatedString.h"

@interface VKPreferences : NSObject
{
    BOOL _printZ;
}
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) UINavigationController *navMain;
@property (retain, nonatomic) PSListController *vkpsettingscontr;
@property(nonatomic, retain) UIPopoverController *popoverController;
@property (atomic, retain) NSMutableDictionary *settings;
@property (nonatomic, strong) NSMutableArray *enabled;
@property (nonatomic, strong) UITableViewCell *newsCell;
@property (nonatomic, strong) UITableViewCell *feedbackCell;
@property (nonatomic, strong) UITableViewCell *messagesCell;
@property (nonatomic, strong) UITableViewCell *friendsCell;
@property (nonatomic, strong) UITableViewCell *groupsCell;
@property (nonatomic, strong) UITableViewCell *photoFeedCell;
@property (nonatomic, strong) UITableViewCell *videosCell;
@property (nonatomic, strong) UITableViewCell *audioCell;
@property (nonatomic, strong) UITableViewCell *favoritesCell;
@property (nonatomic, strong) UITableViewCell *settingsCell;
@property (nonatomic, strong) UITableViewCell *accountsCell;
@property (nonatomic, strong) UITableViewCell *VKPSettingsCell;
@property (nonatomic, strong) UITableViewCell *offlineCell;
@property (nonatomic, strong) UITableViewCell *invokeOfflineCell;
@property (nonatomic, strong) UITableViewCell *dontReadCell;
@property (nonatomic, strong) UITableViewCell *hideTypeCell;
@property (nonatomic, strong) UITableViewCell *cacheCell;
@property (nonatomic, strong) UITableViewCell *testCell;
@property (nonatomic, strong) UISwitch *cacheSwitch;
@property (nonatomic, retain) NSTimer *offlineTimer;
@property (nonatomic, retain) NSTimer *refreshTimer;
@property (strong) NSDictionary *provisioningProfile;
@property (atomic) int timerWorking;
@property (atomic) int messCount;
+(VKPreferences *) sharedInstance;
-(VKPreferences *) init;
//SETTINGS METHODS
//+(BOOL)JBcheck;
-(void)getUser;
+(void)checkSettings;
+(void)checkAccounts;
+(void)checkMenu;
+(void)updateMenu;
-(void)loadSettings;
-(void)updateSettings;
-(void)saveSettings;
///////////////////////////////
/////MENU METHODS AND BUILD////
///////////////////////////////
-(void)accountChange;
-(void)openNews;
-(void)openFriends;
-(void)openSelf;
-(void)openFavorites;
-(void)openSettings;
-(void)openPhotoFeed;
-(void)openVideos;
-(void)openGroupsez;
-(void)openFeedbacks;
-(void)openAudios;
-(void)openMessagez;
-(void)openVKPSettings;
-(void)openVKPAccounts;
-(void)reloadCounts;
//-(id)customsCells;
-(void)smartPost;
//-(int)postPone;
-(double)dateReturn;
-(void)halfOffline;
//- (void)reloadTimes;
//-(void)invokeTimer;
//-(void)phantomOnline;

//Check
+(NSArray*) teamIDReferences;
+(NSString*) getTeamIdForProfile:(NSDictionary*)profile;
+(NSDictionary*) getProvisioningProfileForPath:(NSString*)path;
+(NSString*) substringString:(NSString*)string from:(NSString*)prefix to:(NSString*)suffix;

//VERSION
//-(void)VKPVersion;
//-(void)VKPTestVersion;
-(void)loginAlert;
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
//-(void)enableTimer:(NSTimer *)timer;
//-(void)switchTest;
+(void)alertTest;
@end
