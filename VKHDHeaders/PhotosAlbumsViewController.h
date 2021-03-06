//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UITableViewControllerStyled.h"

#import "AlbumCreateViewControllerDelegate.h"
#import "UIAlertViewDelegate.h"
#import "UIPopoverControllerDelegate.h"
#import "UITableViewDataSource.h"
#import "UITableViewDelegate.h"

@class NSMutableArray, NSMutableDictionary, NSNumber, NSString, UIButton, UINoDataLoadingView, UIPopoverController, VKPhotoAlbum;

@interface PhotosAlbumsViewController : UITableViewControllerStyled <UITableViewDelegate, UITableViewDataSource, AlbumCreateViewControllerDelegate, UIAlertViewDelegate, UIPopoverControllerDelegate>
{
    _Bool createAlbum;
    NSString *guid;
    NSMutableArray *getAlbumsArray;
    NSMutableDictionary *getAlbumsDict;
    NSNumber *ownerId;
    _Bool loading;
    _Bool endReached;
    long long currentOffset;
    NSNumber *albumsUpdateTime;
    VKPhotoAlbum *deletingAlbum;
    _Bool isAdmin;
    UIPopoverController *popover;
    _Bool _zeroInset;
    UIButton *_plusButton;
    id <PhotosViewDelegate> _delegate;
    NSNumber *_mainAlbumId;
    UIButton *_backButton;
    UINoDataLoadingView *_noDataView;
}

@property(retain, nonatomic) UINoDataLoadingView *noDataView; // @synthesize noDataView=_noDataView;
@property(retain, nonatomic) UIButton *backButton; // @synthesize backButton=_backButton;
@property(retain, nonatomic) NSNumber *mainAlbumId; // @synthesize mainAlbumId=_mainAlbumId;
@property(nonatomic) _Bool zeroInset; // @synthesize zeroInset=_zeroInset;
@property(nonatomic) __weak id <PhotosViewDelegate> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) UIButton *plusButton; // @synthesize plusButton=_plusButton;
- (void).cxx_destruct;
- (void)popoverControllerDidDismissPopover:(id)arg1;
- (void)alertView:(id)arg1 didDismissWithButtonIndex:(long long)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)photoAlbumsDidFinishLoadingWithStatus:(id)arg1;
- (void)didChangePhotoAlbum:(id)arg1;
- (void)didDeletePhotoAlbum:(id)arg1;
- (void)albumButtonPressed:(id)arg1;
- (void)plusButtonPressed:(id)arg1;
- (void)backButtonPressed:(id)arg1;
- (void)albumWasCreated:(id)arg1;
- (void)openAlbum:(id)arg1;
- (void)checkData:(id)arg1;
- (void)applicationDidBecomeActive:(id)arg1;
- (void)dealloc;
- (void)willAnimateRotationToInterfaceOrientation:(long long)arg1 duration:(double)arg2;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (struct CGSize)preferredContentSize;
- (id)initWithUid:(id)arg1 createAlbum:(_Bool)arg2 isAdmin:(_Bool)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

