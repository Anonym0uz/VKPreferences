//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MRAbstractDataProvider.h"

@class MRCustomParamsProvider, MRDeviceDataProvider, MRLocationDataProvider, MRNetworkDataProvider;

@interface MRFingerprintDataProvider : MRAbstractDataProvider
{
    MRDeviceDataProvider *_deviceDataProvider;
    MRNetworkDataProvider *_networkDataProvider;
    MRLocationDataProvider *_locationDataProvider;
    MRCustomParamsProvider *_customParamsProvider;
}

+ (id)instance;
- (void).cxx_destruct;
- (void)setCustomParamsProvider:(id)arg1;
- (void)collectData;
- (id)data;
- (id)init;

@end
