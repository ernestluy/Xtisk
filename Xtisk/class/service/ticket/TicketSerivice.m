//
//  TicketSerivice.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketSerivice.h"
static TicketSerivice *instanceTicketService = nil;
@implementation TicketSerivice


+(TicketSerivice *)sharedInstance{
    if (!instanceTicketService) {
        @synchronized([TicketSerivice class]){
            if (!instanceTicketService) {
                instanceTicketService = [[TicketSerivice alloc] init];
            }
        }
    }
    return instanceTicketService;
}
@end
