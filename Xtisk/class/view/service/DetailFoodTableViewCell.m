//
//  DetailFoodTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "DetailFoodTableViewCell.h"
#import "PublicDefine.h"
@implementation DetailFoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labJg.layer.borderColor = _rgb2uic(0xed4d1c, 1).CGColor;
    self.labJg.textColor = _rgb2uic(0xed4d1c, 1);
    self.labJg.layer.borderWidth = 1;
    self.labJg.layer.cornerRadius = 3;
    
    
    [self.viewStar setNums:6];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
