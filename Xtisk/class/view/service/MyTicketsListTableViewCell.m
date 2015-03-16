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
}

-(void)setData:(TicketOrderListItem  *)item{
    self.labOrderId.text = int2str(item.orderId);
    self.labOrderTime.text = item.orderTime;
    self.labStatus.text = item.orderStatus;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
