//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKResponse.h"

@class NSNumber, VKChat;

@interface messages_setChatPhoto_res : VKResponse
{
    NSNumber *_message_id;
    VKChat *_chat;
}

@property(retain, nonatomic) VKChat *chat; // @synthesize chat=_chat;
@property(retain, nonatomic) NSNumber *message_id; // @synthesize message_id=_message_id;
- (void).cxx_destruct;

@end
