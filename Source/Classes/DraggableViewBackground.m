
#import "DraggableViewBackground.h"
#import "DetailsHouseViewController.h"
#import "House.h"
#import "HousePhoto.h"


@implementation DraggableViewBackground{
    NSInteger cardsLoadedIndex;
    NSMutableArray *loadedCards;
    UIButton* checkButton;
    UIButton* xButton;
}
static const int MAX_BUFFER_SIZE = 2;
static const float CARD_HEIGHT = 300;
static const float CARD_WIDTH = 260;

@synthesize houseCards;
@synthesize allCards;

- (void)loadData
{   PFQuery *housesQuery = [House query];
    [housesQuery whereKey:@"owner" notEqualTo:[PFUser currentUser]];
    [housesQuery includeKey:@"owner"];
    
    [housesQuery findObjectsInBackgroundWithBlock:^(NSArray *houses, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
            houseCards  = houses;
            [self loadPhotos];
           
        }
    }];
    loadedCards = [[NSMutableArray alloc] init];
    allCards = [[NSMutableArray alloc] init];
    cardsLoadedIndex = 0;
       self.houseIndex = 0;
}
-(void)loadPhotos{
    PFQuery *photoQuery = [HousePhoto query];
    [photoQuery whereKey:@"house"containedIn: houseCards];
    [photoQuery whereKey:@"isMain" equalTo:[NSNumber numberWithBool:YES]];
    [photoQuery includeKey:@"house"];
    [photoQuery findObjectsInBackgroundWithBlock:^(NSArray *photos, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
            houseCards  = photos;
            [self loadCards];
            
        }
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        [self loadData];
    }
    return self;
}

-(NSArray *) loadHouseCards
{
    return [[NSArray alloc]initWithObjects:@"house1",@"house2",@"house3",@"house4",@"house5",@"house1",@"house2",@"house3",@"house4",@"house5", nil];
}

-(void)setupView
{
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 415, 75, 75)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(210, 415, 75, 75)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(30, 100, CARD_WIDTH, CARD_HEIGHT)];
    HousePhoto *photo = [houseCards objectAtIndex:index];
    PFFile *file =  photo.parsePhoto;
    if (file != nil) {
        NSError *error;
        NSData * data = [file getData: &error];
            if (!error) {
                draggableView.imageHouse.image = [UIImage imageWithData:data];
                draggableView.imageHouse.contentMode = UIViewContentModeScaleAspectFit;
            }
       
    }
  
    draggableView.delegate = self;
    draggableView.information.text =photo.house.title;
    return draggableView;
}

-(void)loadCards
{
    if([houseCards count] > 0) {
        NSInteger numLoadedCardsCap =(([houseCards count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[houseCards count]);
        for (int i = 0; i<[houseCards count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                [loadedCards addObject:newCard];
            }
        }
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++;
        }
    }
}

-(void)cardSwipedLeft:(UIView *)card;
{
    [loadedCards removeObjectAtIndex:0];
    
    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    self.houseIndex++;
}

-(void)cardSwipedRight:(UIView *)card
{
    [loadedCards removeObjectAtIndex:0];
    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    self.houseIndex++;
}

-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
    self.houseIndex++;
}

-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
    self.houseIndex++;
}
@end
