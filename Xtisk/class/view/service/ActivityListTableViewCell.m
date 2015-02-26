//
//  ActivityListTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityListTableViewCell.h"
#import "PublicDefine.h"
@implementation ActivityListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imgHeader.backgroundColor = _rgb2uic(0xf6f6f6, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
