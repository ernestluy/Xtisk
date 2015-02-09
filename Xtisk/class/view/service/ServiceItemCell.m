//
//  ServiceItemCell.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ServiceItemCell.h"
#import "PublicDefine.h"
@implementation ServiceItemCell

- (void)awakeFromNib {
    // Initialization code
    //0xd0d0d0 0xdbdbdb
    self.layer.borderColor = _rgb2uic(0xd0d0d0, 1).CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = self.frame.size.width/2-1;
    self.title.textColor = _rgb2uic(0x575757, 1);
}
-(void)setItemData:(ServiceItem *)sItem{
    self.imageBg.image = [UIImage imageNamed:sItem.serviceImg];
    self.title.text = sItem.serviceTitle;
}
@end
