@interface VKAPIController : NSObject
@property(retain, nonatomic) NSNumber *user_id;
-(void)sendRequest:(id)arg1;
-(void)sendRequest:(id)arg1 viaHTTPS:(BOOL)arg2;
-(void)cleanUp;
-(void)unregisterPush;
-(void)registerPush;
-(BOOL)wakeUpSession;
-(void)saveSession:(id)arg1 clean:(BOOL)arg2;
-(void)logout;
@end

@interface APIStorage : NSObject
+(id)sharedStorage;
-(id)getUser:(id)arg1 callback:(id)arg2;
-(id)getUser:(id)arg1;
@end

@interface MenuAction : NSObject
@property(retain, nonatomic) NSArray *submenuActions;
@end

@interface AbstractTableDataSource : NSObject
-(void)reloadTable;
-(void)reloadAll;
@end

@interface SettingsViewController : NSObject
-(void)showSelfInWindow;
@end

@interface iPadNewsViewController : NSObject
-(void)updateNews;
-(void)updateNews:(BOOL)arg1;
-(void)updateButtonFired;
-(void)loadView;
-(void)updateButtonFired:(BOOL)arg1;
-(void)viewWillAppear:(BOOL)arg1;
-(void)viewDidDisappear:(BOOL)arg1;
@end

@interface AudioPlayerController : NSObject
+ (id)sharedInstance;
- (void)addAudioToCache:(id)arg1;
@end

//@interface SidebarMenuController : NSObject
//@property(retain, nonatomic) UITableView *tableView;
//@property(retain, nonatomic) NSArray *sections;
//-(void)loadView;
//-(void)updateSelectedRow:(long long)arg1;
//@end

@interface video_search_req : NSObject
-(void)setAdult:(id)arg1;
@end

@interface VKGroup : NSObject
-(void)setIs_adult:(id)arg1;
@end

@interface groups_search_req : NSObject
-(void)setSort:(int)arg1;
@end

@interface MessagesController : NSObject
@property(readonly, nonatomic) BOOL currentLoadingDialogsInProgress;
-(void)viewDidLoad;
-(id)messages;
-(id)friends;
-(id)notifications;
-(id)groups;
-(id)counters;
-(void)updateUnreadMessages;
+(id)sharedInstance;
-(void)getLongPollServer;
-(void)connectToLongPollServer;
-(void)disconnectLongPoll;
-(void)loadLongPollHistory:(BOOL)arg1;
-(void)reloadAllDialogs;
@end

@interface iPadChatViewController : UIViewController //NSObject
- (void)navigationController:(id)arg1 willShowViewController:(id)arg2 animated:(_Bool)arg3;
-(void)checkUnreadMessages;
@end

@interface auth_login_req : NSObject
-(void)setPassword:(id)arg1;
-(void)setUsername:(id)arg1;
-(void)setClient_id:(id)arg1;
-(void)setClient_secret:(id)arg1;
-(void)setScope:(id)arg1;
-(id)getMethodName;
@end

@interface AppDelegate : NSObject
+(id)sharedInstance;
-(void)switchToViewController:(id)arg1;
-(void)showModalViewController:(id)arg1;
-(void)processPush:(id)arg1;
-(void)authorizeAppNow;
@end

@interface BufferedNavigationController : UINavigationController
-(void)pushViewController:(id)arg1 animated:(BOOL)arg2;
@end

@interface iPadMainViewController : NSObject
-(void)unreadMessagesDidChanged:(id)arg1;
-(void)doLogout;
-(void)reloadData;
-(void)makeClean;
-(void)openFeedback;
-(void)openGroups;
-(void)openMessages;
-(void)openAudioView;
-(void)openFriends;
-(void)closeMenuTap:(id)arg1;
-(void)popRightSlide;
-(void)pushRightSlide;
-(void)openMenuButtonPressed:(id)arg1;
-(id)getOrCreateMessagesView;

-(void)didPopViewController:(id)arg1 toRoot:(BOOL)arg2;
-(void)checkIfRightSlideRequired;
-(void)processSelectedRow:(long long)arg1 inCurrentVc:(BOOL)arg2;

-(void)processSelectedRow:(long long)arg1;
+(void)presentModalViewControllerWithoutNav:(id)arg1 animated:(BOOL)arg2;
-(void)willShowViewController:(id)arg1 byPush:(BOOL)arg2;
+(id)showController:(id)arg1 inPopoverWithSize:(struct CGSize)arg2 inView:(id)arg3;
//work
-(void)pushBaseViewController:(id)arg1;
-(void)pushToCurrentViewController:(id)arg1;
-(BOOL)slideMenuClosed;
+(void)prepareController:(id)arg1;
-(void)willPushViewController:(id)arg1;
-(void)didShowViewController:(id)arg1;
+(void)presentModalViewControllerInNav:(id)arg1 animated:(BOOL)arg2;
-(void)presentViewController:(id)arg1 animated:(BOOL)arg2 completion:(id)arg3;
-(void)popoverControllerDidDismissPopover:(id)arg1;
-(void)openAudio;
-(BOOL)prepareMessagesForOpen;
@end

@interface iPadGroupsViewController : NSObject
- (void)updateDataSources;
@end

@interface LoadingViewController : NSObject
+(id)sharedLoadingView;
-(void)showSelfInWindow;
@end

@interface iPadLoginViewController : UIViewController //<NSObject>
-(void)LoginButtonPressed:(id)arg1;
-(void)buttonPressed;
-(void)processAuthorizationResponse:(id)arg1;
@end

@interface VKRequest : NSObject
@property(nonatomic) Class responseClass; // @synthesize responseClass=_responseClass;
@property(copy, nonatomic, getter=getMethodName) NSString *methodName; // @synthesize methodName=_methodName;
@property(nonatomic) float repeatCount; // @synthesize repeatCount=_repeatCount;
-(id)didFinishBlock;
-(id)didFailedBlock;
-(void)setDidFinishBlock:(id)arg1;
-(void)setDidFailedBlock:(id)arg1;
@end

@interface wall_post_req : NSObject
@property(retain, nonatomic) NSNumber *place_id; // @synthesize place_id=_place_id;
@property(retain, nonatomic) NSNumber *publish_date; // @synthesize publish_date=_publish_date;
@property(retain, nonatomic) NSNumber *Mlong; // @synthesize Mlong=_Mlong;
@property(retain, nonatomic) NSNumber *lat; // @synthesize lat=_lat;
@property(retain, nonatomic) NSNumber *friends_only; // @synthesize friends_only=_friends_only;
@property(retain, nonatomic) NSNumber *Msigned; // @synthesize Msigned=_Msigned;
@property(retain, nonatomic) NSNumber *from_group; // @synthesize from_group=_from_group;
@property(copy, nonatomic) NSString *attachments; // @synthesize attachments=_attachments;
@property(copy, nonatomic) NSString *message; // @synthesize message=_message;
@property(copy, nonatomic) NSString *services; // @synthesize services=_services;
@property(retain, nonatomic) NSNumber *owner_id; // @synthesize owner_id=_owner_id;
- (id)getMethodName;
- (void)setPublish_date:(NSNumber *)arg1;

//-(void)setOwner_id:(id)arg1;
@end

@interface account_setOnline_req : NSObject
-(id)getMethodName;
@end

@interface wall_post_res : NSObject
@property(retain, nonatomic) NSNumber *post_id;
//-(void)setPost_id:(id)arg1;
@end

@interface AVPlayerCacheLayer : NSObject
-(void)setNeedCacheCurrentAudio;
@end

@interface VKEventsTracker : NSObject
+(void)flushEvents;
@end

@interface VKUser : NSObject
{
    NSNumber *_id;
    NSString *_first_name;
    NSString *_last_name;
    NSString *_name;
}
@property(copy, nonatomic) NSString *last_name;
@property(copy, nonatomic) NSString *first_name;
@property(retain, nonatomic) NSNumber *id;
@property(copy, nonatomic) NSString *name;
@end

@interface iPadNewWallPostViewController : NSObject
- (void)sendMessage;
@end

@interface VKPost : NSObject

+ (long long)defaultNameRectOffset;
+ (long long)defaultCommentsHeight;
+ (long long)defaultCommentsOffsetY;
+ (long long)defaultBackgroundOffsetY;
+ (long long)defaultNameRectHeight;
+ (long long)defaultEmptyPostHeight;
@property(copy, nonatomic) NSString *ads_debug; // @synthesize ads_debug=_ads_debug;
@property _Bool postViewed; // @synthesize postViewed=_postViewed;
@property(retain, nonatomic) NSArray *hideSourceList; // @synthesize hideSourceList=_hideSourceList;
@property(nonatomic) _Bool dontDrawCopyContent; // @synthesize dontDrawCopyContent=_dontDrawCopyContent;
@property(nonatomic) _Bool gotExtraPost; // @synthesize gotExtraPost=_gotExtraPost;
@property(nonatomic) _Bool isHidden; // @synthesize isHidden=_isHidden;
@property(nonatomic) _Bool isReported; // @synthesize isReported=_isReported;
@property(nonatomic) _Bool isDeleted; // @synthesize isDeleted=_isDeleted;
@property(nonatomic) _Bool isParentHasText; // @synthesize isParentHasText=_isParentHasText;
@property(nonatomic) _Bool isCopy; // @synthesize isCopy=_isCopy;
@property(nonatomic) _Bool canShowComments; // @synthesize canShowComments=_canShowComments;
@property(nonatomic) _Bool expanded; // @synthesize expanded=_expanded;
@property(nonatomic) float attachHeight6; // @synthesize attachHeight6=_attachHeight6;
@property(nonatomic) float attachHeight5; // @synthesize attachHeight5=_attachHeight5;
@property(nonatomic) float attachHeight4; // @synthesize attachHeight4=_attachHeight4;
@property(nonatomic) float attachHeight3; // @synthesize attachHeight3=_attachHeight3;
@property(nonatomic) float attachHeight2; // @synthesize attachHeight2=_attachHeight2;
@property(nonatomic) float attachHeight; // @synthesize attachHeight=_attachHeight;
@property(nonatomic) float heightWallRepostTruncated; // @synthesize heightWallRepostTruncated=_heightWallRepostTruncated;
@property(nonatomic) float heightWallRepost; // @synthesize heightWallRepost=_heightWallRepost;
@property(nonatomic) float heightWallTruncated; // @synthesize heightWallTruncated=_heightWallTruncated;
@property(nonatomic) float heightWall; // @synthesize heightWall=_heightWall;
@property(nonatomic) float heightRepostTruncated; // @synthesize heightRepostTruncated=_heightRepostTruncated;
@property(nonatomic) float heightRepost; // @synthesize heightRepost=_heightRepost;
@property(nonatomic) float heightPostTruncated; // @synthesize heightPostTruncated=_heightPostTruncated;
@property(nonatomic) float heightPost; // @synthesize heightPost=_heightPost;
@property(copy, nonatomic) NSString *tagText; // @synthesize tagText=_tagText;
@property(retain, nonatomic) NSNumber *can_delete; // @synthesize can_delete=_can_delete;
@property(retain, nonatomic) NSNumber *can_edit; // @synthesize can_edit=_can_edit;
@property(retain, nonatomic) NSNumber *can_pin; // @synthesize can_pin=_can_pin;
@property(retain, nonatomic) NSNumber *is_pinned; // @synthesize is_pinned=_is_pinned;
@property(retain, nonatomic) NSNumber *final_post; // @synthesize final_post=_final_post;
@property(retain, nonatomic) NSNumber *signer_id; // @synthesize signer_id=_signer_id;
@property(copy, nonatomic) NSString *post_type; // @synthesize post_type=_post_type;
@property(retain, nonatomic) NSNumber *friends_only; // @synthesize friends_only=_friends_only;
@property(retain, nonatomic) NSNumber *reply_post_id; // @synthesize reply_post_id=_reply_post_id;
@property(retain, nonatomic) NSNumber *reply_owner_id; // @synthesize reply_owner_id=_reply_owner_id;
@property(copy, nonatomic) NSString *text; // @synthesize text=_text;
@property(retain, nonatomic) NSNumber *insert_date; // @synthesize insert_date=_insert_date;
@property(retain, nonatomic) NSNumber *date; // @synthesize date=_date;
@property(retain, nonatomic) NSNumber *from_id; // @synthesize from_id=_from_id;
@property(retain, nonatomic) NSNumber *owner_id; // @synthesize owner_id=_owner_id;
@property(retain, nonatomic) NSNumber *id; // @synthesize id=_id;
- (void)processAdvertismentTap;
- (_Bool)isEqual:(id)arg1;
- (void)addAttachment:(id)arg1;
- (id)objectString;
@property(readonly, nonatomic) NSNumber *wall_owner;
@property(readonly, nonatomic) NSNumber *post_owner;
- (id)attachmentStringLight;
- (id)attachmentString;
- (_Bool)mayBeNewsfeedTruncated;
- (_Bool)mayBeWallTruncated;
- (double)viewHeightFullRepost;
- (double)viewHeightFullPost;
- (double)viewHeightRepost:(_Bool)arg1;
- (double)newsfeedHeightWithComments;
- (double)viewHeight:(_Bool)arg1;
- (double)deletedPostHeight;
- (id)initWithDictionary:(id)arg1;
- (void)addExtraOffset:(double)arg1;
- (void)calculateSize;

@end

@interface execute_req : NSObject
{
    NSString *_code;
    NSNumber *_noerrors;
    NSString *_override;
    NSString *_localScript;
    NSNumber *_script_version;
    NSDictionary *_args;
}

@property(retain, nonatomic) NSDictionary *args; // @synthesize args=_args;
@property(retain, nonatomic) NSNumber *script_version; // @synthesize script_version=_script_version;
@property(copy, nonatomic) NSString *localScript; // @synthesize localScript=_localScript;
@property(copy, nonatomic) NSString *override; // @synthesize override=_override;
@property(retain, nonatomic) NSNumber *noerrors; // @synthesize noerrors=_noerrors;
@property(copy, nonatomic) NSString *code; // @synthesize code=_code;
- (Class)responseClass;
- (id)getMethodName;
- (id)ignoredProperties;
- (id)serialize;
- (id)init;

@end

@interface execute_res : NSObject
{
    id _JSON;
    NSMutableDictionary *_customParams;
}

@property(retain, nonatomic) NSMutableDictionary *customParams; // @synthesize customParams=_customParams;
@property(retain, nonatomic) id JSON; // @synthesize JSON=_JSON;
- (id)ignoredProperties;
- (id)initWithDictionary:(id)arg1;

@end

@interface messages_send_req : NSObject
{
    NSNumber *_user_id;
    NSString *_domain;
    NSNumber *_chat_id;
    NSNumber *_user_ids;
    NSString *_message;
    NSString *_title;
    NSNumber *_guid;
    NSNumber *_lat;
    NSNumber *_Mlong;
    NSString *_attachment;
    NSString *_forward_messages;
}

@property(copy, nonatomic) NSString *forward_messages; // @synthesize forward_messages=_forward_messages;
@property(copy, nonatomic) NSString *attachment; // @synthesize attachment=_attachment;
@property(retain, nonatomic) NSNumber *Mlong; // @synthesize Mlong=_Mlong;
@property(retain, nonatomic) NSNumber *lat; // @synthesize lat=_lat;
@property(retain, nonatomic) NSNumber *guid; // @synthesize guid=_guid;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@property(copy, nonatomic) NSString *message; // @synthesize message=_message;
@property(retain, nonatomic) NSNumber *user_ids; // @synthesize user_ids=_user_ids;
@property(retain, nonatomic) NSNumber *chat_id; // @synthesize chat_id=_chat_id;
@property(copy, nonatomic) NSString *domain; // @synthesize domain=_domain;
@property(retain, nonatomic) NSNumber *user_id; // @synthesize user_id=_user_id;
- (id)init;

@end

@interface messages_send_res : NSObject
{
    NSNumber *_response;
}

@property(retain, nonatomic) NSNumber *response; // @synthesize response=_response;

@end
