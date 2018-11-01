//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKResponse.h"

@class NSNumber, NSString, VKGroups, VKNotifications, VKUsers;

@interface notifications_get_res : VKResponse
{
    VKUsers *_profiles;
    VKGroups *_groups;
    VKNotifications *_items;
    NSNumber *_count;
    NSNumber *_last_viewed;
    NSNumber *_new_offset;
    NSString *_next_from;
}

@property(copy, nonatomic) NSString *next_from; // @synthesize next_from=_next_from;
@property(retain, nonatomic, getter=getNewOffset) NSNumber *new_offset; // @synthesize new_offset=_new_offset;
@property(retain, nonatomic) NSNumber *last_viewed; // @synthesize last_viewed=_last_viewed;
@property(retain, nonatomic) NSNumber *count; // @synthesize count=_count;
@property(retain, nonatomic) VKNotifications *items; // @synthesize items=_items;
@property(retain, nonatomic) VKGroups *groups; // @synthesize groups=_groups;
@property(retain, nonatomic) VKUsers *profiles; // @synthesize profiles=_profiles;
- (void).cxx_destruct;

@end
