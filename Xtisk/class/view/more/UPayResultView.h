//
//  UPayResultView.h
//  Xtisk
//
//  Created by zzt on 15/3/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPayResultView : UIView

@property(nonatomic,weak)IBOutlet UIImageView *imgViewRes;
@property(nonatomic,weak)IBOutlet UILabel *lab1;
@property(nonatomic,weak)IBOutlet UILabel *labCode;
@property(nonatomic,weak)IBOutlet UILabel *labReuslt;

-(void)setCode:(NSString *)code res:(BOOL)b;
+(UPayResultView *)UPayResultViewWithXib;
@end
