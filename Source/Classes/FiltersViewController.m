#import "FiltersViewController.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "HomeViewController.h"
#import "DWBubbleMenuButton.h"
#import "HomeViewController.h"
#import "DraggableViewBackground.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "DetailsHouseViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "DWBubbleMenuButton.h"
#import "Filter.h"

@interface FiltersViewController ()
@property (weak, nonatomic) IBOutlet UILabel *petLabel;
@property BOOL isDogAllowed;
@property BOOL isCatAllowed;
@property (weak, nonatomic) IBOutlet UITextField *roomLow;
@property (weak, nonatomic) IBOutlet UITextField *roomHigh;
@property (weak, nonatomic) IBOutlet UITextField *sqrLow;
@property (weak, nonatomic) IBOutlet UITextField *sqrHigh;
@property (weak, nonatomic) IBOutlet UITextField *priceHigh;
@property (weak, nonatomic) IBOutlet UITextField *priceLow;
@property (weak, nonatomic) IBOutlet UITextField *bathLow;
@property (weak, nonatomic) IBOutlet UITextField *bathHigh;
@property (weak, nonatomic) IBOutlet UISegmentedControl *garageSegmented;
@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCatAllowed = false;
    self.isDogAllowed = false;
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1350)];
}

- (IBAction)onSaveButtonPressed:(id)sender {
    PFQuery *filterQuery = [Filter query];
    [filterQuery whereKey:@"owner" equalTo:[PFUser currentUser]];
    [filterQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else
        {
            Filter *newFilter = [Filter object];
            if (objects)
            {
                newFilter = objects.firstObject;
            }
            newFilter.owner = [PFUser currentUser];
            newFilter.roomsLow = [self.roomLow.text integerValue];
            newFilter.roomsHigh = [self.roomHigh.text integerValue];
            newFilter.squareMetersLow = [self.sqrLow.text integerValue];
            newFilter.squareMetersHigh = [self.sqrHigh.text integerValue];
            newFilter.priceLow = [self.priceLow.text integerValue];
            newFilter.priceHigh = [self.priceHigh.text integerValue];
            newFilter.bathroomsLow = [self.bathLow.text integerValue];
            newFilter.bathroomsHigh = [self.bathHigh.text integerValue];
            newFilter.petAllowed = self.petLabel.text;
            [newFilter saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        }
    }];
}

- (IBAction)onCatPressed:(id)sender {
    self.isCatAllowed = ! self.isCatAllowed;
    [self updatePetAllowedLabel];
}
- (IBAction)onDogPressed:(id)sender {
    self.isDogAllowed = !self.isDogAllowed;
    [self updatePetAllowedLabel];
}

-(void) updatePetAllowedLabel
{
    if (self.isDogAllowed && self.isCatAllowed) {
        self.petLabel.text =@"Cat & Dog";
    }else if (self.isDogAllowed || self.isCatAllowed) {
        self.petLabel.text =@"";
        if (self.isCatAllowed) {
            self.petLabel.text =@"Cat";
        }
        if(self.isDogAllowed){
            self.petLabel.text =@"Dog";
        }
    }else
    {
        self.petLabel.text =@"";
    }
}

- (IBAction)onHomePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
