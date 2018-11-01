NSMutableArray *logins = [[NSMutableArray alloc] initWithContentsOfFile:accountsPath];
NSMutableArray *passwords = [[NSMutableArray alloc] initWithContentsOfFile:accountsPath];

auth = [[auth_login_req alloc] init];
[auth setPassword:fromArray:@"Login"];
[auth setUsername:fromArray:@"Password"];
[auth setClient_id:@"3682744"];
[auth setClient_secret:@"mY6CDUswIVdJLCD3j15n"];
[auth setScope:@"notify,friends,photos,audio,video,docs,notes,wall,groups,messages,notifications,activity,status,pages,stats,nohttps,adsint"];
requestAuth = [[VKAPIController sharedInstance] retain];
[requestAuth sendRequest:auth viaHTTPS:1];