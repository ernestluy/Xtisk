//
//  CTLCustom.m
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CTLCustom.h"
#import "ColorTools.h"
#import "PublicDefine.h"
@implementation CTLCustom


+(UIButton *)getButtonRightArrowDownWithRect:(CGRect )rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.frame = rect;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width-17, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 18);
    return btn;
}

+(UIButton *)getButtonNormalWithRect:(CGRect )rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    btn.frame = rect;
//    btn.backgroundColor = [UIColor yellowColor];
    return btn;
}

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
    btn.layer.cornerRadius = 10;
    btn.frame = rect;
    btn.backgroundColor = _rgb2uic(0x1bbbfe, 1);
    return btn;
}

+(UIButton *)getTableViewLastButton:(CGRect)rect{
    UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOrder.frame = rect;
    btnOrder.titleLabel.font = DefaultCellFont;
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    return btnOrder;
}

+(UILabel*)getCusRightLabel:(CGRect)rect{
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    lab.textAlignment = NSTextAlignmentRight;
    lab.textColor = [UIColor darkGrayColor];
    //    lab.backgroundColor = [UIColor yellowColor];
    lab.font = [UIFont systemFontOfSize:14];
    return lab;
}

+(UITextField*)getRegTextFieldWith:(CGRect)rect{
    UITextField *tf = [[UITextField alloc]init];
    tf.frame = rect;
    tf.textAlignment = NSTextAlignmentLeft;
    UIView* tmpInsetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, rect.size.height)];
    tf.leftView = tmpInsetView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.returnKeyType = UIReturnKeyDone;
    tf.clearButtonMode = YES;
    tf.layer.cornerRadius = 10;
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = _rgb2uic(0x8da3ae, 1).CGColor;
    tf.font = DefaultCellFont;
    tf.backgroundColor = [UIColor whiteColor];
    return tf;
}


+(UILabel *)labelNoteNoData{
    CGRect bounds = [UIScreen mainScreen].bounds;
    UILabel * labNoteNoData = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    labNoteNoData.text = @"暂无数据";
    labNoteNoData.font = [UIFont systemFontOfSize:14];
    labNoteNoData.textColor = defaultTextColor;
    labNoteNoData.textAlignment = NSTextAlignmentCenter;
    return labNoteNoData;
}
@end
