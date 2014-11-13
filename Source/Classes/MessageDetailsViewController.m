//
//  MessageDetailsViewController.m
//  HomeLess
//
//  Created by Guillermo Apoj on 11/12/14.
//
//

#import "HomeViewController.h"
#import "MessageDetailsViewController.h"
#import "SendMessageViewController.h"

@interface MessageDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *responseButton;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *otherUserLabel;
@property (strong, nonatomic) IBOutlet UILabel *HouseLabel;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UILabel *sentToOrSentByLabel;
@property NSArray *history;
@end

@implementation MessageDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.HouseLabel.text = self.message.houseRelated.title;
    if ([self.message.sender.objectId isEqualToString:[PFUser currentUser].objectId]) {
        self.responseButton.hidden = YES;
        self.sentToOrSentByLabel.text =@"Sent to:";
        self.otherUserLabel.text= self.message.receiver.username;
    } else {
         self.responseButton.hidden = NO;
        self.sentToOrSentByLabel.text =@"Sent by:";
         self.otherUserLabel.text= self.message.sender.username;
        if(!self.message.readed){
            self.message.readed = YES;
            [self.message saveInBackground];
        }
    }
    
    self.messageTextView.text = self.message.message;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 100;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onResponse:(id)sender {
    SendMessageViewController *vc =[[SendMessageViewController alloc]init];
    vc.relatedHouse = self.message.houseRelated;
    vc.previousMessage = self.message;
    [self showViewController:vc sender:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoricalInboxTableViewCell *cell = (HistoricalInboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"HistoricalInboxCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"HistoricalInboxTableViewCell" bundle:nil] forCellReuseIdentifier:@"HistoricalInboxCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"HistoricalInboxCell"];
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Message History:";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
- (HistoricalInboxTableViewCell *)createInboxCell:(UITableView *)tableView message:(Message *)message
{
    HistoricalInboxTableViewCell *cell = (HistoricalInboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"InboxMessageCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"InboxMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"InboxMessageCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"InboxMessageCell"];
    }
    
    cell.message.text =message.subject;
    
    [cell.message sizeToFit];
    
    NSDate *theDate =[message getLocalTimeDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"HH:mm a"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeString = [formatter stringFromDate:theDate];
    cell.date.text = timeString;
    
    
    if(!message.readed){
        cell.date.font = [UIFont boldSystemFontOfSize:10.0];
        cell.message.font = [UIFont boldSystemFontOfSize:13.0];
    }
    else
    {
        cell.date.font = [UIFont systemFontOfSize:10.0];
        cell.message.font = [UIFont systemFontOfSize:13.0];
        
    }
    return cell;
}
@end
