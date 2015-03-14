//
//  MyTicketOrderDetail.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketOrderDetail.h"

@implementation MyTicketOrderDetail


+(MyTicketOrderDetail *)getMyTicketOrderDetailWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    MyTicketOrderDetail * detail = [[MyTicketOrderDetail alloc]init];
    detail.orderId = [dic objectForKey:@"orderId"];
    detail.orderTime = [dic objectForKey:@"orderTime"];
    detail.orderStatus = [dic objectForKey:@"orderStatus"];
    detail.peopleInfo = [PeopleInfo getPeopleInfoWithDic:[dic objectForKey:@"peopleInfo"]];
    detail.ticketList = [MyTicketItem getMyTicketItemsWithArr:[dic objectForKey:@"ticketList"]];
    
    return detail;
}

+(MyTicketOrderDetail *)createMyTicketOrderDetailWithPerant:(TicketOrderListItem*)item{
    MyTicketOrderDetail * detail = [[MyTicketOrderDetail alloc]init];
    detail.orderId = item.orderId;
    detail.orderTime = item.orderTime;
    detail.orderStatus = item.orderStatus;
    return detail;
}
@end
