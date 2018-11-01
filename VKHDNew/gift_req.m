#import "gift_req.h"

@implementation gift_req

-(NSNumber *)setUser_id
{
    return self;
}
-(NSNumber *)setOffset
{
    return self;
}
-(NSNumber *)setCount
{
    return self;
}

- (id)getMethodName
{
    NSString *metName = [NSString stringWithFormat:@"/methods/%@", [NSString stringWithFormat:@"gifts.get"]];
    return metName;
}

- (Class)responseClass
{
    Class = gift_req;
}

@end
