//
//  ActivityListTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityItem.h"
@interface ActivityListTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView *imgHeader;
@property(nonatomic,weak)IBOutlet UIImageView *imgBar;
@property(nonatomic,weak)IBOutlet UILabel *labTitle;
@property(nonatomic,weak)IBOutlet UILabel *labTime;

@property(nonatomic,weak)IBOutlet UILabel *labStatus;

-(void)setData:(ActivityItem *)item;
@end
