//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKHTTPRequestOperation.h"

@class UIImage;

@interface VKImageRequestOperation : VKHTTPRequestOperation
{
    UIImage *_responseImage;
}

+ (_Bool)canProcessRequest:(id)arg1;
+ (id)acceptableContentTypes;
+ (id)imageRequestOperationWithRequest:(id)arg1 success:(CDUnknownBlockType)arg2 failure:(CDUnknownBlockType)arg3;
+ (id)networkRequestThread;
+ (void)networkRequestThreadEntryPoint:(id)arg1;
@property(retain, nonatomic) UIImage *responseImage; // @synthesize responseImage=_responseImage;
- (void).cxx_destruct;
- (void)setCompletionBlockWithSuccess:(CDUnknownBlockType)arg1 failure:(CDUnknownBlockType)arg2;
- (id)initWithRequest:(id)arg1;

@end
