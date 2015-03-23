//
//  TicketPaySuccssViewController.h
//  Xtisk
//
//  Created by zzt on 15/3/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "MyTicketOrderDetail.h"
@interface TicketPaySuccssViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) MyTicketOrderDetail *mOrderDetail;
@end
