//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIViewControllerStyled.h"

#import "UITableViewDataSource.h"
#import "UITableViewDelegate.h"

@class NSMutableArray, NSMutableDictionary, NSString, UINoDataLoadingView, UISegmentedControl, UITableView, UITableViewController;

@interface iPadFeedbackViewController : UIViewControllerStyled <UITableViewDataSource, UITableViewDelegate>
{
    _Bool newsfeedsCommentsLoading;
    _Bool newsfeedsCommentsEndReached;
    NSMutableArray *newsfeedsComments;
    NSMutableArray *commentsSections;
    NSMutableDictionary *newsfeedsCommentsIds;
    NSString *new_from;
    NSString *guid;
    _Bool feedbackLoading;
    _Bool feedbackEndReached;
    NSMutableArray *feedbackSections;
    NSMutableDictionary *feedbackIds;
    NSString *new_from_feedback;
    long long _totalFeedback;
    UITableViewController *_commentsViewController;
    UITableView *_wallTableComments;
    UINoDataLoadingView *_noDataViewComments;
    UISegmentedControl *_barViewSegment;
    UITableViewController *_feedbackViewController;
    UITableView *_wallTableFeedback;
    UINoDataLoadingView *_noDataViewFeedback;
}

+ (void)openParentTopic:(id)arg1;
@property(retain, nonatomic) UINoDataLoadingView *noDataViewFeedback; // @synthesize noDataViewFeedback=_noDataViewFeedback;
@property(retain, nonatomic) UITableView *wallTableFeedback; // @synthesize wallTableFeedback=_wallTableFeedback;
@property(retain, nonatomic) UITableViewController *feedbackViewController; // @synthesize feedbackViewController=_feedbackViewController;
@property(retain, nonatomic) UISegmentedControl *barViewSegment; // @synthesize barViewSegment=_barViewSegment;
@property(retain, nonatomic) UINoDataLoadingView *noDataViewComments; // @synthesize noDataViewComments=_noDataViewComments;
@property(retain, nonatomic) UITableView *wallTableComments; // @synthesize wallTableComments=_wallTableComments;
@property(retain, nonatomic) UITableViewController *commentsViewController; // @synthesize commentsViewController=_commentsViewController;
- (void).cxx_destruct;
- (void)reloadFeedback:(id)arg1;
- (void)reloadAllData;
- (void)unsubscribed:(id)arg1;
- (void)openNotificationParent:(id)arg1;
- (void)openNotification:(id)arg1;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didEndDisplayingCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (_Bool)tableView:(id)arg1 shouldHighlightRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)getTotalFeedbackCount;
- (void)feedbackDidLoaded:(id)arg1;
- (void)newsCommentsDidLoaded:(id)arg1;
- (void)selectTab:(id)arg1;
- (void)checkData:(id)arg1;
- (void)refreshControlFiredEvent:(id)arg1;
- (void)update;
- (void)applicationDidBecomeActive:(id)arg1;
- (void)dealloc;
- (void)viewWillAppear:(_Bool)arg1;
- (void)loadView;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

