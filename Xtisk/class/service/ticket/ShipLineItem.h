//
//  ShipLineItem.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
//4.3.5.1获取航线
@interface ShipLineItem : NSObject

@property(nonatomic,copy)NSString *FROMPORTENAME;//	String	否	始发港英文名
@property(nonatomic,copy)NSString *FROMPORTCODE;//	String	否	始发港代码
@property(nonatomic,copy)NSString *FROMPORTTNAME;//	String	否	始发港繁体名
@property(nonatomic,copy)NSString *FROMPORTCNAME;//	String	否	始发港简体名
@property(nonatomic,copy)NSString *ISAIRPORTLINE;//	String	否	是否为机场航线：0是，1不是
@property(nonatomic,copy)NSString *TOPORTCODE;//	String	否	目的港代码
@property(nonatomic,copy)NSString *TOPORTENAME;//	String	否	目的港英文名
@property(nonatomic,copy)NSString *TOPORTCNAME;//	String	否	目的港简体名
@property(nonatomic,copy)NSString *LINECODE;//	Stirng	否	航线代码
//@property(nonatomic,copy)NSString *serviceTitle;

+(NSArray *)getShipLineItemsWithArr:(NSArray *)arr;
@end
