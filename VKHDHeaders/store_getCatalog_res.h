//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKResponse.h"

@class VKStoreBanners, VKStoreSections;

@interface store_getCatalog_res : VKResponse
{
    VKStoreBanners *_banners;
    VKStoreSections *_sections;
}

@property(retain, nonatomic) VKStoreSections *sections; // @synthesize sections=_sections;
@property(retain, nonatomic) VKStoreBanners *banners; // @synthesize banners=_banners;
- (void).cxx_destruct;

@end
