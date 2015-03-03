//
//  ComCommendViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface ComCommendViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,AsyncHttpRequestDelegate>

@property(nonatomic,strong)IBOutlet UITableView *tTableView;
@property(nonatomic) int storeId;
@end
