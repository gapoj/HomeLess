

#import "FavoriteViewController.h"
#import "HouseTableViewCell.h"
#import "House.h"
#import "Favorite.h"

@interface FavoriteViewController ()<UITableViewDataSource,UITableViewDelegate>
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
    [favoritesQuery whereKey:@"owner" equalTo:[PFUser currentUser]];
    [favoritesQuery findObjectsInBackgroundWithBlock:^(NSArray *favorites, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
            self.favorites = favorites;
        }
    }];
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
    House * house = [self.favorites objectAtIndex:indexPath.row];
    cell.label.text = house.title;
    
    return cell;
}

@end
