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
    
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIFont *tFont = [UIFont systemFontOfSize:14];
    int startX  = 40;
    if (TICKET_QUERY_ONE == [TicketSerivice sharedInstance].ticketQueryType){
        startX = 10;
    }
    
    int detailY = 8;
    int startY = detailY;
    int labHeight = 16;
    int labWidth = 240;
    self.backgroundColor = [UIColor whiteColor];
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
            lab.text = [NSString stringWithFormat:@"%@ 小童 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum2];
            startY += labHeight;
        }
        if (tmpSeat.orderNum3 >0) {
            lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"%@ 长者 %d张",tmpSeat.SEATRANK,tmpSeat.orderNum3];
            startY += labHeight;
        }
    }
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
    lab.font = tFont;
    [self addSubview:lab];
    lab.text = @"合计:";
    NSString *strValue = [NSString stringWithFormat:@"￥%0.1f",toTotalPrice];
    lab = [[UILabel alloc]initWithFrame:CGRectMake(startX + [lab.text sizeWithFont:lab.font].width + 5, startY, labWidth, labHeight)];
    lab.font = tFont;
    [self addSubview:lab];
    lab.text = strValue;
    lab.textColor = [UIColor redColor];
    startY += labHeight;
    
    
    if (TICKET_QUERY_RETURN == [TicketSerivice sharedInstance].ticketQueryType){
        UILabel *labQh = [[UILabel alloc]initWithFrame:CGRectMake(5, detailY, 30, startY - detailY)];
        labQh.backgroundColor = headerColor;
        labQh.text = @"启程";
        labQh.font = [UIFont systemFontOfSize:13];
        labQh.textColor = [UIColor whiteColor];
        labQh.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labQh];
    }
    
    if (TICKET_QUERY_RETURN == [TicketSerivice sharedInstance].ticketQueryType){
        startY += 5;
        int iScale= startY;
        
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
        lab.text = @"合计:";
        NSString *strValue = [NSString stringWithFormat:@"￥%0.1f",toTotalPrice];
        lab = [[UILabel alloc]initWithFrame:CGRectMake(startX + [lab.text sizeWithFont:lab.font].width + 5, startY, labWidth, labHeight)];
        lab.font = tFont;
        [self addSubview:lab];
        lab.text = strValue;
        lab.textColor = [UIColor redColor];
        startY += labHeight;
        
        {
            UILabel *labQh = [[UILabel alloc]initWithFrame:CGRectMake(5, iScale, 30, startY - iScale)];
            labQh.backgroundColor = headerColor;
            labQh.text = @"返程";
            labQh.font = [UIFont systemFontOfSize:13];
            labQh.textColor = [UIColor whiteColor];
            labQh.textAlignment = NSTextAlignmentCenter;
            [self addSubview:labQh];
        }
    }
    
    startY += 8;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, startY);
}

-(void)layoutWithCode:(NSString *)code{
    
    
    [self layoutUI];
}

@end
