#import <Parse/Parse.h>

@interface Filter : PFObject <PFSubclassing>
@property NSString *rentOrSale;
@property NSInteger priceLow;
@property NSInteger roomsLow;
@property NSInteger bathroomsLow;
@property NSInteger squareMetersLow;
@property NSInteger priceHigh;
@property NSInteger roomsHigh;
@property NSInteger bathroomsHigh;
@property NSInteger squareMetersHigh;
@property NSString *petAllowed;
@property PFUser* owner;
@end
