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
    
    self.imgHeader.backgroundColor = _rgb2uic(0xf6f6f6, 1);
//    [self.viewStar setNums:6];
    
    
    UIImageView *tiv = [[UIImageView alloc]initWithFrame:CGRectMake(171, 7, 17, 17)];
    [self addSubview:tiv];
    tiv.image = [UIImage imageNamed:@"up_cn"];
    
    self.imgTjc = tiv;
}

-(void)setData:(MenuItem *)item{
    self.labJg.text = [NSString stringWithFormat:@"￥%.1f",item.menuPrice];
    [self.labJg sizeToFit];
    self.labTitle.text = item.menuName;
    [self.labTitle sizeToFit];
    [self.viewStar setNums:item.recomNumber * 2.0];
    [self.labTitle sizeToFit];
    int tWidth = [item.menuName sizeWithFont:self.labTitle.font].width;
//    self.imgViewTj.center = CGPointMake(self.labTitle.frame.origin.x + tWidth + 10, self.imgViewTj.center.y);
    self.imgViewTj.hidden = YES;
    self.imgTjc.center = CGPointMake(self.labTitle.frame.origin.x + tWidth + 10, self.imgViewTj.center.y);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
