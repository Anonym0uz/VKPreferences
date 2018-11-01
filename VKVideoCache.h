#import <Preferences/Preferences.h>
#import <Preferences/PSViewController.h>
#import <Preferences/PSDetailController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <sys/utsname.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>
/////////////////////////////////////////////
///////////////VKHD APP NON-JB///////////////
/////////////////////////////////////////////
//#define passcodePath [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpasscode.plist"]
//#define settingsPath [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.anonz.vkpreferencesbundle.plist"]
/////////////////////////////////////////////
/////////////////VKHD APP JB/////////////////
/////////////////////////////////////////////
//#define passcodePath @"/var/mobile/Library/Preferences/ru.anonz.vkpasscode.plist"
//#define settingsPath @"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"

@interface VKVideoCache : UIViewController <UITableViewDataSource, UITableViewDelegate>
+(VKVideoCache *) sharedInstance;
- (UITableView *)tableView;
@end