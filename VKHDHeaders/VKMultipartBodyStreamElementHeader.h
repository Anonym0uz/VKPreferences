//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "VKMultipartBodyStreamElement.h"

@class NSData;

@interface VKMultipartBodyStreamElementHeader : VKMultipartBodyStreamElement
{
    NSData *_headerData;
}

+ (id)dataForHeadersDict:(id)arg1 stringEncoding:(unsigned long long)arg2;
+ (id)stringForHeadersDict:(id)arg1;
+ (id)headerFromData:(id)arg1;
@property(retain) NSData *headerData; // @synthesize headerData=_headerData;
- (void).cxx_destruct;
- (unsigned long long)contentLength;
- (long long)read:(char *)arg1 maxLength:(unsigned long long)arg2;

@end

