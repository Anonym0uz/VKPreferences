//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKObject.h"

@class NSString;

@interface VKGroupLink : VKObject
{
    NSString *_url;
    NSString *_name;
    NSString *_desc;
    NSString *_photo_50;
    NSString *_photo_100;
}

@property(copy, nonatomic) NSString *photo_100; // @synthesize photo_100=_photo_100;
@property(copy, nonatomic) NSString *photo_50; // @synthesize photo_50=_photo_50;
@property(copy, nonatomic) NSString *desc; // @synthesize desc=_desc;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(copy, nonatomic) NSString *url; // @synthesize url=_url;
- (void).cxx_destruct;

@end

