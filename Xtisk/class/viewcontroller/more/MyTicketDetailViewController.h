//
//  MyTicketDetailViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface MyTicketDetailViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate>

@property(nonatomic,strong) MyTicketOrderDetail *mOrderDetail;
@end
