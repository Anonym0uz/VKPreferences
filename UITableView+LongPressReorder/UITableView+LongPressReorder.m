//
//  LPRTableView.m
//
//  Copyright (c) 2013 Ben Vogelzang.
//

#import "UITableView+LongPressReorder.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>


// The basic idea is simple: we add a long press gesture to the tableView, once the gesture is activeated,
// a placeholder view is created for the pressed cell, then we move the placeholder view as the touch goes on.
@interface LPRTableViewProxy : NSObject <LPRTableViewDelegate>

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, assign) CGFloat draggingViewOpacity;
@property (nonatomic, assign) BOOL canReorder;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) CADisplayLink *scrollDisplayLink;
@property (nonatomic, assign) CGFloat scrollRate;
@property (nonatomic, strong) NSIndexPath *currentLocationIndexPath;
@property (nonatomic, strong) NSIndexPath *initialIndexPath;
@property (nonatomic, strong) UIView *draggingView;

@end


@implementation LPRTableViewProxy

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_tableView addGestureRecognizer:_longPress];

        _canReorder = YES;
        _draggingViewOpacity = 0.85;
        _longPress.enabled = _canReorder;
    }
    
    return self;
}

- (void)setCanReorder:(BOOL)canReorder {
    _canReorder = canReorder;
    _longPress.enabled = _canReorder;
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
    
    int sections = [_tableView numberOfSections];
    int rows = 0;
    for(int i = 0; i < sections; i++)
    {
        rows += [_tableView numberOfRowsInSection:i];
    }
    
    // get out of here if the long press was not on a valid row or our table is empty
    // or the dataSource tableView:canMoveRowAtIndexPath: doesn't allow moving the row
    if (rows == 0 || (gesture.state == UIGestureRecognizerStateBegan && indexPath == nil) ||
        (gesture.state == UIGestureRecognizerStateEnded && self.currentLocationIndexPath == nil) ||
        (gesture.state == UIGestureRecognizerStateBegan &&
         [_tableView.dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)] &&
         indexPath && ![_tableView.dataSource tableView:_tableView canMoveRowAtIndexPath:indexPath])) {
        [self cancelGesture];
        return;
    }
    
    // started
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:NO animated:NO];
        [cell setHighlighted:NO animated:NO];
    }
    // dropped
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:YES animated:NO];
        [cell setHighlighted:YES animated:NO];
    }
}

- (void)cancelGesture {
    _longPress.enabled = NO;
    _longPress.enabled = YES;
}

@end


@implementation UITableView (LongPressReorder)

static void *LPRDelegateKey = &LPRDelegateKey;

- (void)setLprDelegate:(id<LPRTableViewDelegate>)LPRDelegate {
    id delegate = objc_getAssociatedObject(self, LPRDelegateKey);
    if (delegate != LPRDelegate) {
        objc_setAssociatedObject(self, LPRDelegateKey, LPRDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (id <LPRTableViewDelegate>)lprDelegate {
    id delegate = objc_getAssociatedObject(self, LPRDelegateKey);
    return delegate;
}

static void *LPRLongPressEnabledKey = &LPRLongPressEnabledKey;

- (void)setLongPressReorderEnabled:(BOOL)longPressReorderEnabled {
    BOOL isEnabled = [self isLongPressReorderEnabled];
    if (isEnabled != longPressReorderEnabled) {
        NSNumber *enabled = [NSNumber numberWithBool:longPressReorderEnabled];
        objc_setAssociatedObject(self, LPRLongPressEnabledKey, enabled, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self lprProxy].canReorder = longPressReorderEnabled;
    }
}

- (BOOL)isLongPressReorderEnabled {
    NSNumber *enabled = objc_getAssociatedObject(self, LPRLongPressEnabledKey);
    if (enabled == nil) {
        enabled = [NSNumber numberWithBool:NO];
        objc_setAssociatedObject(self, LPRLongPressEnabledKey, enabled, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [enabled boolValue];
}

static void *LPRProxyKey = &LPRProxyKey;

- (LPRTableViewProxy *)lprProxy {
    LPRTableViewProxy *proxy = objc_getAssociatedObject(self, LPRProxyKey);
    if (proxy == nil) {
        proxy = [[LPRTableViewProxy alloc] initWithTableView:self];
        objc_setAssociatedObject(self, LPRProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return proxy;
}

@end