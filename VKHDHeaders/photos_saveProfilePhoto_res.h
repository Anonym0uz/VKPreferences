//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKResponse.h"

@class NSString;

@interface photos_saveProfilePhoto_res : VKResponse
{
    NSString *_photo_hash;
    NSString *_photo_src;
    NSString *_photo_src_big;
    NSString *_photo_src_small;
    NSString *_post_id;
}

@property(copy, nonatomic) NSString *post_id; // @synthesize post_id=_post_id;
@property(copy, nonatomic) NSString *photo_src_small; // @synthesize photo_src_small=_photo_src_small;
@property(copy, nonatomic) NSString *photo_src_big; // @synthesize photo_src_big=_photo_src_big;
@property(copy, nonatomic) NSString *photo_src; // @synthesize photo_src=_photo_src;
@property(copy, nonatomic) NSString *photo_hash; // @synthesize photo_hash=_photo_hash;
- (void).cxx_destruct;

@end

