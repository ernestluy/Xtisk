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
        ci.TICKETNUM = [[dic objectForKey:@"TICKETNUM"] intValue];
        
        NSArray *tmpArr = [dic objectForKey:@"DTSEATRANKPRICE"];
        
        if (tmpArr && tmpArr.count>0) {
            ci.DTSEATRANKPRICE = [SeatRankPrice getSeatRankPricesWithArr:tmpArr];
        }
        
        [mArr addObject:ci];
    }
    return mArr;
}
@end
