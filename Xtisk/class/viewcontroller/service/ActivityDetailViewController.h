//
//  ActivityDetailViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface ActivityDetailViewController : SecondaryViewController


@property(nonatomic,weak)IBOutlet UIWebView *webView;
@property(nonatomic,weak)IBOutlet UIButton *btnSignUp;
@property(nonatomic,weak)IBOutlet UIButton *btnPraise;
@property(nonatomic,weak)IBOutlet UIButton *btnCommend;

-(IBAction)toSignUp:(id)sender;
-(IBAction)toPraise:(id)sender;
-(IBAction)toCommend:(id)sender;

@end
