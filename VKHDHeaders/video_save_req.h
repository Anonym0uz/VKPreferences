//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKRequest.h"

@class NSNumber, NSString;

@interface video_save_req : VKRequest
{
    NSString *_name;
    NSString *_Mdescription;
    NSNumber *_is_private;
    NSNumber *_wallpost;
    NSString *_link;
    NSNumber *_group_id;
    NSNumber *_album_id;
    NSNumber *_repeat;
}

@property(retain, nonatomic) NSNumber *repeat; // @synthesize repeat=_repeat;
@property(retain, nonatomic) NSNumber *album_id; // @synthesize album_id=_album_id;
@property(retain, nonatomic) NSNumber *group_id; // @synthesize group_id=_group_id;
@property(copy, nonatomic) NSString *link; // @synthesize link=_link;
@property(retain, nonatomic) NSNumber *wallpost; // @synthesize wallpost=_wallpost;
@property(retain, nonatomic) NSNumber *is_private; // @synthesize is_private=_is_private;
@property(copy, nonatomic) NSString *Mdescription; // @synthesize Mdescription=_Mdescription;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
- (void).cxx_destruct;
- (Class)responseClass;
- (id)getMethodName;

@end
