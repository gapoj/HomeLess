
#import "DraggableViewBackground.h"
#import "DetailsHouseViewController.h"

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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        houseCards = [self loadHouseCards];
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        [self loadCards];
        self.houseIndex = 0;
    }
    return self;
}

-(NSArray *) loadHouseCards
{
    return [[NSArray alloc]initWithObjects:@"house1",@"house2",@"house3",@"house4",@"house5",@"house1",@"house2",@"house3",@"house4",@"house5", nil];
}

-(void)setupView
{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1];
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 415, 59, 59)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(185, 415, 59, 59)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(30, 100, CARD_WIDTH, CARD_HEIGHT)];
    draggableView.imageHouse.image = [UIImage imageNamed:[houseCards objectAtIndex:index]];
    draggableView.delegate = self;
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
