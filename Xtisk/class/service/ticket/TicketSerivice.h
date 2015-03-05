//
//  TicketSerivice.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TicketSerivice : NSObject
{
    
}
@property(nonatomic)int   ticketQueryType;

+(TicketSerivice *)sharedInstance;
@end
