//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "SmilesDataSource.h"

@class NSArray, UICollectionViewLayout;

@interface EmojiDataSource : SmilesDataSource
{
    UICollectionViewLayout *__layout;
    NSArray *_smileysArray;
}

+ (id)instance;
+ (void)prepare;
@property(retain, nonatomic) NSArray *smileysArray; // @synthesize smileysArray=_smileysArray;
@property(retain, nonatomic) UICollectionViewLayout *layout; // @synthesize layout=__layout;
- (void).cxx_destruct;
- (id)background;
- (id)objectAtIndex:(long long)arg1;
- (void)selectCategory:(int)arg1;
- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2;
- (long long)collectionView:(id)arg1 numberOfItemsInSection:(long long)arg2;
- (void)setController:(id)arg1;
- (void)regenerate;
- (id)init;

@end
