//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "iPadStandardCell.h"

@class NSIndexPath;

@interface UITableViewCellHighlight : iPadStandardCell
{
    _Bool eventFired;
    CDUnknownBlockType _didPress;
    CDUnknownBlockType _didLongPress;
    CDUnknownBlockType _didHighlight;
    NSIndexPath *_indexPath;
}

@property(retain, nonatomic) NSIndexPath *indexPath; // @synthesize indexPath=_indexPath;
@property(copy, nonatomic) CDUnknownBlockType didHighlight; // @synthesize didHighlight=_didHighlight;
@property(copy, nonatomic) CDUnknownBlockType didLongPress; // @synthesize didLongPress=_didLongPress;
@property(copy, nonatomic) CDUnknownBlockType didPress; // @synthesize didPress=_didPress;
- (void).cxx_destruct;
- (struct UIEdgeInsets)separatorInset;
- (struct UIEdgeInsets)layoutMargins;
- (void)setHighlighted:(_Bool)arg1 animated:(_Bool)arg2;
- (void)fireLongPress;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;

@end
