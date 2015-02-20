//
//  RegSecondStepViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface RegSecondStepViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,copy)NSString *phoneNum;

-(id)initWithTitle:(NSString *)tl type:(int)t;

-(IBAction)doneAction:(id)sender;
@end
