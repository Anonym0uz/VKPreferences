//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "GroupsSearchDataSource.h"

@class NSString, UISearchBar;

@interface GlobalSearchDataSource : GroupsSearchDataSource
{
    long long _searchPage;
    long long _pagesMiss;
    UISearchBar *_searchBar;
    NSString *_guid;
}

@property(copy, nonatomic) NSString *guid; // @synthesize guid=_guid;
@property(nonatomic) __weak UISearchBar *searchBar; // @synthesize searchBar=_searchBar;
- (void).cxx_destruct;
- (_Bool)preventUppercase;
- (id)postLoadingString;
- (id)cellForRow:(long long)arg1;
- (void)reset;
- (void)loadNextBlock:(_Bool)arg1;
- (void)loadNextBlock;
- (void)activityIndicatorReached;
- (_Bool)loadable;
- (double)heightForRow:(long long)arg1;
- (_Bool)canShowTitle;
- (unsigned long long)numberOfRowsInSection;
- (id)titleForSection;
- (id)init;

@end

