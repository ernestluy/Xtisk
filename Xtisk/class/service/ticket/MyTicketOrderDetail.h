//
//  MyTicketOrderDetail.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketOrderListItem.h"
#import "PeopleInfo.h"
#import "MyTicketItem.h"
@interface MyTicketOrderDetail : TicketOrderListItem


@property(nonatomic,strong)PeopleInfo *peopleInfo;
@property(nonatomic,strong)NSArray *ticketList;
+(MyTicketOrderDetail *)getMyTicketOrderDetailWithDic:(NSDictionary *)dic;
+(MyTicketOrderDetail *)createMyTicketOrderDetailWithPerant:(TicketOrderListItem*)item;
@end
