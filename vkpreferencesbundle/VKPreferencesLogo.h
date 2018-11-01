//#import <Preferences/Preferences.h>
//#import <Foundation/NSTask.h>

//#import <Preferences/Preferences.h>
//Для надписи сверху, 2 библиотеки снизу.
#import <Preferences/PSViewController.h>
#import <Preferences/PSDetailController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIViewController.h>
#import "VKPrefsPasscode.h"
#import "UIAlertView+Blocks.h"
#import "VKPPaths.h"

@interface VKPreferencesLogo : PSTableCell
@property (nonatomic, strong) UIImageView *logoImageView;
@end
//Нужно для надписи сверху контроллера
@protocol PreferencesTableCustomView
//- (id)initWithSpecifier:(id)arg1;
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end
//Нужно для надписи сверху контроллера
@interface PSTableCell ()
- (id)initWithStyle:(int)style reuseIdentifier:(id)arg2;
@end
@interface VKPreferencesBundleListController: PSListController {
}
@end //IF NOT COMPILE