//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MenuViewController.h"

@class NSArray, UIBarButtonItem, UIPopoverController, UIView, VKGroup, VKPost;

@interface PostMenuController : MenuViewController
{
    _Bool _forceWhite;
    _Bool _shouldShowNavigationController;
    VKPost *_currentPost;
    VKGroup *_currentGroup;
    id <PostMenuControllerDelegate> _delegate;
    UIView *_targetView;
    UIView *_sourceView;
    UIBarButtonItem *_sourceBarView;
    NSArray *_actionList;
    unsigned long long _arrowDirection;
    UIPopoverController *_popover;
    PostMenuController *_parent;
    CDUnknownBlockType _processSelectionBlock;
}

+ (id)menuWithActions:(id)arg1 completeBlock:(CDUnknownBlockType)arg2;
+ (id)showWithVideo:(id)arg1 fromView:(id)arg2 inView:(id)arg3;
+ (id)showWithPhoto:(id)arg1 andGroup:(id)arg2 fromBarButton:(id)arg3 inView:(id)arg4 location:(unsigned long long)arg5;
+ (id)showWithPhoto:(id)arg1 fromView:(id)arg2 inView:(id)arg3 location:(unsigned long long)arg4;
+ (id)showWithPost:(id)arg1 group:(id)arg2 postLocation:(unsigned long long)arg3 fromView:(id)arg4 inView:(id)arg5;
@property(copy, nonatomic) CDUnknownBlockType processSelectionBlock; // @synthesize processSelectionBlock=_processSelectionBlock;
@property(nonatomic) __weak PostMenuController *parent; // @synthesize parent=_parent;
@property(nonatomic) __weak UIPopoverController *popover; // @synthesize popover=_popover;
@property(nonatomic) unsigned long long arrowDirection; // @synthesize arrowDirection=_arrowDirection;
@property(nonatomic) _Bool shouldShowNavigationController; // @synthesize shouldShowNavigationController=_shouldShowNavigationController;
@property(retain, nonatomic) NSArray *actionList; // @synthesize actionList=_actionList;
@property(nonatomic) _Bool forceWhite; // @synthesize forceWhite=_forceWhite;
@property(nonatomic) __weak UIBarButtonItem *sourceBarView; // @synthesize sourceBarView=_sourceBarView;
@property(nonatomic) __weak UIView *sourceView; // @synthesize sourceView=_sourceView;
@property(nonatomic) __weak UIView *targetView; // @synthesize targetView=_targetView;
@property(nonatomic) __weak id <PostMenuControllerDelegate> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) VKGroup *currentGroup; // @synthesize currentGroup=_currentGroup;
@property(retain, nonatomic) VKPost *currentPost; // @synthesize currentPost=_currentPost;
- (void).cxx_destruct;
- (void)dismiss;
- (long long)preferredStatusBarStyle;
- (void)dealloc;
- (id)fontForLabels;
- (double)measureTitlesWidth;
@property(readonly, nonatomic) id popoverOwner;
- (void)presentPopover:(id)arg1;
- (void)makeMenuSelectionProcessWithAction:(id)arg1;
- (void)addActions:(id)arg1;
- (id)findMenuActionWithId:(id)arg1;
- (void)performAdsReportActionWithReason:(id)arg1;
- (void)performReportActionWithReason:(unsigned long long)arg1;
- (void)performDeleteAction;
@property(readonly, nonatomic) id <Attachable> currentAttachable;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (id)initWithActionsList:(id)arg1;
- (id)initWithPostLocation:(unsigned long long)arg1 post:(id)arg2 group:(id)arg3;
- (struct CGSize)calculateContentSize:(_Bool)arg1;
- (struct CGSize)preferredContentSize;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)copy;
- (void)showInPopoverFromView:(id)arg1 inView:(id)arg2;
- (void)showInPopoverFromBarButton:(id)arg1 inView:(id)arg2;

@end

