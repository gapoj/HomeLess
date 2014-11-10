//
//  ViewController.m
//  HomeLess
//
//  Created by Guillermo Apoj on 11/4/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "HomeViewController.h"
#import "DraggableViewBackground.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageList = @[[UIImage imageNamed:@"menuHome"], [UIImage imageNamed:@"menuUsers"], [UIImage imageNamed:@"menuFavorite"],[UIImage imageNamed:@"menuFilters"],[UIImage imageNamed:@"menuLogout"]];
    sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    sideBar.delegate = self;
    
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    draggableBackground.center = self.view.center;
    [self.view addSubview:draggableBackground];
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
- (void)menuButtonClicked:(int)index{
    switch (index) {
        case 0:
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
