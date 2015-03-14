//
//  TicketOrderListItem.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketOrderListItem.h"

@implementation TicketOrderListItem

+(NSArray *)getTicketOrderListItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    //"TICKETNUM": "121(142)120(0)119(0)" 普通 头等 特等
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        TicketOrderListItem * ci = [[TicketOrderListItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.orderId = [dic objectForKey:@"orderId"];
        ci.orderTime = [dic objectForKey:@"orderTime"];
        ci.orderStatus = [dic objectForKey:@"orderStatus"];

        [mArr addObject:ci];
    }
    return mArr;
}
@end
