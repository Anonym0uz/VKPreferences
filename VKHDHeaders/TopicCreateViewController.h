//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIViewControllerStyled.h"

#import "UITableViewDataSource.h"
#import "UITableViewDelegate.h"
#import "UITextFieldDelegate.h"
#import "UITextViewDelegate.h"

@class NSString, UIBarButtonItem, UILabel, UISwitch, UITableView, UITableViewCell, UITextField, UITextView, VKGroup;

@interface TopicCreateViewController : UIViewControllerStyled <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    _Bool ignoreKeyboard;
    struct CGSize keyboardSize;
    float exSpace;
    _Bool isFieldEditing;
    UITableView *table;
    UITableViewCell *nameCell;
    UITextField *nameField;
    UITableViewCell *descriptionCell;
    UITextView *descriptionField;
    UILabel *descriptionFieldPlaceholder;
    id <TopicCreateViewControllerDelegate> delegate;
    VKGroup *_parentGroup;
    UIBarButtonItem *_doneButton;
    UISwitch *_fromGroupSwitch;
}

@property(retain, nonatomic) UISwitch *fromGroupSwitch; // @synthesize fromGroupSwitch=_fromGroupSwitch;
@property(retain, nonatomic) UIBarButtonItem *doneButton; // @synthesize doneButton=_doneButton;
@property(retain, nonatomic) VKGroup *parentGroup; // @synthesize parentGroup=_parentGroup;
@property(nonatomic) id <TopicCreateViewControllerDelegate> delegate; // @synthesize delegate;
@property(retain, nonatomic) UILabel *descriptionFieldPlaceholder; // @synthesize descriptionFieldPlaceholder;
@property(retain, nonatomic) UITextView *descriptionField; // @synthesize descriptionField;
@property(retain, nonatomic) UITableViewCell *descriptionCell; // @synthesize descriptionCell;
@property(retain, nonatomic) UITextField *nameField; // @synthesize nameField;
@property(retain, nonatomic) UITableViewCell *nameCell; // @synthesize nameCell;
@property(retain, nonatomic) UITableView *table; // @synthesize table;
- (void).cxx_destruct;
- (_Bool)textField:(id)arg1 shouldChangeCharactersInRange:(struct _NSRange)arg2 replacementString:(id)arg3;
- (void)textViewDidChange:(id)arg1;
- (void)keyboardDidHidden:(id)arg1;
- (void)keyboardWillBeHidden:(id)arg1;
- (void)keyboardDidShow:(id)arg1;
- (void)keyboardWillShow:(id)arg1;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (void)backButtonPressed:(id)arg1;
- (void)doneButtonClick:(id)arg1;
- (void)groupTopicDidAdded:(id)arg1;
- (void)viewDidLayoutSubviews;
- (void)viewWillAppear:(_Bool)arg1;
- (void)makeRotationToInterfaceOrientation:(long long)arg1 duration:(double)arg2;
- (void)willRotateToInterfaceOrientation:(long long)arg1 duration:(double)arg2;
- (void)didRotateFromInterfaceOrientation:(long long)arg1;
- (void)updateInterfaceForOrientation:(long long)arg1;
- (void)dealloc;
- (unsigned long long)supportedInterfaceOrientations;
- (_Bool)shouldAutorotateToInterfaceOrientation:(long long)arg1;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

