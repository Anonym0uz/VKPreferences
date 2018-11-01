#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import "substrate.h"

NSMutableDictionary *settings;
NSMutableDictionary *menu;
NSInteger *responces;

int cellIndex;
UISwitch *switchView;
UISwitch *switchView2;
UISwitch *switchView3;
UISwitch *switchView4;
UISwitch *switchView5;
UITableView *tableView;
BOOL RusLang;

//NSMutableDictionary *menu = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenu.plist"];
//NSMutableArray *menuEnabled = menu[@"enabled"];

//BOOL pirated;//До лучших времен.

//Создание файла настроек .plist, если его нету.
static void loadSettings()
{   
	settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    //if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"])
    //{
    //	NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //	[settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    //}
}

//static void loadMenu()
//{
//    menu = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenu.plist"];
//}

/*
%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application 
{
	%orig;
	//Не доверенный источник(До лучших времен)
	
    if(![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/org.thebigboss.vkpreferences.list"] && ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/ru.anonz.vkpreferences.list"])
    {
    	UIAlertView *pirate = [[UIAlertView alloc] initWithTitle:@"VK Preferences" 
        message:(RusLang) ? @"Вы установили твик из недоверенного источника. Пожалуйста, установите твик из 'apt.thebigboss.org/repofiles/cydia' or 'onescript.ru/repo'. Спасибо!" : @"You installed tweak from untrusted source. Please install the tweak from 'apt.thebigboss.org/repofiles/cydia' or 'onescript.ru/repo'. Thank you!"
       	delegate:nil 
        cancelButtonTitle:(RusLang) ? @"Хорошо" : @"Okay"
        otherButtonTitles:nil];
    [pirate show];
    [pirate release];
    }
    
    //else if(![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"])
    if(![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"])
    	{
    		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"VK Preferences" 
       			message:(RusLang) ? @"Перейдите в Настройки, для включения функций." : @"Visit VK Preferences settings page, to enable functions."
        		delegate:nil 
        		cancelButtonTitle:(RusLang) ? @"Спасибо :)" : @"Thanks :)"
        		otherButtonTitles:nil];
    			[alert show];
    			[alert release];
    			NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    			[settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    	}
}
%end
        		if(otherButtonTitles)
        		{
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
        		}

*/

%hook AppDelegate
- (void)applicationDidBecomeActive:(id)arg1
{
	%orig;
    if(![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"])
    	{
    		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"VK Preferences" 
       			//message:(RusLang) ? @"Перейдите в Настройки, для включения остальных функций." : @"Visit VK Preferences settings page, to enable others functions."
                message:(RusLang) ? @"Перейдите в Настройки, для включения остальных функций." : @"Перейдите в Настройки, для включения остальных функций."
        		delegate:self 
        		cancelButtonTitle:(RusLang) ? @"Окей" : @"Okay"
        		otherButtonTitles:nil];
    			[alert show];
    			[alert release];
    			NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    			[settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    	}
}
/*
%new
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 1)
  {
    NSURL *url = [NSURL URLWithString:@"prefs:root=VKPREFERENCES_ID"];
    [[UIApplication sharedApplication] openURL:url];
  }
}
*/
%end

//TESt
%hook account_setOffline_res
-(void)setResponse:(int)response
{
	if(response)
	{
	loadSettings();
	if([[settings objectForKey:@"sOffline"] boolValue])
	{
		loadSettings();
		response = 1;
		return %orig(response);
	}
	else
	{
		loadSettings();
		response = 0;
		return %orig(response);
	}
	loadSettings();
}
}
%end
//test

//Offline
%hook account_setOnline_req
-(id)getMethodName
{    
	loadSettings();
	if([[settings objectForKey:@"sOffline"] boolValue]) 
	{
		loadSettings();
	 	return nil;
	}
	else
	{		
		loadSettings();
		return %orig;

	}
	loadSettings();
}
%end

//Don't read messages
%hook iPadChatViewController
-(void)markAsReadProc
{
	loadSettings();
	if(![[settings objectForKey:@"sDontRead"] boolValue])
	%orig;
}
%end

//Hide typing
%hook messages_setActivity_req
-(void)setType:(id)arg1
{
	//loadSettings();
	if(![[settings objectForKey:@"sHideTyping"] boolValue])
	%orig;
}
%end

//Disable adult
%hook video_search_req
-(void)setFilters:(id)arg1
{
	loadSettings();
	if(![[settings objectForKey:@"sAdultOff"] boolValue])
	%orig;
}
%end


%group VKHD2 													//For VKHD 2.0 & above, iOS 7-9.
//Remove user and groups adult.
%hook VKHTTPClient
-(void)setDefaultHeaders:(id)arg1
{
	%orig(nil);
}
%end

//Disable ADs
%hook adsint_hideAd_req
-(void)setAd_data:(id)arg1
{
	%orig(nil);
}
%end

%hook VKPost
-(void)setAds:(id)arg1
{
	%orig(nil);
}
%end

//Return audio section
%hook ApplicationManager
+(BOOL)shouldHideMusicSection
{
	return FALSE;
}
+(BOOL)isMusicDisabled
{
	return FALSE;
}
+(BOOL)isCacheDisabled
{
	return FALSE;
}
+(void)disableCache:(BOOL)arg1
{
	arg1 = FALSE;
}
%end

//Switch to cache
%hook CacheFileInfo
-(void)setNeedCache:(BOOL)arg1
{
    loadSettings();
    if([[settings objectForKey:@"sCacheOn"] boolValue])
    {
        %orig(TRUE);
    }
    else
        %orig(FALSE);
}
%end

//iPad Audio cache cell
%hook iPadAudioViewController
%new(v@:)
- (void) cacheOn:(id)sender {    
    loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
    	NSLog(@"=========== |Cache is enable| ===========");
        [settings setValue:@YES forKey:@"sCacheOn"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        loadSettings();
        //[settings writeToFile:settingsFile atomically:YES];
        
    }
    else
    {
    	NSLog(@"=========== |Cache is disable| ===========");
        [settings setValue:@NO forKey:@"sCacheOn"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        loadSettings();
    }
    loadSettings();
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{   
	UITableViewCell *r = %orig;
    if(indexPath.row == 3 && indexPath.section == 0)
    {
        NSLog(@"=========== |Creating Switch cache cell....| ===========");
        loadSettings();
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = %orig;
        
        //Add switch
        switchView4 = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = switchView4;
        loadSettings();
        if (switchView4 && [[settings objectForKey:@"sCacheOn"] boolValue]) [switchView4 setOn:YES animated:NO];
        else [switchView4 setOn:NO animated:NO];
        [switchView4 addTarget:self action:@selector(cacheOn:) forControlEvents:UIControlEventValueChanged];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        [switchView4 autorelease];
        NSLog(@"=========== |Switch created ^^| ===========");
        return cell;
    }
    else
    return r;
    loadSettings();
}
%end
%hook iPadWallViewController
- (void)userBecomeOnline:(id)arg1
{
	if([[settings objectForKey:@"sOffline"] boolValue])
	{
		%orig(nil);
	}
	%orig;
}
%end
//Slide menu
%hook SidebarMenuController

//TEST
%new(v@:)
- (void) offlineOn:(id)sender {    
	loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sOffline"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        loadSettings();
        //[settings writeToFile:settingsFile atomically:YES];
        
    }
    else
    {
    	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"VK Preferences" 
       			//message:(RusLang) ? @"Вы действительно хотите стать онлайн?" : @""
                message:(RusLang) ? @"Вы действительно хотите стать онлайн?" : @"Вы действительно хотите стать онлайн?"
        		delegate:self 
        		//cancelButtonTitle:(RusLang) ? @"Нет" : @"No"
                cancelButtonTitle:(RusLang) ? @"Нет" : @"Нет"
        		//otherButtonTitles:(RusLang) ? @"Да" : @"Yes", nil];
                otherButtonTitles:(RusLang) ? @"Да" : @"Да", nil];
    			[alert show];
    			[alert release];
        loadSettings();
    }
    loadSettings();
}
//Alert
%new(v@:@@)
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
  	{
  		[switchView setOn:YES animated:NO];
		[settings setValue:@YES forKey:@"sOffline"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        loadSettings();
  	}
  	else if (buttonIndex == 1)
  	{
  		[settings setValue:@NO forKey:@"sOffline"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
        loadSettings();
  	}
}
//Alert

%new(v@:)
- (void) readMessages:(id)sender {
    loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sDontRead"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
    else
    {
        [settings setValue:@NO forKey:@"sDontRead"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
}

%new(v@:)
- (void) hideTyping:(id)sender {
    loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sHideTyping"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
    else
    {
        [settings setValue:@NO forKey:@"sHideTyping"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    }
}
/*
%new(v@:)
- (void) offTweak:(id)sender {
    loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" error:NULL];
        [settings setValue:@YES forKey:@"sOff"];
        //[settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    }
    else
    {
        [settings setValue:@NO forKey:@"sOff"];
        //[settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    }
}
*/
//Отвечает за количество cell в меню.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //int a = %orig;
    //cellIndex = a;
    //a = menuEnabled.count;
    //return [menuEnabled count];
    
   	int a = %orig;//12 cell

   	//int a = 11;//11 cell

    cellIndex = a;
    return a + 2;
    //return a + 1; 
          
}

/*
-(void)tableView:(id)view didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.row != cellIndex) 
    %orig;
}
*/
/*
-(void)viewDidLoad
{
	%orig;
	menu = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenu.plist"];
	menuEnabled = menu[@"enabled"];
}
*/
//Switches in menu.
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	UITableViewCell *r = %orig;
    //NORMAL
    
	if(indexPath.row == cellIndex - 1)
    {
        NSLog(@"=========== |Editing <Help> cell....| ===========");
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1)
        {
            return cell1;
        }
        NSLog(@"=========== |Cell <Help> edited| ===========");
        cell1 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//cell1.textLabel.text = (RusLang) ? @"Оффлайн" : @"Offline";
        cell1.textLabel.text = (RusLang) ? @"Оффлайн" : @"Оффлайн";
    	cell1.textLabel.font = [UIFont systemFontOfSize:17];
    	cell1.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Offline.png"];
    	cell1.backgroundColor = [UIColor clearColor];
    	cell1.textLabel.backgroundColor = [UIColor clearColor];
    	cell1.textLabel.textColor = [UIColor whiteColor];
    	cell1.textLabel.highlightedTextColor = [UIColor whiteColor];
    	cell1.selectionStyle = UITableViewCellSelectionStyleNone;

    	//Add Switch for cell 1
    	switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    	cell1.accessoryView = switchView;
    	loadSettings();
    	if (switchView && [[settings objectForKey:@"sOffline"] boolValue]) [switchView setOn:YES animated:NO];
  		else [switchView setOn:NO animated:NO];
    	[switchView addTarget:self action:@selector(offlineOn:) forControlEvents:UIControlEventValueChanged];
    	[settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    	[switchView autorelease];
    	//[tableView reloadData];
        return cell1;
    }
    //TEST
	

	//else if(indexPath.row == cellIndex + 1)
	else if(indexPath.row == cellIndex)
    {    
    	NSLog(@"=========== |Don't read cell created.| ===========");
    	static NSString *CellIdentifier = @"Cell2";
    	UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    	cell2 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    	//cell2.textLabel.text = (RusLang) ? @"Не читать" : @"Don't read";
        cell2.textLabel.text = (RusLang) ? @"Не читать" : @"Не читать";

    	cell2.textLabel.font = [UIFont systemFontOfSize:17];
    	cell2.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Dontread.png"];
    	cell2.backgroundColor = [UIColor clearColor];
    	cell2.textLabel.backgroundColor = [UIColor clearColor];
    	cell2.textLabel.textColor = [UIColor whiteColor];
    	cell2.textLabel.highlightedTextColor = [UIColor whiteColor];
    	cell2.selectionStyle = UITableViewCellSelectionStyleNone;

    	//Add switch for cell 2
		switchView2 = [[UISwitch alloc] initWithFrame:CGRectZero];
    	cell2.accessoryView = switchView2;
    	loadSettings();
    	if (switchView2 && [[settings objectForKey:@"sDontRead"] boolValue]) [switchView2 setOn:YES animated:NO];
    	else [switchView2 setOn:NO animated:NO];
		[switchView2 addTarget:self action:@selector(readMessages:) forControlEvents:UIControlEventValueChanged];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
		[switchView2 autorelease];
		//[tableView reloadData];
        return cell2;
    }
    //else if(indexPath.row == cellIndex + 2)
    else if(indexPath.row == cellIndex + 1)
    {    
    	NSLog(@"=========== |Don't type cell created.| ===========");
    	static NSString *CellIdentifier = @"Cell3";
    	UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    	cell3 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    	//cell3.textLabel.text = (RusLang) ? @"Скрыть набор" : @"Hide typing";

        cell3.textLabel.text = (RusLang) ? @"Скрыть набор" : @"Скрыть набор";
    	cell3.textLabel.font = [UIFont systemFontOfSize:17];
    	cell3.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Donttype.png"];
    	cell3.backgroundColor = [UIColor clearColor];
    	cell3.textLabel.backgroundColor = [UIColor clearColor];
    	cell3.textLabel.textColor = [UIColor whiteColor];
    	cell3.textLabel.highlightedTextColor = [UIColor whiteColor];
    	cell3.selectionStyle = UITableViewCellSelectionStyleNone;

    	//Add switch for cell 3.
    	switchView3 = [[UISwitch alloc] initWithFrame:CGRectZero];
    	cell3.accessoryView = switchView3;
    	if (switchView3 && [[settings objectForKey:@"sHideTyping"] boolValue]) [switchView3 setOn:YES animated:NO];
    	else [switchView3 setOn:NO animated:NO];
    	[switchView3 addTarget:self action:@selector(hideTyping:) forControlEvents:UIControlEventValueChanged];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:NO];
    	[switchView3 autorelease];
    	//[tableView reloadData];
    	return cell3;
    }
    /*
        else if(indexPath.row == cellIndex + 2)
    {    
        NSLog(@"=========== |Off cell created.| ===========");
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell4 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell3.textLabel.text = (RusLang) ? @"Скрыть набор" : @"Hide typing";

        cell4.textLabel.text = (RusLang) ? @"ОРНУТЬ" : @"ОРНУТЬ";
        cell4.textLabel.font = [UIFont systemFontOfSize:17];
        //cell4.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Dont2type.png"];
        cell4.backgroundColor = [UIColor clearColor];
        cell4.textLabel.backgroundColor = [UIColor clearColor];
        cell4.textLabel.textColor = [UIColor whiteColor];
        cell4.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;

        //Add switch for cell 3.
        switchView5 = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell4.accessoryView = switchView5;
        if (switchView5 && [[settings objectForKey:@"sOff"] boolValue]) [switchView5 setOn:YES animated:NO];
        else [switchView5 setOn:NO animated:NO];
        [switchView5 addTarget:self action:@selector(offTweak:) forControlEvents:UIControlEventValueChanged];
        [switchView5 autorelease];
        //[tableView reloadData];
        return cell4;
    }
    */
    else
    {
    	return r;
    }
    //TEST
    [tableView reloadData];
    //TEST
    
    loadSettings();
    //return r;
}
%end //end hook

%end //end vkhd2 group

%group VKHD1                                                //For VKHD 1.7 & early. iOS 6-8.

%hook iPadMainViewController
%new(v@:)
- (void) offlineOn:(id)sender {    
	loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sOffline"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
        loadSettings();
        //[settings writeToFile:settingsFile atomically:YES];
        
    }
    else
    {
    	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"VK Preferences" 
       			message:(RusLang) ? @"Вы действительно хотите стать онлайн?" : @""
        		delegate:self 
        		cancelButtonTitle:(RusLang) ? @"Нет" : @"No"
        		otherButtonTitles:(RusLang) ? @"Да" : @"Yes", nil];
    			[alert show];
    			[alert release];
        loadSettings();
    }
    loadSettings();
}
//Alert
%new(v@:@@)
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
  	{
  		[switchView setOn:YES animated:NO];
		[settings setValue:@YES forKey:@"sOffline"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
        loadSettings();
  	}
  	else if (buttonIndex == 1)
  	{
  		[settings setValue:@NO forKey:@"sOffline"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
        loadSettings();
  	}
}
//Alert

%new(v@:)
- (void) readMessages:(id)sender {
    loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sDontRead"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    }
    else
    {
        [settings setValue:@NO forKey:@"sDontRead"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    }
}

%new(v@:)
- (void) hideTyping:(id)sender {
    loadSettings();
    UISwitch* switchControl = sender;
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    if(switchControl.on)
    {
        [settings setValue:@YES forKey:@"sHideTyping"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    }
    else
    {
        [settings setValue:@NO forKey:@"sHideTyping"];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
    }
}

//Отвечает за количество cell в меню.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int a = %orig;
    cellIndex = a;
    return a + 3;        
}

//Switches in menu.
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *r = %orig;
	if(indexPath.row == cellIndex)
    {    
        NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell1 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier] autorelease];
        cell1.textLabel.text = (RusLang) ? @"Оффлайн" : @"Offline";
        cell1.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell1.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Offline.png"];
        cell1.backgroundColor = [UIColor clearColor];
        cell1.textLabel.backgroundColor = [UIColor clearColor];
        cell1.textLabel.textColor = [UIColor whiteColor];
        cell1.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;

        //Add Switch for cell 1
        switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell1.accessoryView = switchView;
        loadSettings();
        if (switchView && [[settings objectForKey:@"sOffline"] boolValue]) [switchView setOn:YES animated:NO];
        else [switchView setOn:NO animated:NO];
        [switchView addTarget:self action:@selector(offlineOn:) forControlEvents:UIControlEventValueChanged];
        [settings writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist" atomically:YES];
        [switchView autorelease];
        return cell1;
        //[tableView reloadData];
    }
    else if(indexPath.row == cellIndex + 1)
    {    
        NSString *CellIdentifier2 = @"Cell2";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        cell2 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier2] autorelease];
        cell2.textLabel.text = (RusLang) ? @"Не читать" : @"Don't read";
        cell2.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell2.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Dontread.png"];
        cell2.backgroundColor = [UIColor clearColor];
        cell2.textLabel.backgroundColor = [UIColor clearColor];
        cell2.textLabel.textColor = [UIColor whiteColor];
        cell2.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;

        //Add switch for cell 2
        switchView2 = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell2.accessoryView = switchView2;
        loadSettings();
        if (switchView2 && [[settings objectForKey:@"sDontRead"] boolValue]) [switchView2 setOn:YES animated:NO];
        else [switchView2 setOn:NO animated:NO];
        [switchView2 addTarget:self action:@selector(readMessages:) forControlEvents:UIControlEventValueChanged];
        [switchView2 autorelease];
        return cell2;
        //[tableView reloadData];
    }
    else if(indexPath.row == cellIndex + 2)
    {    
        NSString *CellIdentifier3 = @"Cell3";
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        cell3 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier3] autorelease];
        cell3.textLabel.text = (RusLang) ? @"Скрыть набор" : @"Hide typing";
        cell3.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell3.imageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/VKPIcons/Donttype.png"];
        cell3.backgroundColor = [UIColor clearColor];
        cell3.textLabel.backgroundColor = [UIColor clearColor];
        cell3.textLabel.textColor = [UIColor whiteColor];
        cell3.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;

        //Add switch for cell 3.
        switchView3 = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell3.accessoryView = switchView3;
        if (switchView3 && [[settings objectForKey:@"sHideTyping"] boolValue]) [switchView3 setOn:YES animated:NO];
        else [switchView3 setOn:NO animated:NO];
        [switchView3 addTarget:self action:@selector(hideTyping:) forControlEvents:UIControlEventValueChanged];
        [switchView3 autorelease];
        return cell3;
        //[tableView reloadData];
    }
    else
    return r; 
    loadSettings();
}
%end

%end //Group vkhd1 end

//Supported Version (TEST)
/*
@interface VKVersionCheck : NSObject {
    NSArray *_supportedVersions;
}
@property (nonatomic, assign) NSArray *supportedVersions;
- (id)init;
- (BOOL)isSupportedVersion;
@end

@implementation VKVersionCheck
@synthesize supportedVersions=_supportedVersions;

- (id)init {
    self.supportedVersions = [NSArray arrayWithObjects:@"2.0", @"2.0.1", nil];
    return self;
}

- (BOOL)isSupportedVersion 
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
@end
*/

%ctor
{
    loadSettings();
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkpreferencesbundle.plist"];
    RusLang = [[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ru"];

    //VK Version Check
    NSString *vkVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];   //Check VKHD version
    %init(_ungrouped);
    if([vkVersion isEqualToString:@"1.7"]) //Add support app verion
    {
        %init(VKHD1); //If VKHD Version is 1.7, activate VKHD1 group
    }
    else //Else if VKHD version is 2.0 & above, activate VKHD2 group
    {
        %init(VKHD2);
    }

}
