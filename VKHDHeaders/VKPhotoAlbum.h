//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKObject.h"

#import "Attachable.h"

@class NSNumber, NSString, VKPhoto, VKPhotoSizes, VKPrivacy;

@interface VKPhotoAlbum : VKObject <Attachable>
{
    _Bool _is_main_album;
    NSNumber *_id;
    NSNumber *_thumb_id;
    NSNumber *_owner_id;
    NSString *_title;
    NSString *_Mdescription;
    NSNumber *_created;
    NSNumber *_updated;
    NSNumber *_size;
    VKPrivacy *_privacy_view;
    VKPrivacy *_privacy_comment;
    NSNumber *_can_upload;
    VKPhoto *_thumb;
    VKPhotoSizes *_sizes;
}

@property(nonatomic) _Bool is_main_album; // @synthesize is_main_album=_is_main_album;
@property(retain, nonatomic) VKPhotoSizes *sizes; // @synthesize sizes=_sizes;
@property(retain, nonatomic) VKPhoto *thumb; // @synthesize thumb=_thumb;
@property(retain, nonatomic) NSNumber *can_upload; // @synthesize can_upload=_can_upload;
@property(retain, nonatomic) VKPrivacy *privacy_comment; // @synthesize privacy_comment=_privacy_comment;
@property(retain, nonatomic) VKPrivacy *privacy_view; // @synthesize privacy_view=_privacy_view;
@property(retain, nonatomic) NSNumber *size; // @synthesize size=_size;
@property(retain, nonatomic) NSNumber *updated; // @synthesize updated=_updated;
@property(retain, nonatomic) NSNumber *created; // @synthesize created=_created;
@property(copy, nonatomic) NSString *Mdescription; // @synthesize Mdescription=_Mdescription;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@property(retain, nonatomic) NSNumber *owner_id; // @synthesize owner_id=_owner_id;
@property(retain, nonatomic) NSNumber *thumb_id; // @synthesize thumb_id=_thumb_id;
@property(retain, nonatomic) NSNumber *id; // @synthesize id=_id;
- (void).cxx_destruct;
- (id)attachmentStringLight;
- (id)attachmentString;
- (id)objectString;
- (id)initWithDictionary:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

