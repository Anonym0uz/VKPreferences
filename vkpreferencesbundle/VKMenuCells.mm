#import <Preferences/Preferences.h>

NSMutableDictionary *menu;

@interface VKMenuCells: PSListController {
}
@end

@implementation VKMenuCells
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"VKMenuCells" target:self] retain];
	}
	return _specifiers;
}

//Создание файла настроек .plist, если его нету.
static void loadSettings()
{
    menu = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenucells.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/ru.anonz.vkmenucells.plist"])
    {
        NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
        [menu writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenucells.plist" atomically:NO];
    }
    
}



-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)spec
{
    loadSettings();
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenucells.plist"];
    [menu setValue:value forKey:[spec propertyForKey:@"key"]];
    [menu writeToFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenucells.plist" atomically: NO];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("ru.anonz.vkpreferencesbundle.post"), NULL, NULL, YES);
}

-(id)getPreferenceValue:(PSSpecifier*)spec
{
   loadSettings();
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ru.anonz.vkmenucells.plist"];
    return [menu objectForKey:[spec propertyForKey:@"key"]];
}

@end

