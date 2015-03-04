//
//  ActivitySignUpViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface ActivitySignUpViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,AsyncHttpRequestDelegate>
{
    UITableView *tTableView;
}
@property(nonatomic)int signUpInfoType;
@property(nonatomic,strong)ActivityItem *mActivityItem;
@end
