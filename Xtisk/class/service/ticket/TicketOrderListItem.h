//
//  TicketOrderListItem.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TicketStatusPayYes      @"已支付"
#define TicketStatusPayNo       @"未支付"
#define TicketStatusPayExpire   @"已过期"
@interface TicketOrderListItem : NSObject
@property(nonatomic)int orderId;
@property(nonatomic,copy)NSString *orderTime;
@property(nonatomic,copy)NSString *orderStatus;

@property(nonatomic)int status;
@property(nonatomic,copy)NSString *tn;
//@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *name;

+(NSArray *)getTicketOrderListItemsWithArr:(NSArray *)arr;
@end
