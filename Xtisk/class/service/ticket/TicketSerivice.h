//
//  TicketSerivice.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShipLineItem.h"
#import "VoyageItem.h"
#import "TicketOrder.h"
@interface TicketSerivice : NSObject
{
    
}
@property(nonatomic,copy)NSArray *   allShipLines;  //所有的航线

@property(nonatomic,strong)ShipLineItem *tLine;

@property(nonatomic)int   ticketQueryType;//单程、往返

@property(nonatomic,copy)NSString *   fromPort;   //始发点
@property(nonatomic,copy)NSString *   toPort;   //目的地

@property(nonatomic,copy)NSString *   fromDate;   //去的日期
@property(nonatomic,copy)NSString *   returnDate;  //返回的日期


@property(nonatomic,strong)VoyageItem *toVoyageItem;
@property(nonatomic,strong)VoyageItem *returnVoyageItem;

@property(nonatomic,strong)NSMutableArray *   arrOrderSuc;  //下单成功的船票订单

@property(nonatomic,strong)NSDate *tMinDate;
@property(nonatomic,strong)NSDate *tMaxDate;

@property(nonatomic,strong)NSDateFormatter *ticketDateFormatter;


+(TicketSerivice *)sharedInstance;

-(void)clearData;

-(TicketOrder *)createTicketOrder;

-(float)calTickets:(VoyageItem *)tItme marr:(NSMutableArray *)mArrTickets;
@end
