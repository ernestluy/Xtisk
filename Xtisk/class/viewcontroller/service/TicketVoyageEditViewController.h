//
//  TicketVoyageEditViewController.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface TicketVoyageEditViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate>{
    TicketVoyageStepType tStep;
}
@property(nonatomic)TicketVoyageStepType tStep;
@end
