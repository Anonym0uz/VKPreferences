//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

@class NSNumber, NSString;

@interface board_getComments_req : VKRequest
{
    NSNumber *_group_id;
    NSNumber *_topic_id;
    NSNumber *_extended;
    NSNumber *_count;
    NSNumber *_offset;
    NSString *_sort;
}

@property(copy, nonatomic) NSString *sort; // @synthesize sort=_sort;
@property(retain, nonatomic) NSNumber *offset; // @synthesize offset=_offset;
@property(retain, nonatomic) NSNumber *count; // @synthesize count=_count;
@property(retain, nonatomic) NSNumber *extended; // @synthesize extended=_extended;
@property(retain, nonatomic) NSNumber *topic_id; // @synthesize topic_id=_topic_id;
@property(retain, nonatomic) NSNumber *group_id; // @synthesize group_id=_group_id;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

@end
