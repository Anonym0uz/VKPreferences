//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

@class NSNumber;

@interface messages_get_req : VKRequest
{
    NSNumber *_out;
    NSNumber *_offset;
    NSNumber *_count;
    NSNumber *_time_offset;
    NSNumber *_filters;
    NSNumber *_preview_length;
    NSNumber *_last_message_id;
}

@property(retain, nonatomic) NSNumber *last_message_id; // @synthesize last_message_id=_last_message_id;
@property(retain, nonatomic) NSNumber *preview_length; // @synthesize preview_length=_preview_length;
@property(retain, nonatomic) NSNumber *filters; // @synthesize filters=_filters;
@property(retain, nonatomic) NSNumber *time_offset; // @synthesize time_offset=_time_offset;
@property(retain, nonatomic) NSNumber *count; // @synthesize count=_count;
@property(retain, nonatomic) NSNumber *offset; // @synthesize offset=_offset;
@property(retain, nonatomic) NSNumber *out; // @synthesize out=_out;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

@end

