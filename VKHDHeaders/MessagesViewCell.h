//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "DefaultMessagesCell.h"

@class BackupImageView, GraySeparatorView, UIImageView, UILabel, UIView, VKMessage;

@interface MessagesViewCell : DefaultMessagesCell
{
    unsigned long long stateMask;
    _Bool isOut;
    _Bool isChat;
    _Bool _unreaded;
    BackupImageView *avatar1Image;
    UILabel *messageLabel;
    UILabel *timeLabel;
    UILabel *nameLabel;
    UIImageView *onlineImage;
    UIImageView *groupImage;
    UIView *background;
    GraySeparatorView *sepView;
    UIView *myMessageBackground;
    BackupImageView *avatarMyImage;
    VKMessage *_message;
}

@property(nonatomic) __weak VKMessage *message; // @synthesize message=_message;
@property(nonatomic) _Bool unreaded; // @synthesize unreaded=_unreaded;
@property(nonatomic) _Bool isChat; // @synthesize isChat;
@property(nonatomic) _Bool isOut; // @synthesize isOut;
@property(retain, nonatomic) BackupImageView *avatarMyImage; // @synthesize avatarMyImage;
@property(retain, nonatomic) UIView *myMessageBackground; // @synthesize myMessageBackground;
@property(retain, nonatomic) GraySeparatorView *sepView; // @synthesize sepView;
@property(retain, nonatomic) UIView *background; // @synthesize background;
@property(retain, nonatomic) UIImageView *groupImage; // @synthesize groupImage;
@property(retain, nonatomic) UIImageView *onlineImage; // @synthesize onlineImage;
@property(retain, nonatomic) UILabel *nameLabel; // @synthesize nameLabel;
@property(retain, nonatomic) UILabel *timeLabel; // @synthesize timeLabel;
@property(retain, nonatomic) UILabel *messageLabel; // @synthesize messageLabel;
@property(retain, nonatomic) BackupImageView *avatar1Image; // @synthesize avatar1Image;
- (void).cxx_destruct;
- (void)didTransitionToState:(unsigned long long)arg1;
- (void)willTransitionToState:(unsigned long long)arg1;
- (void)setHighlighted:(_Bool)arg1 animated:(_Bool)arg2;
- (void)setOnline:(_Bool)arg1;
- (void)setTime:(double)arg1;
- (void)setName:(id)arg1;
- (void)setIsOut:(_Bool)arg1 isChat:(_Bool)arg2;
- (void)updateUserOnlineStatus:(id)arg1;
- (void)setCellStyle:(int)arg1;
- (void)setMessageStyle:(int)arg1;
- (void)layoutSubviews;
- (void)dealloc;
- (void)awakeFromNib;
- (id)reuseIdentifier;

@end

