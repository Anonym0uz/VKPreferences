//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIButton.h"

@interface UIButtonHL : UIButton
{
    _Bool _disableHighlight;
    _Bool _alphaHighlight;
    _Bool _removeShadows;
    double _alphaHighlightLevel;
}

+ (id)buttonWithType:(long long)arg1 defaultAlphaHighlight:(_Bool)arg2;
@property(nonatomic) double alphaHighlightLevel; // @synthesize alphaHighlightLevel=_alphaHighlightLevel;
@property(nonatomic) _Bool removeShadows; // @synthesize removeShadows=_removeShadows;
@property(nonatomic) _Bool alphaHighlight; // @synthesize alphaHighlight=_alphaHighlight;
@property(nonatomic) _Bool disableHighlight; // @synthesize disableHighlight=_disableHighlight;
- (struct CGSize)intrinsicContentSize;
- (void)enableAlphaHighlight:(_Bool)arg1;
- (void)setSelected:(_Bool)arg1;
- (void)setHighlighted:(_Bool)arg1 animated:(_Bool)arg2;
- (void)setHighlighted:(_Bool)arg1;
- (void)setHighlightedTable:(_Bool)arg1;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;

@end

