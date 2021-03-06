//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class HNKCache, NSOperation, NSOperationQueue, NSString;

@interface HNKCacheFormat : NSObject
{
    _Bool _allowUpscaling;
    NSOperationQueue *_diskOutQueue;
    NSOperationQueue *_diskInQueue;
    double _compressionQuality;
    NSString *_name;
    long long _scaleMode;
    unsigned long long _diskCapacity;
    unsigned long long _memoryCapacity;
    unsigned long long _numberRequestsToPerformClean;
    unsigned long long _diskSize;
    long long _preloadPolicy;
    CDUnknownBlockType _preResizeBlock;
    CDUnknownBlockType _postResizeBlock;
    HNKCache *_cache;
    unsigned long long _requestCount;
    unsigned long long _cacheActionsCount;
    NSOperation *_lastCacheControlOperation;
    struct CGSize _size;
}

@property(retain, nonatomic) NSOperation *lastCacheControlOperation; // @synthesize lastCacheControlOperation=_lastCacheControlOperation;
@property(nonatomic) unsigned long long cacheActionsCount; // @synthesize cacheActionsCount=_cacheActionsCount;
@property(nonatomic) unsigned long long requestCount; // @synthesize requestCount=_requestCount;
@property(nonatomic) __weak HNKCache *cache; // @synthesize cache=_cache;
@property(copy, nonatomic) CDUnknownBlockType postResizeBlock; // @synthesize postResizeBlock=_postResizeBlock;
@property(copy, nonatomic) CDUnknownBlockType preResizeBlock; // @synthesize preResizeBlock=_preResizeBlock;
@property(nonatomic) long long preloadPolicy; // @synthesize preloadPolicy=_preloadPolicy;
@property(nonatomic) unsigned long long diskSize; // @synthesize diskSize=_diskSize;
@property(nonatomic) unsigned long long numberRequestsToPerformClean; // @synthesize numberRequestsToPerformClean=_numberRequestsToPerformClean;
@property(nonatomic) unsigned long long memoryCapacity; // @synthesize memoryCapacity=_memoryCapacity;
@property(nonatomic) unsigned long long diskCapacity; // @synthesize diskCapacity=_diskCapacity;
@property(nonatomic) long long scaleMode; // @synthesize scaleMode=_scaleMode;
@property(nonatomic) struct CGSize size; // @synthesize size=_size;
@property(readonly, nonatomic) NSString *name; // @synthesize name=_name;
@property(nonatomic) double compressionQuality; // @synthesize compressionQuality=_compressionQuality;
@property(nonatomic) _Bool allowUpscaling; // @synthesize allowUpscaling=_allowUpscaling;
@property(retain, nonatomic) NSOperationQueue *diskInQueue; // @synthesize diskInQueue=_diskInQueue;
@property(retain, nonatomic) NSOperationQueue *diskOutQueue; // @synthesize diskOutQueue=_diskOutQueue;
- (void).cxx_destruct;
@property(readonly, nonatomic) NSString *directory;
- (void)registerDiskInOperation:(id)arg1;
- (id)resizedImageFromImage:(id)arg1;
- (id)initWithName:(id)arg1;

@end

