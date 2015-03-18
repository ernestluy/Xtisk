//
//  MyTicketDetailViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
#import "UPPayPluginDelegate.h"
@interface MyTicketDetailViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate,UPPayPluginDelegate>

@property(nonatomic,strong) MyTicketOrderDetail *mOrderDetail;
@property(nonatomic) TicketOrderDetailAction payAction;
@end
