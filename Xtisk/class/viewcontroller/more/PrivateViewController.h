//
//  PrivateViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PopoverView.h"
#import "EditTextViewController.h"
@interface PrivateViewController : SecondaryViewController<UIActionSheetDelegate,EditTextViewDelegate>


@property(nonatomic,weak)IBOutlet UITableView *tTableView;
@property(nonatomic,weak)PopoverView *tPopView;
@end