//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

@class NSNumber, NSString;

@interface likes_getList_req : VKRequest
{
    NSString *_type;
    NSNumber *_owner_id;
    NSNumber *_item_id;
    NSNumber *_page_url;
    NSNumber *_filter;
    NSNumber *_friends_only;
    NSNumber *_extended;
    NSNumber *_offset;
    NSNumber *_count;
}

@property(retain, nonatomic) NSNumber *count; // @synthesize count=_count;
@property(retain, nonatomic) NSNumber *offset; // @synthesize offset=_offset;
@property(retain, nonatomic) NSNumber *extended; // @synthesize extended=_extended;
@property(retain, nonatomic) NSNumber *friends_only; // @synthesize friends_only=_friends_only;
@property(retain, nonatomic) NSNumber *filter; // @synthesize filter=_filter;
@property(retain, nonatomic) NSNumber *page_url; // @synthesize page_url=_page_url;
@property(retain, nonatomic) NSNumber *item_id; // @synthesize item_id=_item_id;
@property(retain, nonatomic) NSNumber *owner_id; // @synthesize owner_id=_owner_id;
@property(copy, nonatomic) NSString *type; // @synthesize type=_type;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

@end
