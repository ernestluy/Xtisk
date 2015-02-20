//
//  ShopMenuCollectionViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ShopMenuCollectionViewCell.h"

@implementation ShopMenuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labJg.textColor = [UIColor whiteColor];
    self.labJg.backgroundColor = _rgb2uic(0xed4d1c, 1);
    self.labJg.layer.cornerRadius = 3;
    
    [self.viewStar setNums:6.5];
    [self.viewStar setNeedsDisplay];
    
}

@end
