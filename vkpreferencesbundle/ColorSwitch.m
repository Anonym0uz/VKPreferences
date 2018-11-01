#import "ColorSwitch.h"
@implementation ColorSwitch

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [((UISwitch *)[self control]) setOnTintColor:[UIColor colorWithRed:89.0f/255.0f green:125.0f/255.0f blue:163.0f/255.0f alpha:1]];
    //[((UISwitch *)[self control]) setTintColor:[UIColor clearColor]];
}

@end