//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UICollectionView.h"

@interface ClearRectCollectionView : UICollectionView
{
    long long _selectedItemRow;
    struct CGRect _holeRect;
}

@property(nonatomic) struct CGRect holeRect; // @synthesize holeRect=_holeRect;
@property(nonatomic) long long selectedItemRow; // @synthesize selectedItemRow=_selectedItemRow;
- (void)drawRect:(struct CGRect)arg1;
- (id)initWithFrame:(struct CGRect)arg1;

@end

