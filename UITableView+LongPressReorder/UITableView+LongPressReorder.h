//
//  UITableView+LongPressReorder.h
//
//  Copyright (c) 2013 wtl.
//


#import <UIKit/UIKit.h>

@protocol LPRTableViewDelegate

@end


@interface UITableView (LongPressReorder)

@property (nonatomic, assign, getter = isLongPressReorderEnabled) BOOL longPressReorderEnabled;
@property (nonatomic, assign) id <LPRTableViewDelegate> lprDelegate;

@end

