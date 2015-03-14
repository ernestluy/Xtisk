//
//  TicketSerivice.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketSerivice.h"
#import "PublicDefine.h"
static TicketSerivice *instanceTicketService = nil;
@implementation TicketSerivice


+(TicketSerivice *)sharedInstance{
    if (!instanceTicketService) {
        @synchronized([TicketSerivice class]){
            if (!instanceTicketService) {
                instanceTicketService = [[TicketSerivice alloc] init];
            }
        }
    }
    return instanceTicketService;
}

-(TicketOrder *)createTicketOrder{
    TicketOrder *order = [[TicketOrder alloc]init];
    NSMutableArray *mArrTickets = [NSMutableArray array];
    VoyageItem *tItme = self.toVoyageItem;
    float fTotal = 0;
    fTotal += [self calTickets:tItme marr:mArrTickets];
    VoyageItem *rItme = self.returnVoyageItem;
    fTotal += [self calTickets:rItme marr:mArrTickets];
    order.total_fee = fTotal;
    order.discount_fee = 0;
    order.arrTickets = [TicketInfoItem getJsonArrayWithArray:mArrTickets];
    order.tickets = [Util getJsonStrWithObj:order.arrTickets];
    return order;
}

-(float)calTickets:(VoyageItem *)tItme marr:(NSMutableArray *)mArrTickets{
    float fTotalPrice = 0;
    for (int i = 0; i<tItme.DTSEATRANKPRICE.count; i++) {
        SeatRankPrice *tmpSeat = [tItme.DTSEATRANKPRICE objectAtIndex:i];
        fTotalPrice += [tmpSeat.PRICE1 floatValue] * tmpSeat.orderNum1;
        fTotalPrice += [tmpSeat.PRICE2 floatValue] * tmpSeat.orderNum2;
        fTotalPrice += [tmpSeat.PRICE3 floatValue] * tmpSeat.orderNum3;
        
        for (int i = 0; i<tmpSeat.orderNum1; i++) {
            TicketInfoItem *infoItem = [[TicketInfoItem alloc]init];
            infoItem.seatrank_id = tmpSeat.SEATRANKID;
            infoItem.price = [tmpSeat.PRICE1 floatValue];
            infoItem.detailid = tmpSeat.DETAIL1;
            infoItem.voyagerouteid = tmpSeat.VOYAGEROUTEID;
            infoItem.clienttype = @"1";
            infoItem.shipName = tItme.SHIP;
            infoItem.shipStartTime = [NSString stringWithFormat:@"%@ %@",tItme.SETOFFDATE,tItme.SETOFFTIME];
            infoItem.shipping_line = [NSString stringWithFormat:@"%@ TO %@",tItme.FROMPORT,tItme.TOPORT];
            [mArrTickets addObject:infoItem];
        }
        for (int i = 0; i<tmpSeat.orderNum2; i++) {
            TicketInfoItem *infoItem = [[TicketInfoItem alloc]init];
            infoItem.seatrank_id = tmpSeat.SEATRANKID;
            infoItem.price = [tmpSeat.PRICE2 floatValue];
            infoItem.detailid = tmpSeat.DETAIL2;
            infoItem.voyagerouteid = tmpSeat.VOYAGEROUTEID;
            infoItem.clienttype = @"2";
            infoItem.shipName = tItme.SHIP;
            infoItem.shipStartTime = [NSString stringWithFormat:@"%@ %@",tItme.SETOFFDATE,tItme.SETOFFTIME];
            infoItem.shipping_line = [NSString stringWithFormat:@"%@ TO %@",tItme.FROMPORT,tItme.TOPORT];
            [mArrTickets addObject:infoItem];
        }
        for (int i = 0; i<tmpSeat.orderNum3; i++) {
            TicketInfoItem *infoItem = [[TicketInfoItem alloc]init];
            infoItem.seatrank_id = tmpSeat.SEATRANKID;
            infoItem.price = [tmpSeat.PRICE3 floatValue];
            infoItem.detailid = tmpSeat.DETAIL3;
            infoItem.voyagerouteid = tmpSeat.VOYAGEROUTEID;
            infoItem.clienttype = @"3";
            infoItem.shipName = tItme.SHIP;
            infoItem.shipStartTime = [NSString stringWithFormat:@"%@ %@",tItme.SETOFFDATE,tItme.SETOFFTIME];
            infoItem.shipping_line = [NSString stringWithFormat:@"%@ TO %@",tItme.FROMPORT,tItme.TOPORT];
            [mArrTickets addObject:infoItem];
        }
        
        
    }
    return fTotalPrice;
}

@end
