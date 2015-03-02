//
//  FoodListViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface FoodListViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate, AsyncHttpRequestDelegate>


@property(nonatomic,strong) UITableView *tTableView;
@property(nonatomic,strong)CategoryItem *categoryItem;
@end
