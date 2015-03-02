//
//  NearMenuCollectionViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "NearMenuCollectionViewCell.h"
#import "PublicDefine.h"
@implementation NearMenuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.borderColor =  defaultBorderColor.CGColor;//_rgb2uic(0xe7e7e7, 1).CGColor;//0xcecece
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = XT_CORNER_RADIUS;
    self.content.textColor = _rgb2uic(0x585858, 1);
    
    self.title.hidden = YES;
    self.content.hidden = YES;
    self.imageHeader.hidden = YES;
    
}
-(void)setMenuItem:(MenuItem *)tItem{
    self.mItem = tItem;
    
}
-(void)setItemData:(NearMenuItem *)sItem{
    self.title.text = sItem.tTitle;
    self.content.text = sItem.tContent;
    self.imageHeader.image = [UIImage imageNamed:sItem.imgNme];
    self.title.textColor = sItem.tintColor;
    if (!sItem.isValide) {
        self.title.textColor = _rgb2uic(0xc6c6c6, 1);
        self.content.textColor = _rgb2uic(0xc6c6c6, 1);
        self.backgroundColor = _rgb2uic(0xeaeaea, 1);
    }
    self.title.hidden = YES;
    self.content.hidden = YES;
    self.imageHeader.hidden = YES;
}

-(void)setFoodData:(NSString *)imgNme{
    self.title.hidden = YES;
    self.content.hidden = YES;
    self.imageHeader.hidden = YES;
    self.imageBg.image = [UIImage imageNamed:imgNme];
}
@end
