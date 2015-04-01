//
//  VoyageItem.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "VoyageItem.h"
#import "SeatRankPrice.h"
#import "TicketSerivice.h"
@implementation VoyageItem

-(id)init{
    self = [super init];
    
    self.mArrTicketId =[NSMutableArray array];
    self.mArrTicketNums = [NSMutableArray array];
    return self;
}

-(void)clearData{
    for (int i = 0; i<self.DTSEATRANKPRICE.count; i++) {
        SeatRankPrice *sitem = [self.DTSEATRANKPRICE objectAtIndex:i];
        [sitem clearData];
        if (0 == i) {
            sitem.orderNum1 = 1;
        }
    }
}

+(NSArray *)getVoyageItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    //"TICKETNUM": "121(142)120(0)119(0)" 普通 头等 特等
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        VoyageItem * ci = [[VoyageItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.FROMPORT = [dic objectForKey:@"FROMPORT"];
        ci.TOPORT = [dic objectForKey:@"TOPORT"];
        ci.FPORTCODE = [dic objectForKey:@"FPORTCODE"];
        ci.TPORTCODE = [dic objectForKey:@"TPORTCODE"];
        ci.SHIP = [dic objectForKey:@"SHIP"];
        ci.SHIPCODE = [dic objectForKey:@"SHIPCODE"];
        ci.SETOFFTIME = [dic objectForKey:@"SETOFFTIME"];
        ci.SETOFFDATE = [dic objectForKey:@"SETOFFDATE"];
        ci.LINECODE = [dic objectForKey:@"LINECODE"];
        ci.VOYAGEROUTE_ID = [dic objectForKey:@"VOYAGEROUTE_ID"];
        ci.TICKETNUM = [dic objectForKey:@"TICKETNUM"];
        
        [ci setTicketLevelNum];
        
        NSDictionary *tmpDic = [dic objectForKey:@"DTSEATRANKPRICE"];
        //ROW
        NSObject *tmpObject = [tmpDic objectForKey:@"ROW"];
        if ([tmpObject isKindOfClass:[NSDictionary class]]) {
            ci.DTSEATRANKPRICE = [SeatRankPrice getSeatRankPricesWithArr:@[tmpObject]];
        }else{
            NSArray *tmpArr = [tmpDic objectForKey:@"ROW"];
            if (tmpArr && tmpArr.count>0) {
                ci.DTSEATRANKPRICE = [SeatRankPrice getSeatRankPricesWithArr:tmpArr];
            }
        }
        
        
        
        [mArr addObject:ci];
    }
    return mArr;
}

-(void)setTicketLevelNum{
    ////"TICKETNUM": "121(142)120(0)119(0)" 普通 头等 特等
    if (self.TICKETNUM && self.TICKETNUM.length>0) {
        NSArray *fLevel = [self.TICKETNUM componentsSeparatedByString:@")"];
        for (int i = 0; i<fLevel.count; i++) {
            NSArray *sLevel = [[fLevel objectAtIndex:i] componentsSeparatedByString:@"("];
            
            if (sLevel.count>1) {
                [self.mArrTicketId addObject:[sLevel objectAtIndex:0]];
                [self.mArrTicketNums addObject:[sLevel objectAtIndex:1]];
//                [self.mArrTicketId addObject:[sLevel objectAtIndex:0]];
//                [self.mArrTicketNums addObject:@"20"];
                if (0 == i) {
                    self.ticketNum1 = [[sLevel objectAtIndex:1] intValue];
                }else if (1 == i) {
                    self.ticketNum2 = [[sLevel objectAtIndex:1] intValue];
                }else if (2 == i) {
                    self.ticketNum3 = [[sLevel objectAtIndex:1] intValue];
                }
            }
        }
    }
}

+(int)compare:(VoyageItem *)fitem sitem:(VoyageItem *)sitem{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *fDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",fitem.SETOFFDATE,fitem.SETOFFTIME]];
    NSDate *sDate= [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",sitem.SETOFFDATE,sitem.SETOFFTIME]];
    NSComparisonResult r = [fDate compare:sDate];
    
    return r;
}

/*
 {
 "code": 0,
 "msg": "成功",
 "data": {
 "VOYAGE": {
 "FPORTCODE": "SK",
 "SHIPCODE": "PX",
 "VOYAGEROUTE_ID": "42111214",
 "SHIP": "鹏星",
 "FROMPORT": "蛇口港",
 "TPORTCODE": "HKM",
 "SETOFFDATE": "2015-03-11",
 "TICKETNUM": "121(146)120(0)119(0)",
 "SETOFFTIME": "19:15",
 "TOPORT": "香港港澳码头",
 "LINECODE": "SK-HKM",
 "DTSEATRANKPRICE": {
 "ROW": [
 {
 "PRICE3": "70",
 "DETAIL3": "28633657",
 "PRICE4": "NULL",
 "DETAIL4": "0",
 "PRICE1": "120",
 "DETAIL1": "28633636",
 "PRICE2": "70",
 "DETAIL2": "28633652",
 "STANDARDPRICE2": "70",
 "STANDARDPRICE3": "70",
 "STANDARDPRICE1": "120",
 "VOYAGEROUTEID": "42111214",
 "SEATRANK": "普通位",
 "SEATRANKID": "121",
 "STANDARDPRICE4": "NULL"
 },
 {
 "PRICE3": "NULL",
 "DETAIL3": "0",
 "PRICE4": "NULL",
 "DETAIL4": "0",
 "PRICE1": "150",
 "DETAIL1": "28633661",
 "PRICE2": "NULL",
 "DETAIL2": "0",
 "STANDARDPRICE2": "NULL",
 "STANDARDPRICE3": "NULL",
 "STANDARDPRICE1": "150",
 "VOYAGEROUTEID": "42111214",
 "SEATRANK": "头等位",
 "SEATRANKID": "120",
 "STANDARDPRICE4": "NULL"
 }
 ]
 }
 }
 }
 }
*/
@end
