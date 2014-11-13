//
//  MessageDetailsViewController.m
//  HomeLess
//
//  Created by Guillermo Apoj on 11/12/14.
//
//
#import "OutBoxTableViewCell.h"
#import "InboxMessageTableViewCell.h"
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
    return 1;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
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
@end
