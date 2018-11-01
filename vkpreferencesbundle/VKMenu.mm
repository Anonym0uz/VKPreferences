#import <Preferences/Preferences.h>
#import <Preferences/PSViewController.h>
#import <Preferences/PSDetailController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import "VKMenu.h"
#define PreferencesChangedNotification CFSTR("com.yourcomp.vktest.post")

NSMutableDictionary *menuSettings;
NSMutableDictionary *dictionary;

@implementation VKMenu

+(VKMenu *) sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&p, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

static void loadMenu()
{
    menuSettings = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsMenu];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:prefsMenu])
    {
        menuSettings = [NSMutableDictionary new];
        NSArray *enabled;
        NSArray *disabled;
        disabled = [NSArray arrayWithObjects:@"Помощь", nil];
        enabled = [NSArray arrayWithObjects:
                   @"Моя страница",
                   @"Новости",
                   @"Ответы",
                   @"Сообщения",
                   @"Друзья",
                   @"Группы",
                   @"Фотографии",
                   @"Видеозаписи",
                   @"Аудиозаписи",
                   @"Закладки",
                   @"Настройки",
                   @"Оффлайн",
                   @"Не читать",
                   @"Скрыть набор",
                   @"Сменить аккаунт",
                   @"Настройки VKP", nil];
        [menuSettings setObject:enabled forKey:@"enabled"];
        [menuSettings setObject:disabled forKey:@"disabled"];
        [menuSettings writeToFile:prefsMenu atomically:NO];
    }
    //NSLog(@"Settings already exists! Reloading settings...");
}

- (void)syncPrefs:(BOOL)notify {
    
    dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsMenu];
    if (_enabled) {
        //NSLog(@"Lolzl");
        dictionary[@"enabled"] = _enabled;
    }
    else {
        [dictionary removeObjectForKey:_enabled];
    }
    
    if (_disabled) {
        dictionary[@"disabled"] = _disabled;
    }
    else {
        [dictionary removeObjectForKey:_disabled];
    }
    
    [dictionary writeToFile:prefsMenu atomically:YES];
    
    if (notify) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.yourcomp.vktest.post"),  NULL, NULL, true);
    }
}

-(void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    loadMenu();
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsMenu];

    _enabled = dictionary[@"enabled"];
    _disabled = dictionary [@"disabled"];

    [dictionary writeToFile:prefsMenu atomically:YES];
    
    //NSLog(@"The item ENABLED array count: %lu", (unsigned long)[_enabled count]);
    //NSLog(@"The item DISABLED array count: %lu", (unsigned long)[_disabled count]);
    NSString *localizationTitle;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationTitle = @"Изменение меню";
    } else {
        localizationTitle = @"Menu settings";
    }
    [self.navigationItem setTitle:localizationTitle];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = 1;
    tableView.editing = YES;
    tableView.allowsSelectionDuringEditing = NO;
    self.view = tableView;
    tableView.longPressReorderEnabled = YES;
    [super viewDidLoad];
    [self syncPrefs:YES];

}

- (UITableView *)tableView
{
    return (UITableView *)self.view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
    case 0:
    return [self.enabled count];
    case 1:
    return [self.disabled count];
    default:
    return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(indexPath.section == 0)
    {
        if(cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.textLabel.text = [_enabled objectAtIndex:indexPath.row];
        
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Моя страница"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkMyImage = [vkhdBundle pathForResource:@"Accounts" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkMyImage];
            cell.detailTextLabel.text = @"My page";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Новости"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkNewsImage = [vkhdBundle pathForResource:@"ios7-menunews" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkNewsImage];
            cell.detailTextLabel.text = @"News";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Ответы"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkFeedImage = [vkhdBundle pathForResource:@"ios7-menufeedback" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkFeedImage];
            cell.detailTextLabel.text = @"Feedback";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Сообщения"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkMessImage = [vkhdBundle pathForResource:@"ios7-menumessages" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkMessImage];
            cell.detailTextLabel.text = @"Messages";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Друзья"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkFriendsImage = [vkhdBundle pathForResource:@"ios7-menufriends" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkFriendsImage];
            cell.detailTextLabel.text = @"Friends";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Группы"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkCommsImage = [vkhdBundle pathForResource:@"ios7-menucommunities" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkCommsImage];
            cell.detailTextLabel.text = @"Groups";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Фотографии"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkPhotoImage = [vkhdBundle pathForResource:@"ios7-menuphotos" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkPhotoImage];
            cell.detailTextLabel.text = @"Photos";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Видеозаписи"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkVideoImage = [vkhdBundle pathForResource:@"ios7-menuvideos" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkVideoImage];
            cell.detailTextLabel.text = @"Video";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Аудиозаписи"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkAudioImage = [vkhdBundle pathForResource:@"ios7-menumusic" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkAudioImage];
            cell.detailTextLabel.text = @"Audio";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Закладки"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkFavImage = [vkhdBundle pathForResource:@"ios7-menufavorites" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkFavImage];
            cell.detailTextLabel.text = @"Favorites";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Настройки"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkSettingsImage = [vkhdBundle pathForResource:@"ios7-menusettings" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkSettingsImage];
            cell.detailTextLabel.text = @"Settings";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Помощь"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkHelpImage = [vkhdBundle pathForResource:@"ios7-menuhelp" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkHelpImage];
            cell.detailTextLabel.text = @"Help";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Оффлайн"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpOfflineImage = [vkhdBundle pathForResource:@"Offline" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpOfflineImage];
            cell.detailTextLabel.text = @"Offline";
        }
        /*
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Мнимый онлайн"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpPhantomImage = [vkhdBundle pathForResource:@"Phantom" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpPhantomImage];
            cell.detailTextLabel.text = @"Phantom online";
        }
         */
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Не читать"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpDontreadImage = [vkhdBundle pathForResource:@"Dontread" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpDontreadImage];
            cell.detailTextLabel.text = @"Don't read messages";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Скрыть набор"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpDonttypeImage = [vkhdBundle pathForResource:@"Donttype" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpDonttypeImage];
            cell.detailTextLabel.text = @"Hide typing text";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Сменить аккаунт"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkMyImage = [vkhdBundle pathForResource:@"Accounts" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkMyImage];
            cell.detailTextLabel.text = @"Account change";
        }
        if([[_enabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpsettingsImage = [vkhdBundle pathForResource:@"VKPreferences" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpsettingsImage];
            cell.detailTextLabel.text = @"VKP settings";
        }
    }
    
    else
    {
        if(cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.textLabel.text = [_disabled objectAtIndex:indexPath.row];
        
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Моя страница"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkMyImage = [vkhdBundle pathForResource:@"Accounts" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkMyImage];
            cell.detailTextLabel.text = @"My page";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Новости"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkNewsImage = [vkhdBundle pathForResource:@"ios7-menunews" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkNewsImage];
            cell.detailTextLabel.text = @"News";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Ответы"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkFeedImage = [vkhdBundle pathForResource:@"ios7-menufeedback" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkFeedImage];
            cell.detailTextLabel.text = @"Feedback";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Сообщения"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkMessImage = [vkhdBundle pathForResource:@"ios7-menumessages" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkMessImage];
            cell.detailTextLabel.text = @"Messages";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Друзья"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkFriendsImage = [vkhdBundle pathForResource:@"ios7-menufriends" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkFriendsImage];
            cell.detailTextLabel.text = @"Friends";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Группы"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkCommsImage = [vkhdBundle pathForResource:@"ios7-menucommunities" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkCommsImage];
            cell.detailTextLabel.text = @"Groups";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Фотографии"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkPhotoImage = [vkhdBundle pathForResource:@"ios7-menuphotos" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkPhotoImage];
            cell.detailTextLabel.text = @"Photos";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Видеозаписи"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkVideoImage = [vkhdBundle pathForResource:@"ios7-menuvideos" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkVideoImage];
            cell.detailTextLabel.text = @"Video";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Аудиозаписи"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkAudioImage = [vkhdBundle pathForResource:@"ios7-menumusic" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkAudioImage];
            cell.detailTextLabel.text = @"Audio";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Закладки"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkFavImage = [vkhdBundle pathForResource:@"ios7-menufavorites" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkFavImage];
            cell.detailTextLabel.text = @"Favorites";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Настройки"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkSettingsImage = [vkhdBundle pathForResource:@"ios7-menusettings" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkSettingsImage];
            cell.detailTextLabel.text = @"Settings";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Помощь"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkHelpImage = [vkhdBundle pathForResource:@"ios7-menuhelp" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkHelpImage];
            cell.detailTextLabel.text = @"Help";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Оффлайн"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpOfflineImage = [vkhdBundle pathForResource:@"Offline" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpOfflineImage];
            cell.detailTextLabel.text = @"Offline";
        }
        /*
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Мнимый онлайн"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpPhantomImage = [vkhdBundle pathForResource:@"Phantom" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpPhantomImage];
            cell.detailTextLabel.text = @"Phantom online";
        }
         */
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Не читать"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpDontreadImage = [vkhdBundle pathForResource:@"Dontread" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpDontreadImage];
            cell.detailTextLabel.text = @"Don't read messages";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Скрыть набор"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpDonttypeImage = [vkhdBundle pathForResource:@"Donttype" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpDonttypeImage];
            cell.detailTextLabel.text = @"Hide typing text";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Сменить аккаунт"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpaccountsImage = [vkhdBundle pathForResource:@"Accounts" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpaccountsImage];
            cell.detailTextLabel.text = @"Account change";
        }
        if([[_disabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"])
        {
            NSBundle* vkhdBundle = [NSBundle mainBundle];
            NSString* vkpsettingsImage = [vkhdBundle pathForResource:@"VKPreferences" ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:vkpsettingsImage];
            cell.detailTextLabel.text = @"VKP settings";
        }
    }
    
    cell.showsReorderControl = YES;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0 && indexPath.row == 0) || ([[_enabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"]))
    {
        return NO;
    }
return YES;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *localizationEnabledSection;
    NSString *localizationDisabledSection;
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"ru"]) {
        localizationEnabledSection = @"Включено";
        localizationDisabledSection = @"Выключено";
    } else {
        localizationEnabledSection = @"Enabled";
        localizationDisabledSection = @"Disabled";
    }
    switch (section) {
        case 0: return localizationEnabledSection;
        case 1: return localizationDisabledSection;
        default: return 0;
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (proposedDestinationIndexPath.row == 0 && proposedDestinationIndexPath.section == 0) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    BOOL clearRow = ((destinationIndexPath.section == 0 && !_enabled.count) || (destinationIndexPath.section == 1 && !_disabled.count));
    
    if (sourceIndexPath.section == 0) {
        NSString *sourceID = _enabled[sourceIndexPath.row];
        
        [_enabled removeObjectAtIndex:sourceIndexPath.row];
        
        if (destinationIndexPath.section == 0) {
            [_enabled insertObject:sourceID atIndex:destinationIndexPath.row];
        }
        else {
            [_disabled insertObject:sourceID atIndex:(clearRow ? 0 : destinationIndexPath.row)];
        }
    }
    else if (sourceIndexPath.section == 1) {
        NSString *sourceID = _disabled[sourceIndexPath.row];
        
        [_disabled removeObjectAtIndex:sourceIndexPath.row];
        
        if (destinationIndexPath.section == 1) {
            [_disabled insertObject:sourceID atIndex:destinationIndexPath.row];
        }
        else {
            [_enabled insertObject:sourceID atIndex:(clearRow ? 0 : destinationIndexPath.row)];
        }
    }
    
    [self syncPrefs:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0 && indexPath.row == 0) || ([[_enabled objectAtIndex:indexPath.row]isEqual:@"Настройки VKP"]))
    {
        return NO;
    }
    return YES;
    
}

@end
// vim:ft=objc
