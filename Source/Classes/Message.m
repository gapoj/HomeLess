//
//  Message.m
//  HomeLess
//
//  Created by Guillermo Apoj on 11/11/14.
//
//

#import "Message.h"

@implementation Message
@dynamic  subject;
@dynamic  message;
@dynamic  sender;
@dynamic  receiver;
@dynamic  houseRelated;
@dynamic  readed;
@dynamic  conversationID;
@dynamic  date;
@dynamic  numberInConversation;
+ (NSString*) parseClassName
{
    return @"Message";
}

+(void) load
{
    [self registerSubclass];
}
@end
