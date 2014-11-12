
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

@interface FiltersViewController ()
@property (weak, nonatomic) IBOutlet UISlider *roomsSlider;
@property (weak, nonatomic) IBOutlet UISlider *sqrMetersSlider;
@property (weak, nonatomic) IBOutlet UISlider *bathsSlider;
@property (weak, nonatomic) IBOutlet UILabel *roomsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *sqrValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *bathsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *petLabel;
@property BOOL isDogAllowed;
@property BOOL isCatAllowed;
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
}

- (IBAction)onRoomsChanged:(id)sender {
    int sliderVal =0;
    sliderVal = self.roomsSlider.value;
    self.roomsValueLabel.text= [NSString stringWithFormat:@"%d", sliderVal];
}
- (IBAction)onSqrMetersChanged:(id)sender {
    int sliderVal =0;
    sliderVal = self.sqrMetersSlider.value*25;
    self.sqrValueLabel.text= [NSString stringWithFormat:@"%d", sliderVal];
}
- (IBAction)onBathsChanged:(id)sender {
    int sliderVal =0;
    sliderVal = self.bathsSlider.value;
    self.bathsValueLabel.text= [NSString stringWithFormat:@"%d", sliderVal];
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
