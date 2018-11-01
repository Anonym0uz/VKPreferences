//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray, NSString;

@interface CacheFileInfo : NSObject
{
    _Bool _cached;
    _Bool _needCache;
    _Bool _updatingLink;
    NSString *_audio_id;
    NSString *_owner_id;
    NSString *_cachePath;
    NSString *_destinationPath;
    unsigned long long _totalWrited;
    unsigned long long _totalSize;
    NSMutableArray *_ranges;
}

@property(retain, nonatomic) NSMutableArray *ranges; // @synthesize ranges=_ranges;
@property(nonatomic) _Bool updatingLink; // @synthesize updatingLink=_updatingLink;
@property(nonatomic) _Bool needCache; // @synthesize needCache=_needCache;
@property(nonatomic) _Bool cached; // @synthesize cached=_cached;
@property(nonatomic) unsigned long long totalSize; // @synthesize totalSize=_totalSize;
@property(nonatomic) unsigned long long totalWrited; // @synthesize totalWrited=_totalWrited;
@property(copy, nonatomic) NSString *destinationPath; // @synthesize destinationPath=_destinationPath;
@property(copy, nonatomic) NSString *cachePath; // @synthesize cachePath=_cachePath;
@property(copy, nonatomic) NSString *owner_id; // @synthesize owner_id=_owner_id;
@property(copy, nonatomic) NSString *audio_id; // @synthesize audio_id=_audio_id;
- (void).cxx_destruct;
- (id)init;

@end
