//
//  MyTicketOrderDetail.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketOrderDetail.h"

@implementation MyTicketOrderDetail

/*
 {
 "peopleInfo": {
 "phone": "13418884362",
 "address": "none",
 "email": "175640827@163.com",
 "identity_card": "234",
 "name": "卢一"
 },
 "ticketList": [
 {
 "price": 120,
 "ticketPosition": "普通位",
 "type": "1",
 "ticketInfo": "蛇口港 TO 香港港澳码头",
 "ticketTime": "2015-03-17 09:00",
 "getId": "1031448174"
 },
 {
 "price": 70,
 "ticketPosition": "普通位",
 "type": "2",
 "ticketInfo": "蛇口港 TO 香港港澳码头",
 "ticketTime": "2015-03-17 09:00",
 "getId": "1031448174"
 }
 ],
 "orderTime": "2015-03-16 19:21",
 "orderStatus": "等待买家付款",
 "orderId": 701
 }
 */
+(MyTicketOrderDetail *)getMyTicketOrderDetailWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    MyTicketOrderDetail * detail = [[MyTicketOrderDetail alloc]init];
    detail.orderId = [[dic objectForKey:@"orderId"]intValue];;
    detail.orderTime = [dic objectForKey:@"orderTime"];
    detail.orderStatus = [dic objectForKey:@"orderStatus"];
    
    detail.status = [[dic objectForKey:@"status"] intValue];
    detail.tn = [dic objectForKey:@"tn"];
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
