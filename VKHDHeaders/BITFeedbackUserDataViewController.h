//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UITableViewController.h"

#import "UITextFieldDelegate.h"

@class BITFeedbackManager, NSString;

@interface BITFeedbackUserDataViewController : UITableViewController <UITextFieldDelegate>
{
    long long _statusBarStyle;
    id <BITFeedbackUserDataDelegate> _delegate;
    BITFeedbackManager *_manager;
    NSString *_name;
    NSString *_email;
}

@property(copy, nonatomic) NSString *email; // @synthesize email=_email;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(nonatomic) __weak BITFeedbackManager *manager; // @synthesize manager=_manager;
@property(nonatomic) __weak id <BITFeedbackUserDataDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (_Bool)textFieldShouldReturn:(id)arg1;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 titleForFooterInSection:(long long)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)saveAction:(id)arg1;
- (void)dismissAction:(id)arg1;
- (void)userEmailEntered:(id)arg1;
- (void)userNameEntered:(id)arg1;
- (_Bool)allRequiredFieldsEntered;
- (_Bool)shouldAutorotateToInterfaceOrientation:(long long)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)initWithStyle:(long long)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

