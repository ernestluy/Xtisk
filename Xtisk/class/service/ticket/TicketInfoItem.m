//
//  TicketInfoItem.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketInfoItem.h"

@implementation TicketInfoItem


+(NSDictionary *)getJsonDicWithTicketInfoItem:(TicketInfoItem *)item{
    NSDictionary *dic = [NSMutableDictionary dictionary];
    if (!item) {
        return dic;
    }
    [dic setValue:item.seatrank_id forKey:@"seatrank_id"];
    [dic setValue:[NSNumber numberWithFloat:item.price] forKey:@"price"];
    [dic setValue:item.detailid forKey:@"detailid"];
    [dic setValue:item.voyagerouteid forKey:@"voyagerouteid"];
    [dic setValue:item.clienttype forKey:@"clienttype"];
    [dic setValue:item.shipName forKey:@"shipName"];
//    [dic setValue:item.shipStartTime forKey:@"shipStartTime"];
    [dic setValue:item.shipStartTime forKey:@"departure_time"];
    [dic setValue:item.shipping_line forKey:@"shipping_line"];
    
    return dic;
}
+(NSArray *)getJsonArrayWithArray:(NSArray*)arr{
    NSMutableArray *mArr = [NSMutableArray array];
    if (!arr) {
        return mArr;
    }
    for (int i = 0; i<arr.count; i++) {
        TicketInfoItem *item = [arr objectAtIndex:i];
        [mArr addObject:[TicketInfoItem getJsonDicWithTicketInfoItem:item]];
    }
    
    return mArr;
}
@end
