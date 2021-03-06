//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@interface FBErrorUtility : NSObject
{
}

+ (_Bool)isTransientError:(id)arg1;
+ (id)apiUserMessageForError:(id)arg1;
+ (id)userTitleForError:(id)arg1;
+ (id)innerErrorInfoFromError:(id)arg1;
+ (_Bool)errorIsNetworkError:(id)arg1;
+ (id)jsonDictionaryForError:(id)arg1;
+ (id)fberrorForSystemPasswordChange:(id)arg1;
+ (id)fberrorForRetry:(id)arg1;
+ (void)fberrorGetCodeValueForError:(id)arg1 index:(unsigned long long)arg2 code:(int *)arg3 subcode:(int *)arg4;
+ (_Bool)fberrorIsErrorFromSystemSession:(id)arg1;
+ (long long)fberrorCategoryFromError:(id)arg1 code:(int)arg2 subcode:(int)arg3 returningUserMessage:(id *)arg4 andShouldNotifyUser:(_Bool *)arg5;
+ (id)userMessageForError:(id)arg1;
+ (_Bool)shouldNotifyUserForError:(id)arg1;
+ (long long)errorCategoryForError:(id)arg1;

@end

