//
//  ShopMenuCollectionViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ShopMenuCollectionViewCell.h"
/*
 {
 "recomNumber": "4",
 "menuUrl": "upload/common/2015_03_02/788_store.png",
 "menuPrice": 20,
 "menuId": 181,
 "menuName": "满汉全系"
 }
 */
@implementation ShopMenuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labJg.textColor = [UIColor whiteColor];
    self.labJg.backgroundColor = _rgb2uic(0xed4d1c, 1);
    self.labJg.layer.cornerRadius = 3;
    
    self.labTitle.textColor = defaultTextColor;
    [self.viewStar setNums:6.5];
    [self.viewStar setNeedsDisplay];
    
    self.imgShow.backgroundColor = _rgb2uic(0xf6f6f6, 1);
}

-(void)setData:(MenuItem*)item{
    self.labTitle.text = item.menuName;
    self.labJg.text = item.strMenuPrice;
    CGRect rect = self.labJg.frame;
    int twidth = [item.strMenuPrice sizeWithFont:self.labJg.font].width+3;
    
    self.labJg.frame = CGRectMake(self.frame.size.width - 1 - twidth, rect.origin.y, twidth, rect.size.height);
    [self.viewStar setNums:item.recomNumber *2];
}

@end
