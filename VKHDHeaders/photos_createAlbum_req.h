//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

#import "CreateAlbumRequest.h"

@class NSNumber, NSString;

@interface photos_createAlbum_req : VKRequest <CreateAlbumRequest>
{
    NSNumber *_privacy;
    NSString *_title;
    NSNumber *_comment_privacy;
    NSString *_Mdescription;
    NSNumber *_group_id;
}

@property(retain, nonatomic) NSNumber *group_id; // @synthesize group_id=_group_id;
@property(copy, nonatomic) NSString *Mdescription; // @synthesize Mdescription=_Mdescription;
@property(retain, nonatomic) NSNumber *comment_privacy; // @synthesize comment_privacy=_comment_privacy;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@property(retain, nonatomic) NSNumber *privacy; // @synthesize privacy=_privacy;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(copy, nonatomic) CDUnknownBlockType didFailedBlock;
@property(copy, nonatomic) CDUnknownBlockType didFinishBlock;
@property(readonly) unsigned long long hash;
@property(copy, nonatomic) CDUnknownBlockType processingBlock;
@property(retain, nonatomic) id <VKResponse> response;
@property(copy, nonatomic) NSString *senderGUID;
@property(readonly) Class superclass;

@end
