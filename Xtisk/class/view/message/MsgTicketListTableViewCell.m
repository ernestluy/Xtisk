//
//  MsgTicketListTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MsgTicketListTableViewCell.h"
#import "SettingService.h"
@implementation MsgTicketListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setData:(MyTicketOrderDetail*)order{
    IUser *tUser = [SettingService sharedInstance].iUser;
    MyTicketItem *tItem = [order.ticketList objectAtIndex:0];
    self.labCode.text = [NSString stringWithFormat:@"取票编号:%@",tItem.getId];
    self.labName.text = [NSString stringWithFormat:@"亲爱的%@,您已购",tUser.nickName];
    
    if (order.ticketList.count > 0) {
        MyTicketItem *item = [order.ticketList objectAtIndex:0];
        self.labLine.text = item.ticketInfo;
        self.labPayTime.text = item.ticketTime;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
