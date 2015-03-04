//
//  ActivityViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface ActivityViewController : SecondaryViewController<UITableViewDataSource,UITableViewDelegate,LYFlushViewDelegate,AsyncHttpRequestDelegate>{
    
}
@property(nonatomic,strong)IBOutlet LYTableView *tTableView;
@end
