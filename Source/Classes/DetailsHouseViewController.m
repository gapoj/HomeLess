
#import "DetailsHouseViewController.h"
#import "UserDetailsViewController.h"
#import "FiltersViewController.h"
#import "HomeViewController.h"
@interface DetailsHouseViewController ()
@property NSArray * photos;
@end

@implementation DetailsHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [[NSArray alloc]init];
    [self loadPhotos];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1900)];
    if(!self.house.isDogAllowed){
    self.dog.hidden=YES;
    }
    if(!self.house.isCatAllowed){
        self.cat.hidden=YES;
    }
    if(!self.house.withGarage){
        self.garage.hidden=YES;
    }
    self.desc.text = self.house.houseDescription;
    self.housetitle.text = self.house.title;
   self.baths.text=[NSString stringWithFormat:@"%lu", self.house.bathrooms];
  self.price.text=[NSString stringWithFormat:@"%lu", self.house.price];
   self.squareMeters.text=[NSString stringWithFormat:@"%lu", self.house.bathrooms];
   self.rooms.text=[NSString stringWithFormat:@"%lu", self.house.bathrooms];
    
}
-(void)loadPhotos{
    PFQuery *photoQuery = [HousePhoto query];
    [photoQuery whereKey:@"house"equalTo:self.house];
    [photoQuery orderByDescending:@"isMain" ];
   
    [photoQuery findObjectsInBackgroundWithBlock:^(NSArray *photos, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
           [self photosFromData:photos];
            self.pageControl.numberOfPages = [photos count];
            
        }
    }];
}
-(void)photosFromData:(NSArray * )array{
    NSMutableArray * loadPhotos =[[NSMutableArray alloc ]initWithCapacity:array.count];
    for (HousePhoto *photo in array) {
      
        PFFile *file =  photo.parsePhoto;
        if (file != nil) {
            NSError *error;
            NSData * data = [file getData: &error];
            if (!error) {
               UIImage *image = [UIImage imageWithData:data];
                [loadPhotos addObject:image];
               
            }else{
                NSLog(@"%@",error);
            }

            }
    }
    self.image.image= loadPhotos[0];
    self.photos = loadPhotos;
}
- (IBAction)onPageChanged:(UIPageControl *)sender {
    NSInteger a = sender.currentPage;
    self.image.image = self.photos[a];
}
- (IBAction)onHomeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
    return NO;
}
@end
