
#import "DetailsHouseViewController.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "HomeViewController.h"
@interface FiltersViewController ()<UITextFieldDelegate>

@end

@implementation DetailsHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1850)];
    if(!self.house.isDogAllowed){
    self.dog.hidden=YES;
    }
    if(!self.house.isCatAllowed){
        self.cat.hidden=YES;
    }
    if(!self.house.withGarage){
        self.garage.hidden=YES;
    }
    self.desc.text = self.house.houseDescription;
    self.housetitle.text = self.house.title;
   self.baths.text=[NSString stringWithFormat:@"%lu", self.house.bathrooms];
 //  self.price.text=[NSString stringWithFormat:@"%lu", self.house.price];
   self.squareMeters.text=[NSString stringWithFormat:@"%lu", self.house.bathrooms];
   self.rooms.text=[NSString stringWithFormat:@"%lu", self.house.bathrooms];
    
}


- (IBAction)onPageChanged:(UIPageControl *)sender {
    NSInteger a = sender.currentPage;
    a++;
}
- (IBAction)onHomeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
    return NO;
}
@end
