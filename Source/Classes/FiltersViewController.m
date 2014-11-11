
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
    
    UILabel *homeLabel = [self createHomeButtonView];
    DWBubbleMenuButton *menuButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(270,10,50,50) expansionDirection:DirectionDown];
    menuButton.homeButtonView = homeLabel;
    [menuButton addButtons:[self createDemoButtonArray]];
    [scroller addSubview:menuButton];
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







#pragma Menubutton

- (void)showUserDetails {
    UserDetailsViewController *detailsViewController = [[UserDetailsViewController alloc] init];
    [self showViewController:detailsViewController sender:self];
}

- (void)showFiltersrDetails {
    FiltersViewController *detailsViewController = [[FiltersViewController alloc] init];
    [self showViewController:detailsViewController sender:self];
}

-(void) logoutUser
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) showFavorites
{
    
}

-(void) showInfo
{
    DetailsHouseViewController *detailsViewController = [[DetailsHouseViewController alloc] init];
    [self showViewController:detailsViewController sender:self];
}

-(void) showHome
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] init ];
    label.frame = CGRectMake(10, 10, 50, 50);
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menuIcon"]];
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    NSArray *imageList = @[[UIImage imageNamed:@"menuHome"], [UIImage imageNamed:@"menuUsers"], [UIImage imageNamed:@"menuFavorite"],[UIImage imageNamed:@"menuFilters"],[UIImage imageNamed:@"menuChat"],[UIImage imageNamed:@"menuLogout"]];
    int i = 0;
    for (UIImage *image in imageList){
        UIButton *button = [[UIButton alloc]init];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0.f, 0.f, 44, 44);
        button.clipsToBounds = YES;
        button.tag = i++;
        [button addTarget:self action:@selector(showNextController:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsMutable addObject:button];
    }
    return [buttonsMutable copy];
}

- (void)showNextController:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self showHome];
            break;
        case 1:
            [self showUserDetails];
            break;
        case 2:
            [self showFavorites];
            break;
        case 3:
            [self showFiltersrDetails];
            break;
        case 4:
            [self logoutUser];
            break;
        default:
            break;
    }
}


@end
