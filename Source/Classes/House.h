//
//  House.h
//  HomeLess
//
//  Created by Guillermo Apoj on 11/6/14.
//
//

#import <Parse/Parse.h>

@interface House : PFObject <PFSubclassing>

@property NSString *houseDescription;
@property NSString *rentOrSale;
@property NSInteger rooms;
@property NSInteger bathrooms
;
@property NSInteger squareMeters
;

@property BOOL isDogAllowed;
@property BOOL isCatAllowed;
@property BOOL withGarage;
@property PFUser *owner;

@end
