//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

@class NSNumber, NSString;

@interface wall_repost_req : VKRequest
{
    NSNumber *_group_id;
    NSString *_object;
    NSString *_attachments;
    NSString *_message;
}

@property(copy, nonatomic) NSString *message; // @synthesize message=_message;
@property(copy, nonatomic) NSString *attachments; // @synthesize attachments=_attachments;
@property(copy, nonatomic) NSString *object; // @synthesize object=_object;
@property(retain, nonatomic) NSNumber *group_id; // @synthesize group_id=_group_id;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

@end
