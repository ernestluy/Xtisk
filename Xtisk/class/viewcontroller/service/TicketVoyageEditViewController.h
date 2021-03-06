//
//  TicketVoyageEditViewController.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
#import "VoyageItem.h"
@interface TicketVoyageEditViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    TicketVoyageStepType tStep;
}
@property(nonatomic)TicketVoyageStepType tStep;

@property(nonatomic,strong)VoyageItem *mVoyageItem;
@end
