//
//  MessageTabViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface MessageTabViewController : SecondaryViewController<UITableViewDelegate>
{
    
}
@property(nonatomic,weak)IBOutlet UITableView * tTableView;
@end
