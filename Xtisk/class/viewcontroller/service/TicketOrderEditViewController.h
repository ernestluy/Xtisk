//
//  TicketOrderEditViewController.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
#import "UPPayPluginDelegate.h"
@interface TicketOrderEditViewController : SecondaryViewController<UPPayPluginDelegate,UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate,UITextFieldDelegate>

@end
