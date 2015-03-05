//
//  TicketInfoItem.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketInfoItem : NSObject

@property(nonatomic,copy)NSString *seatrank_id;//	String	否	座位等级ID
@property(nonatomic)float price;//	Double	否	价格
@property(nonatomic,copy)NSString *detailid;//	String	否	价格ID
@property(nonatomic,copy)NSString *voyagerouteid;//	String	否	航程ID
@property(nonatomic,copy)NSString *clienttype;//	String	否	客户类型  1-(成人) ,2-(小孩),3-(长者),4-(婴儿)
@property(nonatomic,copy)NSString *shipName;//	String	否	船名
@property(nonatomic,copy)NSString *shipStartTime;//	String	否	起航时间
//@property(nonatomic,copy)NSString *serviceTitle;
//@property(nonatomic,copy)NSString *serviceTitle;

+(NSDictionary *)getJsonDicWithTicketInfoItem:(TicketInfoItem *)item;
+(NSArray *)getJsonArrayWithArray:(NSArray*)arr;
@end
