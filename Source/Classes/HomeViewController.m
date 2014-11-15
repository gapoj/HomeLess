#import "HomeViewController.h"
#import "DraggableViewBackground.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "DetailsHouseViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "DWBubbleMenuButton.h"
#import "SendMessageViewController.h"
#import "MessagesViewController.h"
#import "LoginViewController.h"
#import "HousePhoto.h"
// cocambie y suba
//mentario para que
@interface HomeViewController (){
    
    UIButton* infoButton;
    UILabel *name;
    DraggableViewBackground *draggableBackground;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.75 green:0.92 blue:0.83 alpha:.5];
    draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];

    draggableBackground.center = self.view.center;
    [self.view addSubview:draggableBackground];
    infoButton = [[UIButton alloc]initWithFrame:CGRectMake(125, 430, 75, 75)];
    [infoButton setImage:[UIImage imageNamed:@"infoButton"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    UILabel *homeLabel = [self createHomeButtonView];
    DWBubbleMenuButton *menuButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(15,25,50,50) expansionDirection:DirectionDown];
    menuButton.homeButtonView = homeLabel;
    [menuButton addButtons:[self createDemoButtonArray]];
    [self.view addSubview:menuButton];
    name = [[UILabel alloc]initWithFrame:CGRectMake(100, 33, 170, 42)];
    name.font = [UIFont systemFontOfSize:33];
    name.text = @"HomeLess";
    name.textColor = [UIColor colorWithRed:.64 green:.5 blue:1 alpha:1];
    [self.view addSubview:name];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)showUserDetails {
    UserDetailsViewController *detailsViewController = [[UserDetailsViewController alloc] init];
    [self showViewController:detailsViewController sender:self];
}
- (void)showMessages {
    MessagesViewController *vc = [[MessagesViewController alloc] init];
    vc.inbox = YES;
    [self showViewController:vc sender:self];
}
- (void)showFiltersrDetails {
    FiltersViewController *detailsViewController = [[FiltersViewController alloc] init];
    [self showViewController:detailsViewController sender:self];
}

-(void) logoutUser
{
    [PFUser logOut];
    LoginViewController * detailsViewController = [[LoginViewController alloc]init];
    [self showViewController:detailsViewController sender:self];
}

-(void) showFavorites
{
    
}

-(void) showInfo
{
    DetailsHouseViewController *detailsViewController = [[DetailsHouseViewController alloc]init];
    HousePhoto *photo = draggableBackground.houseCards[draggableBackground.houseIndex];

    
    
    detailsViewController.house = photo.house;
    [self showViewController:detailsViewController sender:self];

}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] init ];
    label.frame = CGRectMake(10, 20, 50, 25);
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu"]];
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    NSArray *imageList = @[[UIImage imageNamed:@"menuUsers"], [UIImage imageNamed:@"menuFavorite"],[UIImage imageNamed:@"menuFilters"],[UIImage imageNamed:@"menuChat"],[UIImage imageNamed:@"menuLogout"]];
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
            [self showUserDetails];
            break;
        case 1:
            [self showFavorites];
            break;
        case 2:
            [self showFiltersrDetails];
            break;
        case 3:
            [self showMessages];
            break;
        case 4:
            [self logoutUser];
            break;
        default:
            break;
    }
}

- (BOOL)prefersStatusBarHidden {
    return true;
}
@end
