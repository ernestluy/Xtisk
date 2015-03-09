//
//  MessageListTableViewCell.h
//  Xtisk
//
//  Created by zzt on 15/3/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeView.h"
@interface MessageListTableViewCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UIImageView *imgViewHeader;
@property(nonatomic,weak)IBOutlet UILabel *labTitle;
@property(nonatomic,weak)IBOutlet BadgeView *badgeView;
@property(nonatomic,weak)IBOutlet UILabel *labMsg;
@property(nonatomic,weak)IBOutlet UILabel *labTime;
@end
