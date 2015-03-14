//
//  MyTicketItem.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTicketItem : NSObject
@property(nonatomic,copy)NSString *ticketTime;
@property(nonatomic,copy)NSString *ticketInfo;
@property(nonatomic,copy)NSString *ticketPosition;//String	否	舱位（普通、经济、贵宾）
@property(nonatomic,copy)NSString *type;//String	否	船票类别（成人、儿童）
@property(nonatomic)float price;//Double	否	票价
@property(nonatomic,copy)NSString *getId;//String	否	取票编号


+(NSArray *)getMyTicketItemsWithArr:(NSArray *)arr;
@end
