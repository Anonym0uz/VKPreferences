//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class BITAuthenticator, BITCrashManager, BITFeedbackManager, BITHockeyAppClient, BITStoreUpdateManager, BITUpdateManager, NSString;

@interface BITHockeyManager : NSObject
{
    NSString *_appIdentifier;
    NSString *_liveIdentifier;
    _Bool _validAppIdentifier;
    _Bool _startManagerIsInvoked;
    _Bool _startUpdateManagerIsInvoked;
    _Bool _managersInitialized;
    BITHockeyAppClient *_hockeyAppClient;
    _Bool _disableCrashManager;
    _Bool _disableUpdateManager;
    _Bool _enableStoreUpdateManager;
    _Bool _disableFeedbackManager;
    _Bool _appStoreEnvironment;
    _Bool _debugLogEnabled;
    id <BITHockeyManagerDelegate> _delegate;
    NSString *_serverURL;
    BITCrashManager *_crashManager;
    BITUpdateManager *_updateManager;
    BITStoreUpdateManager *_storeUpdateManager;
    BITFeedbackManager *_feedbackManager;
    BITAuthenticator *_authenticator;
    NSString *_installString;
    NSString *_userID;
    NSString *_userName;
    NSString *_userEmail;
}

+ (id)sharedHockeyManager;
@property(retain, nonatomic) NSString *userEmail; // @synthesize userEmail=_userEmail;
@property(retain, nonatomic) NSString *userName; // @synthesize userName=_userName;
@property(retain, nonatomic) NSString *userID; // @synthesize userID=_userID;
@property(nonatomic, getter=isDebugLogEnabled) _Bool debugLogEnabled; // @synthesize debugLogEnabled=_debugLogEnabled;
@property(readonly, nonatomic) NSString *installString; // @synthesize installString=_installString;
@property(readonly, nonatomic, getter=isAppStoreEnvironment) _Bool appStoreEnvironment; // @synthesize appStoreEnvironment=_appStoreEnvironment;
@property(readonly, nonatomic) BITAuthenticator *authenticator; // @synthesize authenticator=_authenticator;
@property(nonatomic, getter=isFeedbackManagerDisabled) _Bool disableFeedbackManager; // @synthesize disableFeedbackManager=_disableFeedbackManager;
@property(readonly, nonatomic) BITFeedbackManager *feedbackManager; // @synthesize feedbackManager=_feedbackManager;
@property(nonatomic, getter=isStoreUpdateManagerEnabled) _Bool enableStoreUpdateManager; // @synthesize enableStoreUpdateManager=_enableStoreUpdateManager;
@property(readonly, nonatomic) BITStoreUpdateManager *storeUpdateManager; // @synthesize storeUpdateManager=_storeUpdateManager;
@property(nonatomic, getter=isUpdateManagerDisabled) _Bool disableUpdateManager; // @synthesize disableUpdateManager=_disableUpdateManager;
@property(readonly, nonatomic) BITUpdateManager *updateManager; // @synthesize updateManager=_updateManager;
@property(nonatomic, getter=isCrashManagerDisabled) _Bool disableCrashManager; // @synthesize disableCrashManager=_disableCrashManager;
@property(readonly, nonatomic) BITCrashManager *crashManager; // @synthesize crashManager=_crashManager;
@property(retain, nonatomic) NSString *serverURL; // @synthesize serverURL=_serverURL;
@property(nonatomic) __weak id <BITHockeyManagerDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)initializeModules;
- (_Bool)shouldUseLiveIdentifier;
- (_Bool)isSetUpOnMainThread;
- (void)invokeStartUpdateManager;
- (void)validateStartManagerIsInvoked;
- (void)pingServerForIntegrationStartWorkflowWithTimeString:(id)arg1 appIdentifier:(id)arg2;
- (_Bool)integrationFlowStartedWithTimeString:(id)arg1;
- (id)integrationFlowTimeString;
- (id)hockeyAppClient;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (id)build;
- (id)version;
- (void)testIdentifier;
- (void)modifyKeychainUserValue:(id)arg1 forKey:(id)arg2;
- (void)startManager;
- (void)configureWithBetaIdentifier:(id)arg1 liveIdentifier:(id)arg2 delegate:(id)arg3;
- (void)configureWithIdentifier:(id)arg1 delegate:(id)arg2;
- (void)configureWithIdentifier:(id)arg1;
- (void)dealloc;
- (id)init;
- (void)logInvalidIdentifier:(id)arg1;
- (_Bool)checkValidityOfAppIdentifier:(id)arg1;

@end

