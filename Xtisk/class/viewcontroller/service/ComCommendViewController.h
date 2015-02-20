//
//  ComCommendViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface ComCommendViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)IBOutlet UITableView *tTableView;
@end
