//
//  FoodListTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodListTableViewCell.h"
#import "PublicDefine.h"
@implementation FoodListTableViewCell


//ff6c0a
- (void)awakeFromNib {
    // Initialization code
    self.labGood.textColor = _rgb2uic(0xff6c0a, 1);
    self.labQs.textColor = _rgb2uic(0xef1717, 1);
    self.labTitle.textColor = _rgb2uic(0x3d3d3d, 1);
    self.labPj.textColor = _rgb2uic(0x808080, 1);
    self.labAddress.textColor = _rgb2uic(0xb0b0b0, 1);
    self.labQs.layer.borderColor = _rgb2uic(0xef1717, 1).CGColor;//0xcecece
    self.labQs.layer.borderWidth = 1;
    self.labQs.layer.cornerRadius = 3;
    
    self.imgHeader.backgroundColor = _rgb2uic(0xf6f6f6, 1);
    ///-----------------------
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
