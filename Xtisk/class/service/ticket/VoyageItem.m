//
//  VoyageItem.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "VoyageItem.h"
#import "SeatRankPrice.h"
@implementation VoyageItem


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
        ci.LINECODE = [dic objectForKey:@"LINECODE"];
        ci.LINECODE = [dic objectForKey:@"LINECODE"];
        ci.VOYAGEROUTE_ID = [dic objectForKey:@"VOYAGEROUTE_ID"];
        ci.TICKETNUM = [dic objectForKey:@"TICKETNUM"];
        
        [ci setTicketLevelNum];
        
        NSDictionary *tmpDic = [dic objectForKey:@"DTSEATRANKPRICE"];
        //ROW
        NSArray *tmpArr = [tmpDic objectForKey:@"ROW"];
        if (tmpArr && tmpArr.count>0) {
            ci.DTSEATRANKPRICE = [SeatRankPrice getSeatRankPricesWithArr:tmpArr];
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
@end
