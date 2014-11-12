
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "House.h"
@interface HousePhoto : PFObject <PFSubclassing>
@property NSString* title;
@property PFUser *owner;
@property UIImageView *myPhoto;
@property PFFile *parsePhoto;
@property BOOL isMain;
@end
