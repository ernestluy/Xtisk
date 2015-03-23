//
//  FoodListViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
#import "NearFilterView.h"
@interface FoodListViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate, AsyncHttpRequestDelegate,LYFlushViewDelegate,NearFilterViewDelegate>


@property(nonatomic,strong) LYTableView *tTableView;
@property(nonatomic,strong)CategoryItem *categoryItem;
@end
