//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKResponse.h"

@class NSNumber;

@interface groups_isMember_res : VKResponse
{
    NSNumber *_member;
    NSNumber *_request;
    NSNumber *_invitation;
}

@property(retain, nonatomic) NSNumber *invitation; // @synthesize invitation=_invitation;
@property(retain, nonatomic) NSNumber *request; // @synthesize request=_request;
@property(retain, nonatomic) NSNumber *member; // @synthesize member=_member;
- (void).cxx_destruct;

@end
