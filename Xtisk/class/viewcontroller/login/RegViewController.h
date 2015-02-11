//
//  RegViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface RegViewController : SecondaryViewController<UITextFieldDelegate>


@property(nonatomic,weak)IBOutlet UILabel *labPrompt;
-(IBAction)regAction:(id)sender;
-(IBAction)getVerCodeAction:(id)sender;
-(IBAction)nextAction:(id)sender;
@end
