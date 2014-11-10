#import "HomeViewController.h"
#import "DraggableViewBackground.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "DetailsHouseViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
@interface HomeViewController (){

    UIButton* infoButton;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageList = @[[UIImage imageNamed:@"menuHome"], [UIImage imageNamed:@"menuUsers"], [UIImage imageNamed:@"menuFavorite"],[UIImage imageNamed:@"menuFilters"],[UIImage imageNamed:@"menuChat"],[UIImage imageNamed:@"menuLogout"]];
    sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    sideBar.delegate = self;
    
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    draggableBackground.center = self.view.center;
    [self.view addSubview:draggableBackground];
    infoButton = [[UIButton alloc]initWithFrame:CGRectMake(135, 430, 59, 59)];
    [infoButton setImage:[UIImage imageNamed:@"infoButton"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 70, 50)];
}

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

- (void)menuButtonClicked:(int)index{
    switch (index) {
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
