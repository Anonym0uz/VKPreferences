//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "UIAlertViewDelegate.h"

@interface FBRequestConnectionRetryManagerAlertViewHelper : NSObject <UIAlertViewDelegate>
{
    CDUnknownBlockType _callback;
}

@property(copy, nonatomic) CDUnknownBlockType callback; // @synthesize callback=_callback;
- (void)dealloc;
- (void)alertView:(id)arg1 didDismissWithButtonIndex:(long long)arg2;
- (void)show:(id)arg1 message:(id)arg2 cancelButtonTitle:(id)arg3 handler:(CDUnknownBlockType)arg4;

@end
