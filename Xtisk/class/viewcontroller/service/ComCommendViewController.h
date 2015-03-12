//
//  ComCommendViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface ComCommendViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate,LYFlushViewDelegate>

@property(nonatomic,strong)IBOutlet LYTableView *tTableView;
@property(nonatomic) int storeId;
@property(nonatomic) int activityId;
@property(nonatomic) int vcType;
@property(nonatomic,strong)ActivityItem *mActivityItem;
@property(nonatomic,strong) StoreItem *mStoreItem;
@end
