//
//  MyActivityTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyActivity.h"
@interface MyActivityTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *labTitle;
@property(nonatomic,weak)IBOutlet UILabel *labSignUpTime;
@property(nonatomic,weak)IBOutlet UILabel *labAcLast;
@property(nonatomic,weak)IBOutlet UILabel *labStatus;
@property(nonatomic,weak)IBOutlet UIButton *btnDetail;


-(void)setData:(MyActivity *)ac;
@end
