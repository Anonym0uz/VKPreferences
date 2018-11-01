#import "../VKHDHeaders/VKRequest.h"
#import <UIKit/UIKit.h>

@interface gift_req : VKRequest
{
    NSNumber *_user_id;
    NSNumber *_offset;
    NSNumber *_count;
}

@property(retain, nonatomic) NSNumber *user_id; // @synthesize user_id=_user_id;
@property(retain, nonatomic) NSNumber *count; // @synthesize count=_count;
@property(retain, nonatomic) NSNumber *offset; // @synthesize offset=_offset;
- (Class)responseClass;
- (id)getMethodName;
@end
