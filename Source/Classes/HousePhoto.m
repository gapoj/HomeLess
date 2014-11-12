
#import "HousePhoto.h"

@implementation HousePhoto
@dynamic title;
@dynamic owner;
@dynamic myPhoto;
@dynamic isMain;

+ (NSString*) parseClassName
{
    return @"HousePhoto";
}

+(void) load
{
    [self registerSubclass];
}
@end