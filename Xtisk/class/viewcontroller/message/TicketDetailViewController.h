//
//  TicketDetailViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/21.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "MyTicketOrderDetail.h"
@interface TicketDetailViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tTableView;
}
@property(nonatomic,strong) MyTicketOrderDetail *mOrderDetail;
@end
