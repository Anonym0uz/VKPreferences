//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIViewControllerStyled.h"

#import "FriendsViewDelegate.h"
#import "MessagesViewDelegate.h"

@class FriendsView, MessagesView, NSMutableArray, NSString, UIButton, UISegmentedControl, UIView, VKAudio, VKDocument, VKPhoto, VKPost, VKVideo;

@interface SendToSelectViewController : UIViewControllerStyled <FriendsViewDelegate, MessagesViewDelegate>
{
    UIButton *backButton;
    FriendsView *friendsView;
    UIView *BarView;
    UISegmentedControl *BarViewSegment;
    MessagesView *messagesView;
    NSMutableArray *forwardedMessages;
    VKPost *forwardedPost;
    VKVideo *forwardedVideo;
    VKPhoto *forwardedPhoto;
    VKAudio *forwardedAudio;
    VKDocument *forwardedDocument;
}

@property(retain, nonatomic) VKDocument *forwardedDocument; // @synthesize forwardedDocument;
@property(retain, nonatomic) VKAudio *forwardedAudio; // @synthesize forwardedAudio;
@property(retain, nonatomic) VKPhoto *forwardedPhoto; // @synthesize forwardedPhoto;
@property(retain, nonatomic) VKVideo *forwardedVideo; // @synthesize forwardedVideo;
@property(retain, nonatomic) VKPost *forwardedPost; // @synthesize forwardedPost;
@property(retain, nonatomic) NSMutableArray *forwardedMessages; // @synthesize forwardedMessages;
@property(retain, nonatomic) MessagesView *messagesView; // @synthesize messagesView;
@property(retain, nonatomic) UISegmentedControl *BarViewSegment; // @synthesize BarViewSegment;
@property(retain, nonatomic) UIView *BarView; // @synthesize BarView;
@property(retain, nonatomic) FriendsView *friendsView; // @synthesize friendsView;
@property(retain, nonatomic) UIButton *backButton; // @synthesize backButton;
- (void).cxx_destruct;
- (void)dialogDidSelected:(id)arg1;
- (void)selectedFriendsDidChanged;
- (void)DoneButtonPressed:(id)arg1;
- (void)backButtonPressed:(id)arg1;
- (void)selectTab;
- (unsigned long long)supportedInterfaceOrientations;
- (_Bool)shouldAutorotateToInterfaceOrientation:(long long)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (void)loadView;
- (void)dealloc;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

