//
//  SeatRankPrice.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SeatRankPrice.h"

@implementation SeatRankPrice

-(id)init{
    self = [super init];
    self.orderNum1 = 0;
    self.orderNum2 = 0;
    self.orderNum3 = 0;
    return self;
}

-(void)clearData{
    
    self.orderNum1 = 0;
    self.orderNum2 = 0;
    self.orderNum3 = 0;
}

+(NSArray *)getSeatRankPricesWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        SeatRankPrice * ci = [[SeatRankPrice alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.VOYAGEROUTEID = [dic objectForKey:@"VOYAGEROUTEID"];
        ci.SEATRANKID = [dic objectForKey:@"SEATRANKID"];
        ci.SEATRANK = [dic objectForKey:@"SEATRANK"];
        ci.PRICE1 = [dic objectForKey:@"PRICE1"];//[[dic objectForKey:@"PRICE1"] floatValue];
        ci.PRICE2 = [dic objectForKey:@"PRICE2"];//[[dic objectForKey:@"PRICE2"] floatValue];
        ci.PRICE3 = [dic objectForKey:@"PRICE3"];//[[dic objectForKey:@"PRICE3"] floatValue];
        ci.PRICE4 = [dic objectForKey:@"PRICE4"];//[[dic objectForKey:@"PRICE4"] floatValue];
        ci.DETAIL1 = [dic objectForKey:@"DETAIL1"];
        ci.DETAIL2 = [dic objectForKey:@"DETAIL2"];
        ci.DETAIL3 = [dic objectForKey:@"DETAIL3"];
        ci.DETAIL4 = [dic objectForKey:@"DETAIL4"];
        [mArr addObject:ci];
    }
    return mArr;
}
@end
