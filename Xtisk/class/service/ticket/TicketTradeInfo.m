//
//  TicketTradeInfo.m
//  Xtisk
//
//  Created by zzt on 15/3/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketTradeInfo.h"

@implementation TicketTradeInfo

+(TicketTradeInfo *)getTicketTradeInfoWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    TicketTradeInfo *info = [[TicketTradeInfo alloc]init];
    info.tn = [dic objectForKey:@"tn"];
    info.orderId = [dic objectForKey:@"orderId"];
    
    return info;
}
@end
