//
//  VoyageItem.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
//4.3.5.2获取航程信息
@interface VoyageItem : NSObject

@property(nonatomic,copy)NSString *FROMPORT;//	String	否	始发港名
@property(nonatomic,copy)NSString *TOPORT;//	String	否	目的港名
@property(nonatomic,copy)NSString *FPORTCODE;//	String	否	始发港代码
@property(nonatomic,copy)NSString *TPORTCODE;//	String	否	目的港代码
@property(nonatomic,copy)NSString *SHIP;//	String	是	船名
@property(nonatomic,copy)NSString *SHIPCODE;//	String	是	船代码
@property(nonatomic,copy)NSString *SETOFFDATE;//	String	否	开航日期，日期格式：yyyy-mm-dd
@property(nonatomic,copy)NSString *SETOFFTIME;//	String	否	开航时间，格式：hh24:mi
@property(nonatomic,copy)NSString *LINECODE;//	Stirng	否	航线代码
@property(nonatomic,copy)NSString *VOYAGEROUTE_ID;//	String	否	航程ID
@property(nonatomic,copy)NSString *TICKETNUM;//	Int	否	可售票数，格式为:座位等级ID(可售票数);例如  131(23)132(1) 即为:座位等级ID为131的等级,可售票数为23,座位等级ID为132的等级,可售票数为1
@property(nonatomic,copy)NSArray *DTSEATRANKPRICE;//	Json Array	否	座位等级票价表


@property(nonatomic)int ticketNum1;
@property(nonatomic)int ticketNum2;
@property(nonatomic)int ticketNum3;

@property(nonatomic,strong)NSMutableArray *mArrTicketId;
@property(nonatomic,strong)NSMutableArray *mArrTicketNums;

-(void)clearData;

+(NSArray *)getVoyageItemsWithArr:(NSArray *)arr;

+(int)compare:(VoyageItem *)fitem sitem:(VoyageItem *)sitem;
@end
