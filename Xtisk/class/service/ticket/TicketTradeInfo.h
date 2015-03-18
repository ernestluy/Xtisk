//
//  TicketTradeInfo.h
//  Xtisk
//
//  Created by zzt on 15/3/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketTradeInfo : NSObject

@property(nonatomic,copy)NSString *tn;
@property(nonatomic,copy)NSString *orderId;

+(TicketTradeInfo *)getTicketTradeInfoWithDic:(NSDictionary *)dic;
@end
