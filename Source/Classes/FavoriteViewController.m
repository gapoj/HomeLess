
#import "FavoriteViewController.h"
#import "HouseTableViewCell.h"
#import "House.h"
#import "Favorite.h"

@interface FavoriteViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favorites = [NSArray array];
    [self loadFavorites];
}

-(void) loadFavorites
{
    PFQuery *favoritesQuery = [Favorite query];
    [favoritesQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [favoritesQuery includeKey:@"house"];
    [favoritesQuery findObjectsInBackgroundWithBlock:^(NSArray *favorites, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
            self.favorites = favorites;
            [self.tableView reloadData];
        }
    }];
}
- (IBAction)onHomeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HouseTableViewCell" bundle:nil] forCellReuseIdentifier:@"HouseCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"HouseCell"];
    }
    Favorite * favorite = [self.favorites objectAtIndex:indexPath.row];
    cell.label.text = favorite.house.title;
    
    return cell;
}

@end
