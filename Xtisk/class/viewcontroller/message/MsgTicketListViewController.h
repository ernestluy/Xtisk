//
//  MsgTicketListViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface MsgTicketListViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tTableView;
}
@end
