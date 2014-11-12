
#import "MessagesViewController.h"
#import "InboxMessageTableViewCell.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "Message.h"

@interface MessagesViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *messages;
@property (strong, nonatomic) IBOutlet UIButton *folderButton;
@property (strong, nonatomic) IBOutlet UILabel *folderLabel;
@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)changeFolder:(id)sender {
    if (self.inbox) {
        MessagesViewController *vc = [[MessagesViewController alloc] init];
        vc.inbox = NO;
        [self showViewController:vc sender:self];

    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
   
}
- (void)loadMessages {
    PFQuery *messagesQuery = [Message query];
    if (self.inbox) {
        [messagesQuery whereKey:@"receiver" equalTo:[PFUser currentUser]];

    } else {
        [messagesQuery whereKey:@"sender" equalTo:[PFUser currentUser]];
    }
    
    [messagesQuery orderByDescending:@"date"];
    [messagesQuery findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        if(error){
            NSLog(@"Error: %@",error);
        }else{
            self.messages= messages;
            [self.tableView reloadData];
        }
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadMessages];
    if (self.inbox) {
        [self.folderButton setTitle:@"Go to sent" forState:UIControlStateNormal];
        self.folderLabel.text = @"Received messages";
        
    } else {
        [self.folderButton setTitle:@"Go to inbox" forState:UIControlStateNormal];
        self.folderLabel.text = @"Sent messages";
    }

    
}
#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InboxMessageTableViewCell *cell = (InboxMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"InboxMessageCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"InboxMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"InboxMessageCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"InboxMessageCell"];
    }
    Message * message = self.messages[indexPath.row];
    
    cell.message.text =message.subject;
    
    [cell.message sizeToFit];
    
    NSDate *theDate = message.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"HH:mm a"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeString = [formatter stringFromDate:theDate];
    cell.date.text = timeString;
    
    
    if(!message.readed){
        cell.date.font = [UIFont boldSystemFontOfSize:17.0];
        cell.message.font = [UIFont boldSystemFontOfSize:17.0];
    }
    else
    {
        cell.date.font = [UIFont systemFontOfSize:17.0];
        cell.message.font = [UIFont systemFontOfSize:17.0];

    }
    return cell;
}
/*
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSString *cellText = [[chatData objectAtIndex:chatData.count-indexPath.row-1] objectForKey:@"text"];
 UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
 CGSize constraintSize = CGSizeMake(225.0f, MAXFLOAT);
 CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
 
 return labelSize.height + 40;
 }
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}
@end
