//
//  CTLCustom.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CTLCustom.h"
#import "ColorTools.h"
#import "PublicDefine.h"
@implementation CTLCustom

+(UIButton *)getButtonRadiusWithRect:(CGRect )rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = _rgb2uic(0xd7d7d7, 1).CGColor;
    [btn setTitleColor:_rgb2uic(0x888888, 1) forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 4;
    return btn;
}
+(void)setButtonRadius:(UIButton *)btn{
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = _rgb2uic(0xd7d7d7, 1).CGColor;
    [btn setTitleColor:_rgb2uic(0x888888, 1) forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 4;
}
@end
