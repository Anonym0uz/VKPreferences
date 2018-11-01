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
#import <Preferences/Preferences.h>

@interface PSTableCell : UITableViewCell
@end

@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

@interface CustomCell : PSTableCell <PreferencesTableCustomView> {
    UILabel *_label;
}
@end

@implementation CustomCell
- (id)initWithSpecifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
    
    if (self) {
        _label = [[UILabel alloc] initWithFrame:[self frame]];
        [_label setNumberOfLines:0];
        [_label setText:@"You can use attributed text to make this prettier."];
        [_label setBackgroundColor:[UIColor clearColor]];
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
// vim:ft=objc
