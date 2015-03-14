//
//  MyTicketsListTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketOrderListItem.h"
@interface MyTicketsListTableViewCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UILabel *labOrderId;
@property(nonatomic,weak)IBOutlet UILabel *labOrderTime;
@property(nonatomic,weak)IBOutlet UILabel *labStatus;

-(void)setData:(TicketOrderListItem  *)item;
@end
