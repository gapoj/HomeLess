#import <UIKit/UIKit.h>
#import "House.h"

@interface DetailsHouseViewController : UIViewController
{
   
  
    IBOutlet UIScrollView *scroller;
    __weak IBOutlet UIButton *editButton;
}
@property House * house;
@property (strong, nonatomic) IBOutlet UILabel *housetitle;
@property (strong, nonatomic) IBOutlet UITextView *desc;
@property (strong, nonatomic) IBOutlet UITextField *rooms;
@property (strong, nonatomic) IBOutlet UITextField *squareMeters;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *baths;
@property (strong, nonatomic) IBOutlet UIImageView *garage;
@property (strong, nonatomic) IBOutlet UIImageView *cat;

@property (strong, nonatomic) IBOutlet UIImageView *dog;



@end
