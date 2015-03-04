//
//  LostPsdViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface LostPsdViewController : SecondaryViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AsyncHttpRequestDelegate>
{
    UITableView *tTableView;
}
@end
