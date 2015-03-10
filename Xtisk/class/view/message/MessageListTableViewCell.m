//
//  MessageListTableViewCell.m
//  Xtisk
//
//  Created by zzt on 15/3/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MessageListTableViewCell.h"
#import "PublicDefine.h"

@implementation MessageListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labTime.textColor = defaultTextGrayColor;
    self.labMsg.textColor = defaultTextGrayColor;
    
    BadgeView *bv = [[BadgeView alloc]initWithFrame:CGRectMake(288, 26, 18, 18)];
    [self addSubview:bv];
    self.badgeView = bv;
//    self.badgeView.backgroundColor = [UIColor redColor];
    [self.badgeView setTnum:0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
