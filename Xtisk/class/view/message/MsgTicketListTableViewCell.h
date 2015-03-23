//
//  MsgTicketListTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTicketOrderDetail.h"
@interface MsgTicketListTableViewCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UILabel *labCode;
@property(nonatomic,weak)IBOutlet UILabel *labName;
@property(nonatomic,weak)IBOutlet UILabel *labPayTime;
@property(nonatomic,weak)IBOutlet UILabel *labLine;
@property(nonatomic,weak)IBOutlet UILabel *labRemind;

-(void)setData:(MyTicketOrderDetail*)order;
@end
