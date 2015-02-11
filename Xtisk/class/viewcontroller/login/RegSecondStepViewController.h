//
//  RegSecondStepViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface RegSecondStepViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,copy)NSString *phoneNum;
-(IBAction)doneAction:(id)sender;
@end
