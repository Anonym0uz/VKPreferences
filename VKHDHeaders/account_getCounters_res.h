//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKResponse.h"

@class VKCounters;

@interface account_getCounters_res : VKResponse
{
    _Bool _ok;
    VKCounters *_response;
}

@property(nonatomic) _Bool ok; // @synthesize ok=_ok;
@property(retain, nonatomic) VKCounters *response; // @synthesize response=_response;
- (void).cxx_destruct;
- (id)initWithDictionary:(id)arg1;

@end

