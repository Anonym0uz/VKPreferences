//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@interface FBSessionUtility : NSObject
{
}

+ (id)audienceNameWithAudience:(unsigned long long)arg1;
+ (id)userIDFromSignedRequest:(id)arg1;
+ (unsigned long long)loginBehaviorForLoginType:(unsigned long long)arg1;
+ (_Bool)logIfFoundUnexpectedPermissions:(id)arg1 isRead:(_Bool)arg2;
+ (void)extractPermissionsFromResponse:(id)arg1 allPermissions:(id)arg2 grantedPermissions:(id)arg3 declinedPermissions:(id)arg4;
+ (void)validateRequestForPermissions:(id)arg1 defaultAudience:(unsigned long long)arg2 allowSystemAccount:(_Bool)arg3 isRead:(_Bool)arg4;
+ (_Bool)areRequiredPermissions:(id)arg1 aSubsetOfPermissions:(id)arg2;
+ (id)expirationDateFromResponseParams:(id)arg1;
+ (void)addWebLoginStartTimeToParams:(id)arg1;
+ (id)sessionStateDescription:(unsigned long long)arg1;
+ (id)clientStateFromQueryParams:(id)arg1;
+ (id)queryParamsFromLoginURL:(id)arg1 appID:(id)arg2 urlSchemeSuffix:(id)arg3;
+ (_Bool)isOpenSessionResponseURL:(id)arg1;

@end

