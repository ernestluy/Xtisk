//
//  SeatRankPrice.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatRankPrice : NSObject

@property(nonatomic,copy)NSString *VOYAGEROUTEID;//	String	否	航程ID
@property(nonatomic,copy)NSString *SEATRANKID;//	String 	否	座位等级ID
@property(nonatomic,copy)NSString *SEATRANK;//	String	否	座位等级名
@property(nonatomic)float PRICE1;//	Double	否	成人票价
@property(nonatomic)float PRICE2;//	Double	否	小童票价
@property(nonatomic)float PRICE3;//	Double	否	长者票价
@property(nonatomic)float PRICE4;//	Double	否	婴儿票价
@property(nonatomic,copy)NSString *DETAIL1;//	String	是	成人票价ID
@property(nonatomic,copy)NSString *DETAIL2;//	String	是	小童票价ID
@property(nonatomic,copy)NSString *DETAIL3;//	String	是	长者票价ID
@property(nonatomic,copy)NSString *DETAIL4;//	String	是	婴儿票价ID


+(NSArray *)getSeatRankPricesWithArr:(NSArray *)arr;
@end