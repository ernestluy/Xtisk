//
//  RegSecondStepViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface RegSecondStepViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,AsyncHttpRequestDelegate>
{
    UITextField *nowTextField;
    UITextField *textFieldPsd;
    UITextField *textFieldComfirm;
}
@property(nonatomic,copy)NSString *phoneNum;
@property(nonatomic,copy)NSString *smsCode;

-(id)initWithTitle:(NSString *)tl type:(int)t;

-(IBAction)doneAction:(id)sender;
@end
