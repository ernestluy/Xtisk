//
//  UPayResultView.m
//  Xtisk
//
//  Created by zzt on 15/3/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "UPayResultView.h"
#import "PublicDefine.h"
@implementation UPayResultView

+(UPayResultView *)UPayResultViewWithXib{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UPayResultView" owner:self options:nil];
    if (nib.count > 0) {
        return [nib objectAtIndex:0];
    }
    return [[UPayResultView alloc] init];
}

-(void)setCode:(NSString *)code res:(BOOL)b{
    self.labCode.textColor = _rgb2uic(0xef5e56, 1);
    self.labReuslt.textColor = _rgb2uic(0xef5e56, 1);
    if (!b) {
        self.labCode.text = code;
        self.lab1.text = @"对不起！您的订单";
        self.labReuslt.text = @"支付失败！";
        self.imgViewRes.image = [UIImage imageNamed:@"upay_fail"];
    }else{
        self.labCode.text = [NSString stringWithFormat:@"取票编号:%@",code];
        self.lab1.text = @"恭喜您！订单支付成功";
        self.labReuslt.text = @"(取票时请出示)";
        self.imgViewRes.image = [UIImage imageNamed:@"upay_success"];
    }
}

@end
