//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "FBCacheDescriptor.h"

#import "FBGraphObjectPagingLoaderDelegate.h"

@class FBGraphObjectPagingLoader, NSSet, NSString;

@interface FBFriendPickerCacheDescriptor : FBCacheDescriptor <FBGraphObjectPagingLoaderDelegate>
{
    _Bool _hasCompletedFetch;
    _Bool _usePageLimitOfOne;
    NSSet *_fieldsForRequest;
    NSString *_userID;
    FBGraphObjectPagingLoader *_loader;
}

@property(nonatomic) _Bool usePageLimitOfOne; // @synthesize usePageLimitOfOne=_usePageLimitOfOne;
@property(nonatomic) _Bool hasCompletedFetch; // @synthesize hasCompletedFetch=_hasCompletedFetch;
@property(retain, nonatomic) FBGraphObjectPagingLoader *loader; // @synthesize loader=_loader;
@property(copy, nonatomic) NSString *userID; // @synthesize userID=_userID;
@property(copy, nonatomic) NSSet *fieldsForRequest; // @synthesize fieldsForRequest=_fieldsForRequest;
- (void)pagingLoaderDidFinishLoading:(id)arg1;
- (void)setUsePageLimitOfOne;
- (void)prefetchAndCacheForSession:(id)arg1;
- (void)dealloc;
- (id)initWithUserID:(id)arg1 fieldsForRequest:(id)arg2;
- (id)initWithFieldsForRequest:(id)arg1;
- (id)initWithUserID:(id)arg1;
- (id)init;

@end

