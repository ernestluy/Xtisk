//
//  ShipLineItem.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ShipLineItem.h"

@implementation ShipLineItem



+(NSArray *)getShipLineItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        ShipLineItem * ci = [[ShipLineItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.FROMPORTENAME = [dic objectForKey:@"FROMPORTENAME"];
        ci.FROMPORTCODE = [dic objectForKey:@"FROMPORTCODE"];
        ci.FROMPORTTNAME = [dic objectForKey:@"FROMPORTTNAME"];
        ci.FROMPORTCNAME = [dic objectForKey:@"FROMPORTCNAME"];
        ci.ISAIRPORTLINE = [dic objectForKey:@"ISAIRPORTLINE"];
        ci.TOPORTCODE = [dic objectForKey:@"TOPORTCODE"];
        ci.TOPORTENAME = [dic objectForKey:@"TOPORTENAME"];
        ci.TOPORTCNAME = [dic objectForKey:@"TOPORTCNAME"];
        ci.LINECODE = [dic objectForKey:@"LINECODE"];
        
        
        [mArr addObject:ci];
    }
    return mArr;
}
@end
