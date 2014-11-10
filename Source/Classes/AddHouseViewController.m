//
//  AddHouseViewController.m
//  HomeLess
//
//  Created by Guillermo Apoj on 11/6/14.
//
//
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AddHouseViewController.h"
#import "House.h"

@interface AddHouseViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *rentOrSaleSegmentControl;
@property (strong, nonatomic) IBOutlet UISlider *roomsSlider;
- (IBAction)roomsValueChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *squareMetersSlider;
- (IBAction)squareMetersChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *bathroomsSlider;
- (IBAction)bathroomsChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *roomsLabel;
@property (strong, nonatomic) IBOutlet UILabel *squareMetersLabel;
@property (strong, nonatomic) IBOutlet UILabel *bathroomsLabel;
@property (weak, nonatomic) IBOutlet UITextView *desc;
- (IBAction)onSave:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *petLabel;
@property BOOL isDogAllowed;
@property BOOL isCatAllowed;
@property (weak, nonatomic) IBOutlet UISegmentedControl *garageSegmentControl;
@end

@implementation AddHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1000)];
    self.desc.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddPhotos:(id)sender {
}


- (IBAction)roomsValueChanged:(id)sender {
    int sliderVal =0;
    sliderVal = self.roomsSlider.value;
    self.roomsLabel.text= [NSString stringWithFormat:@"%d", sliderVal];
}
- (IBAction)squareMetersChanged:(id)sender {
    int sliderVal =0;
    sliderVal = self.squareMetersSlider.value*25;
    self.squareMetersLabel.text= [NSString stringWithFormat:@"%d", sliderVal];
}
- (IBAction)bathroomsChanged:(id)sender {
    int sliderVal =0;
    sliderVal = self.bathroomsSlider.value;
    self.bathroomsLabel.text= [NSString stringWithFormat:@"%d", sliderVal];
}
- (IBAction)onSave:(id)sender {
    House *newHouse = [House object];
    newHouse.owner = [PFUser currentUser];
    newHouse.houseDescription = self.desc.text;
    newHouse.bathrooms = [self.bathroomsLabel.text integerValue];
    newHouse.rooms = [self.roomsLabel.text integerValue];
    newHouse.squareMeters =[self.squareMetersLabel.text integerValue];
    newHouse.isCatAllowed = self.isCatAllowed;
    newHouse.isDogAllowed = self.isDogAllowed;
    if (self.rentOrSaleSegmentControl.selectedSegmentIndex ==0) {
        newHouse.rentOrSale = @"Rent";
    } else {
        newHouse.rentOrSale = @"Sale";
    }
    if (self.garageSegmentControl.selectedSegmentIndex == 0) {
        
        newHouse.withGarage = YES;
    } else {
         newHouse.withGarage = NO;
    }
    [newHouse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"%@",error);
                    }else{
        
            [self dismissViewControllerAnimated:YES completion:^{
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Succes"
                                                                      message:@"The house was saved"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];

                
            }];

        
        }
    }];

    
}
- (IBAction)onCatPressed:(id)sender {
    self.isCatAllowed = !self.isCatAllowed;
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

#pragma mark textview
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    textView.backgroundColor = [UIColor colorWithRed:.93 green:.87 blue:.93 alpha:.5];
    textView.text = @"";
    
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    textView.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
    [self.view endEditing:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
