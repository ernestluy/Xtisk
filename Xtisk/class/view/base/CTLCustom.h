//
//  CTLCustom.h
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CTLCustom : NSObject
+(UIButton *)getButtonNormalWithRect:(CGRect )rect;
+(UIButton *)getButtonRadiusWithRect:(CGRect )rect;
+(void)setButtonRadius:(UIButton *)btn;
+(UIButton *)getButtonSubmitWithRect:(CGRect )rect;

+(UIButton *)getTableViewLastButton:(CGRect)rect;
+(UILabel*)getCusRightLabel:(CGRect)rect;

+(UITextField*)getRegTextFieldWith:(CGRect)rect;
@end
