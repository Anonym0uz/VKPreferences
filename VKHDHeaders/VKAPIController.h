//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKHTTPClient.h"

#import "ReachabilityWatcher.h"

@class NSMutableArray, NSMutableDictionary, NSNumber, NSOperationQueue, NSString, VKRequest;

@interface VKAPIController : VKHTTPClient <ReachabilityWatcher>
{
    VKRequest *captchaRequest;
    NSMutableArray *captchaDelayedRequests;
    _Bool networkWasUnavailable;
    _Bool _https_required;
    _Bool _force_https;
    _Bool _is24hour;
    _Bool _isLoadingShowed;
    NSString *_access_token;
    NSString *_secret;
    NSNumber *_user_id;
    NSNumber *_expires_in;
    NSMutableDictionary *_requestDictionary;
    NSMutableArray *_allRequests;
    NSOperationQueue *_networkOperationQueue;
}

+ (id)sharedInstance;
+ (id)logViewController;
+ (id)apiVersion;
@property(retain, nonatomic) NSOperationQueue *networkOperationQueue; // @synthesize networkOperationQueue=_networkOperationQueue;
@property(retain, nonatomic) NSMutableArray *allRequests; // @synthesize allRequests=_allRequests;
@property(retain, nonatomic) NSMutableDictionary *requestDictionary; // @synthesize requestDictionary=_requestDictionary;
@property(readonly, nonatomic) NSNumber *expires_in; // @synthesize expires_in=_expires_in;
@property(retain, nonatomic) NSNumber *user_id; // @synthesize user_id=_user_id;
@property(copy, nonatomic) NSString *secret; // @synthesize secret=_secret;
@property(copy, nonatomic) NSString *access_token; // @synthesize access_token=_access_token;
@property(readonly, nonatomic) _Bool isLoadingShowed; // @synthesize isLoadingShowed=_isLoadingShowed;
@property(nonatomic) _Bool is24hour; // @synthesize is24hour=_is24hour;
@property(nonatomic) _Bool force_https; // @synthesize force_https=_force_https;
@property(nonatomic) _Bool https_required; // @synthesize https_required=_https_required;
- (void).cxx_destruct;
- (void)captchaDidCanceled:(id)arg1;
- (void)captchaDidFinished:(id)arg1;
- (void)reachabilityChanged;
- (void)sendOffline;
- (void)unregisterPush;
- (void)registerPush;
- (id)deviceId;
- (void)logout;
- (void)cleanUp;
- (void)setUseHTTPS:(_Bool)arg1;
- (void)removeRequestFromDictionary:(id)arg1;
- (void)bindRequest:(id)arg1 toGuid:(id)arg2;
- (void)cancelRequestsForGuid:(id)arg1;
- (void)processResultFromRequest:(id)arg1;
- (void)failWithCaptchaRequest:(id)arg1;
- (void)sendRequest:(id)arg1 viaHTTPS:(_Bool)arg2;
- (void)sendRequest:(id)arg1;
@property(readonly, nonatomic) _Bool https;
- (void)saveSession:(id)arg1 clean:(_Bool)arg2;
- (_Bool)wakeUpSession;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

