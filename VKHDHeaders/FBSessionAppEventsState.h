//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray;

@interface FBSessionAppEventsState : NSObject
{
    _Bool _requestInFlight;
    NSMutableArray *_accumulatedEvents;
    NSMutableArray *_inFlightEvents;
    unsigned long long _numSkippedEventsDueToFullBuffer;
}

@property _Bool requestInFlight; // @synthesize requestInFlight=_requestInFlight;
@property unsigned long long numSkippedEventsDueToFullBuffer; // @synthesize numSkippedEventsDueToFullBuffer=_numSkippedEventsDueToFullBuffer;
@property(retain) NSMutableArray *inFlightEvents; // @synthesize inFlightEvents=_inFlightEvents;
@property(retain) NSMutableArray *accumulatedEvents; // @synthesize accumulatedEvents=_accumulatedEvents;
- (id)jsonEncodeInFlightEvents:(_Bool)arg1;
- (_Bool)areAllEventsImplicit;
- (void)clearInFlightAndStats;
- (unsigned long long)getAccumulatedEventCount;
- (void)addEvent:(id)arg1 isImplicit:(_Bool)arg2;
- (void)dealloc;
- (id)init;

@end

