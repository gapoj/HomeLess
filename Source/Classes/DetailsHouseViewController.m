
#import "DetailsHouseViewController.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "HomeViewController.h"
@interface FiltersViewController ()
@end

@implementation DetailsHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1850)];
}

@end
