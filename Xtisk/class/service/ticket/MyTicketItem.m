//
//  MyTicketItem.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketItem.h"

@implementation MyTicketItem


+(NSArray *)getMyTicketItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        MyTicketItem * ci = [[MyTicketItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.ticketTime = [dic objectForKey:@"ticketTime"];
        ci.ticketInfo = [dic objectForKey:@"ticketInfo"];
        ci.ticketPosition = [dic objectForKey:@"ticketPosition"];
        ci.type = [dic objectForKey:@"type"];
        ci.price = [[dic objectForKey:@"price"] floatValue];
        ci.getId = [dic objectForKey:@"getId"];
        
        [mArr addObject:ci];
    }
    return mArr;
}
@end
