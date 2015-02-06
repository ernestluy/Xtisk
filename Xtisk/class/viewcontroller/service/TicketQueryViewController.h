//
//  TicketQueryViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface TicketQueryViewController : SecondaryViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIDatePicker * startPicker;
    UIDatePicker * endPicker;
}
@property(nonatomic,weak)IBOutlet UITableView *tTableView;
@end
