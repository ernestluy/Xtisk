//
//  RegViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface RegViewController : SecondaryViewController<UITextFieldDelegate,AsyncHttpRequestDelegate>


@property(nonatomic,weak)IBOutlet UILabel *labPrompt;

@property(nonatomic,weak)IBOutlet UITextField *tf1;
@property(nonatomic,weak)IBOutlet UITextField *tf2;
-(IBAction)regAction:(id)sender;
-(IBAction)getVerCodeAction:(id)sender;
-(IBAction)nextAction:(id)sender;
@end
