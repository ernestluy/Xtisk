//
//  StatisTicketView.m
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "StatisTicketView.h"
#import "PublicDefine.h"
@implementation StatisTicketView

-(void)layoutUI{
    UIFont *tFont = [UIFont systemFontOfSize:14];
    int startX  = 60;
    int startY = 10;
    int labHeight = 20;
    int labWidth = 240;
    VoyageItem *toVoyage = [TicketSerivice sharedInstance].toVoyageItem;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
    lab.font = tFont;
    [self addSubview:lab];
    lab.text = [NSString stringWithFormat:@"航班信息:%@ TO %@",toVoyage.FROMPORT,toVoyage.TOPORT];
    startY += labHeight;
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
    lab.font = tFont;
    [self addSubview:lab];
    lab.text = [NSString stringWithFormat:@"开航时间:%@ %@",toVoyage.SETOFFDATE,toVoyage.SETOFFTIME];
    startY += labHeight;
    
    
    
    
    float toTotalPrice = 0.0;
    for (int i = 0; i<toVoyage.DTSEATRANKPRICE.count; i++) {
        SeatRankPrice *tmpSeat = [toVoyage.DTSEATRANKPRICE objectAtIndex:i];
        toTotalPrice += [tmpSeat.PRICE1 floatValue] * tmpSeat.orderNum1;
        toTotalPrice += [tmpSeat.PRICE2 floatValue] * tmpSeat.orderNum2;
        toTotalPrice += [tmpSeat.PRICE3 floatValue] * tmpSeat.orderNum3;
        
        
        
        if (tmpSeat.orderNum1 >0) {
            lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"%@ 成人 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum1];
            startY += labHeight;
        }
        if (tmpSeat.orderNum2 >0) {
            
            lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"%@ 长者 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum2];
            startY += labHeight;
        }
        if (tmpSeat.orderNum3 >0) {
            lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"%@ 小童 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum3];
            startY += labHeight;
        }
    }
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
    lab.font = tFont;
    [self addSubview:lab];
    lab.text = [NSString stringWithFormat:@"合计:￥%0.1f",toTotalPrice];
    startY += labHeight;
    
    
    if (TICKET_QUERY_RETURN == [TicketSerivice sharedInstance].ticketQueryType){
        startY += 5;
        
        toVoyage = [TicketSerivice sharedInstance].returnVoyageItem;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
        lab.font = tFont;
        [self addSubview:lab];
        lab.text = [NSString stringWithFormat:@"航班信息:%@ TO %@",toVoyage.FROMPORT,toVoyage.TOPORT];
        startY += labHeight;
        
        lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
        lab.font = tFont;
        [self addSubview:lab];
        lab.text = [NSString stringWithFormat:@"开航时间:%@ %@",toVoyage.SETOFFDATE,toVoyage.SETOFFTIME];
        startY += labHeight;
        
        
        
        
        float toTotalPrice = 0.0;
        for (int i = 0; i<toVoyage.DTSEATRANKPRICE.count; i++) {
            SeatRankPrice *tmpSeat = [toVoyage.DTSEATRANKPRICE objectAtIndex:i];
            toTotalPrice += [tmpSeat.PRICE1 floatValue] * tmpSeat.orderNum1;
            toTotalPrice += [tmpSeat.PRICE2 floatValue] * tmpSeat.orderNum2;
            toTotalPrice += [tmpSeat.PRICE3 floatValue] * tmpSeat.orderNum3;
            
            
            
            if (tmpSeat.orderNum1 >0) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
                lab.font = tFont;
                [self addSubview:lab];
                lab.text = [NSString stringWithFormat:@"%@ 成人 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum1];
                startY += labHeight;
            }
            if (tmpSeat.orderNum2 >0) {
                
                lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
                lab.font = tFont;
                [self addSubview:lab];
                lab.text = [NSString stringWithFormat:@"%@ 长者 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum2];
                startY += labHeight;
            }
            if (tmpSeat.orderNum3 >0) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
                lab.font = tFont;
                [self addSubview:lab];
                lab.text = [NSString stringWithFormat:@"%@ 小童 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum3];
                startY += labHeight;
            }
        }
        
        lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
        lab.font = tFont;
        [self addSubview:lab];
        lab.text = [NSString stringWithFormat:@"合计:￥%0.1f",toTotalPrice];
        startY += labHeight;
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, startY);
}

@end
