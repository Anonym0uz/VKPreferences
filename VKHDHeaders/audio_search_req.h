//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

@class NSNumber, NSString;

@interface audio_search_req : VKRequest
{
    NSString *_q;
    NSNumber *_auto_complete;
    NSNumber *_lyrics;
    NSNumber *_performer_only;
    NSNumber *_sort;
    NSNumber *_search_own;
    NSNumber *_count;
    NSNumber *_offset;
}

@property(retain, nonatomic) NSNumber *offset; // @synthesize offset=_offset;
@property(retain, nonatomic) NSNumber *count; // @synthesize count=_count;
@property(retain, nonatomic) NSNumber *search_own; // @synthesize search_own=_search_own;
@property(retain, nonatomic) NSNumber *sort; // @synthesize sort=_sort;
@property(retain, nonatomic) NSNumber *performer_only; // @synthesize performer_only=_performer_only;
@property(retain, nonatomic) NSNumber *lyrics; // @synthesize lyrics=_lyrics;
@property(retain, nonatomic) NSNumber *auto_complete; // @synthesize auto_complete=_auto_complete;
@property(copy, nonatomic) NSString *q; // @synthesize q=_q;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

@end
