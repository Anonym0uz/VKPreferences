//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIViewControllerStyled.h"

#import "UITableViewDataSource.h"
#import "UITableViewDelegate.h"

@class NSMutableArray, NSString, UINoDataLoadingView, UITableView;

@interface iPadBaseNewsViewController : UIViewControllerStyled <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    UINoDataLoadingView *_noDataView;
    NSMutableArray *_newsfeedsItems;
}

@property(readonly, nonatomic) NSMutableArray *newsfeedsItems; // @synthesize newsfeedsItems=_newsfeedsItems;
@property(retain, nonatomic) UINoDataLoadingView *noDataView; // @synthesize noDataView=_noDataView;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
- (void).cxx_destruct;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (void)sourcesWereBanned:(id)arg1;
- (void)repositionNoDataView;
- (void)viewWillAppear:(_Bool)arg1;
- (void)loadView;
- (id)init;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

