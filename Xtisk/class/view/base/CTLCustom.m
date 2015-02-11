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
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.borderColor = [UIColor whiteColor].CGColor;//_rgb2uic(0xd7d7d7, 1).CGColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 4;
}

+(UIButton *)getButtonSubmitWithRect:(CGRect )rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4;
    btn.backgroundColor = _rgb2uic(0x1bbbfe, 1);
    return btn;
}
@end
