//
//  MyTicketsListTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketsListTableViewCell.h"
#import "PublicDefine.h"
@implementation MyTicketsListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    UIImageView *imgLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 42, 305, 0.5)];
    imgLine.image = [UIImage imageNamed:@"line_gray.png"];
    [self addSubview:imgLine];
}

/*
 
 待支付、已支付、已过期、+（待审批、待授权、待确认、系统异常）
 其中括号里的不常见，万一出现，客户端的显示跟 已过期一样显示灰色字
 
 (0：待支付 1：已支付 2：待审批 3：已过期 4：待授权  5：待确认  6：系统异常)
 */
-(void)setData:(TicketOrderListItem  *)item{
    self.labOrderId.text = int2str(item.orderId);
    self.labOrderTime.text = item.orderTime;
    self.labStatus.text = item.orderStatus;
    if(item.status == 0){
        self.labStatus.textColor = listColorPayIng;
    }else if(item.status == 1){
        self.labStatus.textColor = listColorPayOk;
    }else{
        self.labStatus.textColor = listColorPayOver;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
