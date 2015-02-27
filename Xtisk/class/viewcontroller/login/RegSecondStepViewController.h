//
//  RegSecondStepViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface RegSecondStepViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,AsyncHttpRequestDelegate>
@property(nonatomic,copy)NSString *phoneNum;
@property(nonatomic,copy)NSString *smsCode;

-(id)initWithTitle:(NSString *)tl type:(int)t;

-(IBAction)doneAction:(id)sender;
@end
