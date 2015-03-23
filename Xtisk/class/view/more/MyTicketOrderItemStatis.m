//
//  MyTicketOrderItemStatis.m
//  Xtisk
//
//  Created by zzt on 15/3/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketOrderItemStatis.h"
#import "ColorTools.h"
@implementation MyTicketOrderItemStatis

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setData:(MyTicketOrderDetail *)order{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIFont *tFont = [UIFont systemFontOfSize:13];
    int startX  = 40;
    
    int inset = 15;
    startX = inset;
    
    int detailY = 8;
    int startY = detailY;
    int labHeight = 16;
    int labWidth = 240;

    NSMutableArray *mLineArr = [NSMutableArray array];
    for (int i = 0; i<order.ticketList.count; i++) {
        MyTicketItem *ticket = [order.ticketList objectAtIndex:i];
        if (![mLineArr containsObject:ticket.ticketInfo]) {
            [mLineArr addObject:ticket.ticketInfo];
        }
        NSNumber *num = [mDic objectForKey:ticket.keyTicket];
        if (num) {
            int iNum = [num intValue];
            [mDic setObject:[NSNumber numberWithInt:(1 + iNum)] forKey:ticket.keyTicket];
        }else{
            [mDic setObject:[NSNumber numberWithInt:(1)] forKey:ticket.keyTicket];
        }
    }
    if (mLineArr.count == 2) {//有往返程
        startX = inset + 30;
    }
    
    NSMutableDictionary *mEdDic = [NSMutableDictionary dictionary];
    NSString *tLineTitle = nil;
    int iScale = startY;
    float fTotal = 0;
    order.totalPrice = 0;
    for (int i = 0; i<order.ticketList.count; i++) {
        MyTicketItem *ticket = [order.ticketList objectAtIndex:i];
        if (!tLineTitle || ![tLineTitle isEqualToString:ticket.ticketInfo]) {
            if (fTotal != 0) {
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
                lab.font = tFont;
                [self addSubview:lab];
                lab.text = @"合计:";
                order.totalPrice += fTotal;
                NSString *strValue = [NSString stringWithFormat:@"￥%0.1f",fTotal];
                lab = [[UILabel alloc]initWithFrame:CGRectMake(startX + [lab.text sizeWithFont:lab.font].width + 5, startY, labWidth, labHeight)];
                lab.font = tFont;
                [self addSubview:lab];
                lab.text = strValue;
                lab.textColor = [UIColor redColor];
                
                startY += labHeight;
                if (mLineArr.count == 2)
                {
                    UILabel *labQh = [[UILabel alloc]initWithFrame:CGRectMake(inset, iScale, 30, startY - iScale)];
                    labQh.backgroundColor = headerColor;
                    labQh.text = @"启程";
                    labQh.font = [UIFont systemFontOfSize:13];
                    labQh.textColor = [UIColor whiteColor];
                    labQh.textAlignment = NSTextAlignmentCenter;
                    [self addSubview:labQh];
                }
                
                startY += 8;
                
                iScale = startY;
                fTotal = 0;
            }
            tLineTitle = ticket.ticketInfo;
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"航班信息:%@",ticket.ticketInfo];
            startY += labHeight;
            
            lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"开航时间:%@",ticket.ticketTime];
            startY += labHeight;
        }
        NSObject *tmpObj = [mEdDic objectForKey:ticket.keyTicket];
        NSNumber *tmpNum = [mDic objectForKey:ticket.keyTicket];
        if (!tmpObj && tmpNum) {
            NSMutableString *muStr = [NSMutableString string];
            [muStr appendFormat:@"%@ ",ticket.ticketPosition];
            if ([ticket.type isEqualToString:@"1"]) {
                [muStr appendString:@"成人 "];
            }else if ([ticket.type isEqualToString:@"2"]) {
                [muStr appendString:@"小童 "];
            }else if ([ticket.type isEqualToString:@"3"]) {
                [muStr appendString:@"长者 "];
            }
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
            lab.font = tFont;
            [self addSubview:lab];
            lab.text = [NSString stringWithFormat:@"%@ %d张",muStr,[tmpNum intValue]];
            startY += labHeight;
            fTotal += ticket.price * [tmpNum intValue];
            [mEdDic setObject:@1 forKey:ticket.keyTicket];

        }
    }
    
    if (fTotal != 0) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(startX, startY, labWidth, labHeight)];
        lab.font = tFont;
        [self addSubview:lab];
        lab.text = @"合计:";
        NSString *strValue = [NSString stringWithFormat:@"￥%0.1f",fTotal];
        lab = [[UILabel alloc]initWithFrame:CGRectMake(startX + [lab.text sizeWithFont:lab.font].width + 5, startY, labWidth, labHeight)];
        lab.font = tFont;
        [self addSubview:lab];
        lab.text = strValue;
        lab.textColor = [UIColor redColor];
        
        startY += labHeight;
        
        if (mLineArr.count == 2)
        {
            UILabel *labQh = [[UILabel alloc]initWithFrame:CGRectMake(inset, iScale, 30, startY - iScale)];
            labQh.backgroundColor = headerColor;
            labQh.text = @"返程";
            labQh.font = [UIFont systemFontOfSize:13];
            labQh.textColor = [UIColor whiteColor];
            labQh.textAlignment = NSTextAlignmentCenter;
            [self addSubview:labQh];
        }
        order.totalPrice += fTotal;
        fTotal = 0;
    }
    
    

    
    startY += 8;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, startY);
}
@end
