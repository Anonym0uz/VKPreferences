//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "FBGraphObjectPickerViewController.h"

#import "FBGraphObjectViewControllerDelegate.h"

@class NSString, NSTimer;

@interface FBPlacePickerViewController : FBGraphObjectPickerViewController <FBGraphObjectViewControllerDelegate>
{
    _Bool _hasSearchTextChangedSinceLastQuery;
    long long _radiusInMeters;
    long long _resultsLimit;
    NSString *_searchText;
    NSTimer *_searchTextChangedTimer;
    CDStruct_2c43369c _locationCoordinate;
}

+ (id)requestForPlacesSearchAtCoordinate:(CDStruct_2c43369c)arg1 radiusInMeters:(long long)arg2 resultsLimit:(long long)arg3 searchText:(id)arg4 fields:(id)arg5 datasource:(id)arg6 session:(id)arg7;
+ (id)firstRenderLogString;
+ (unsigned long long)graphObjectPagingMode;
+ (id)cacheDescriptorWithLocationCoordinate:(CDStruct_2c43369c)arg1 radiusInMeters:(long long)arg2 searchText:(id)arg3 resultsLimit:(long long)arg4 fieldsForRequest:(id)arg5;
@property(retain, nonatomic) NSTimer *searchTextChangedTimer; // @synthesize searchTextChangedTimer=_searchTextChangedTimer;
@property(copy, nonatomic) NSString *searchText; // @synthesize searchText=_searchText;
@property(nonatomic) long long resultsLimit; // @synthesize resultsLimit=_resultsLimit;
@property(nonatomic) long long radiusInMeters; // @synthesize radiusInMeters=_radiusInMeters;
@property(nonatomic) CDStruct_2c43369c locationCoordinate; // @synthesize locationCoordinate=_locationCoordinate;
- (id)graphObjectTableDataSource:(id)arg1 pictureUrlOfItem:(id)arg2;
- (id)graphObjectTableDataSource:(id)arg1 subtitleOfItem:(id)arg2;
- (id)graphObjectTableDataSource:(id)arg1 titleOfItem:(id)arg2;
- (_Bool)graphObjectTableDataSource:(id)arg1 filterIncludesItem:(id)arg2;
- (void)logAppEvents:(_Bool)arg1;
- (void)searchTextChangedTimerFired:(id)arg1;
- (id)createSearchTextChangedTimer;
- (void)loadDataSkippingRoundTripIfCached:(id)arg1;
- (_Bool)delegateIncludesGraphObject:(id)arg1;
- (void)notifyDelegateOfError:(id)arg1;
- (void)notifyDelegateSelectionDidChange;
- (void)notifyDelegateDataDidChange;
- (void)loadDataThrottledSkippingRoundTripIfCached:(id)arg1;
- (void)configureDataSource:(id)arg1;
- (void)configureUsingCachedDescriptor:(id)arg1;
@property(readonly, retain, nonatomic) id <FBGraphPlace> selection;
- (void)dealloc;
- (void)initializePlacePicker;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;
- (id)initWithCoder:(id)arg1;

@end

