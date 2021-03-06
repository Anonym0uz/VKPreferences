//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "PostView.h"

@class CrossDissolveImageView, VKPhoto;

@interface PostPhotoView : PostView
{
    _Bool _disablePhoto;
    CrossDissolveImageView *_mainPhotoView;
    VKPhoto *_currentPhoto;
}

@property(retain, nonatomic) VKPhoto *currentPhoto; // @synthesize currentPhoto=_currentPhoto;
@property(retain, nonatomic) CrossDissolveImageView *mainPhotoView; // @synthesize mainPhotoView=_mainPhotoView;
@property(nonatomic) _Bool disablePhoto; // @synthesize disablePhoto=_disablePhoto;
- (void).cxx_destruct;
- (void)likesCountChanged:(id)arg1;
- (void)translateToDelegate:(id)arg1;
- (void)relayoutSubviews;
- (void)setFrameForCurrentLocation;
- (void)setPhoto:(id)arg1;
- (void)createLayout:(struct CGRect)arg1;

@end

