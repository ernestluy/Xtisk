//
//  FoodDetailViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "EditTextViewController.h"
#import "PublicDefine.h"
#import "LoginViewController.h"
@interface FoodDetailViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,EditTextViewDelegate,AsyncHttpRequestDelegate,LoginViewControllerDelegate>

@property(nonatomic,strong)IBOutlet UITableView *tTableView;
@property(nonatomic,strong) StoreItem *mStoreItem;
@end
