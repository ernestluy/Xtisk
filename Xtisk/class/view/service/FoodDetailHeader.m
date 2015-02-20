//
//  FoodDetailHeader.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodDetailHeader.h"
#import "PublicDefine.h"
@implementation FoodDetailHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    return self;
}

-(void)setUIInit{
    self.labGoodNum.textColor = _rgb2uic(0xff6c0a, 1);
    
    self.labQs.textColor = _rgb2uic(0xef1717, 1);
    self.labTitle.textColor = _rgb2uic(0x3d3d3d, 1);
    self.labPj.textColor = _rgb2uic(0x808080, 1);
    self.labQs.layer.borderColor = _rgb2uic(0xef1717, 1).CGColor;//0xcecece
    self.labQs.layer.borderWidth = 1;
    self.labQs.layer.cornerRadius = 3;
    self.labContent.textColor = _rgb2uic(0x404040, 1);
    self.labYysj.textColor = _rgb2uic(0x404040, 1);
    
}
@end
