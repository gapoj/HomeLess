
#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;
- (void)loadData;
@property (retain,nonatomic)NSArray* houseCards;
@property (retain,nonatomic)NSMutableArray* allCards; 

@property NSInteger houseIndex;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
