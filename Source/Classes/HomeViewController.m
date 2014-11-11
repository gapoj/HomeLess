#import "HomeViewController.h"
#import "DraggableViewBackground.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "DetailsHouseViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "DWBubbleMenuButton.h"
#import "SendMessageViewController.h"
@interface HomeViewController (){

    UIButton* infoButton;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    draggableBackground.center = self.view.center;
    [self.view addSubview:draggableBackground];
    infoButton = [[UIButton alloc]initWithFrame:CGRectMake(135, 430, 75, 75)];
    [infoButton setImage:[UIImage imageNamed:@"infoButton"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    UILabel *homeLabel = [self createHomeButtonView];
    DWBubbleMenuButton *menuButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(270,10,50,50) expansionDirection:DirectionDown];
    menuButton.homeButtonView = homeLabel;
    [menuButton addButtons:[self createDemoButtonArray]];
    [self.view addSubview:menuButton];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
   
    PFQuery *housesQuery = [House query];
    [housesQuery whereKey:@"title" equalTo:@"barbara 1"];
    [housesQuery includeKey:@"owner"];
    [housesQuery findObjectsInBackgroundWithBlock:^(NSArray *houses, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
            SendMessageViewController *vc = [[SendMessageViewController alloc]init];
            vc.relatedHouse = houses[0];
            [self showViewController:vc sender:self];
        }
    }];
    //DetailsHouseViewController *detailsViewController = [[DetailsHouseViewController alloc] init];
    //[self showViewController:detailsViewController sender:self];
}

-(void) showHome
{
   
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

- (BOOL)prefersStatusBarHidden {
    return true;
}
@end
