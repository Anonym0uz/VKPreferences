//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSNumber, VKUser;

@interface TypingUser : NSObject
{
    _Bool _isNew;
    double _lastTime;
    VKUser *_u;
    NSNumber *_userId;
    NSNumber *_chatId;
}

@property(nonatomic) _Bool isNew; // @synthesize isNew=_isNew;
@property(retain, nonatomic) NSNumber *chatId; // @synthesize chatId=_chatId;
@property(retain, nonatomic) NSNumber *userId; // @synthesize userId=_userId;
@property(retain, nonatomic) VKUser *u; // @synthesize u=_u;
@property(nonatomic) double lastTime; // @synthesize lastTime=_lastTime;
- (void).cxx_destruct;
- (id)description;

@end

