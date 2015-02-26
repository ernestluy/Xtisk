//
//  MoreTabViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface MoreTabViewController : SecondaryViewController<UMSocialUIDelegate,UMSocialShakeDelegate,AsyncHttpRequestDelegate
>

@property(nonatomic,weak)IBOutlet UITableView *tTableView;
-(IBAction)logout:(id)sender;
-(IBAction)settingAction:(id)sender;

@end
