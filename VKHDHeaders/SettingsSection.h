//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, NSString, SectionIndex;

@interface SettingsSection : NSObject
{
    NSString *_title;
    NSString *_footer;
    SectionIndex *_index;
    NSArray *_rows;
}

@property(retain, nonatomic) NSArray *rows; // @synthesize rows=_rows;
@property(nonatomic) __weak SectionIndex *index; // @synthesize index=_index;
@property(copy, nonatomic) NSString *footer; // @synthesize footer=_footer;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void).cxx_destruct;
- (void)invalidate;
- (void)reloadSection;
- (id)objectAtIndexedSubscript:(unsigned long long)arg1;

@end

