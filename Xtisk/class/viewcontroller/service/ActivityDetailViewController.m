//
//  ActivityDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "EditTextViewController.h"
#import "PublicDefine.h"
#import "ActivitySignUpViewController.h"
@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动详情";
//    [self loadRemoteUrl:@"http://www.sina.com.cn"];
    
    
    
    
    self.btnCommend.layer.borderColor = _rgb2uic(0xe1e1e1, 1).CGColor;
    self.btnCommend.layer.borderWidth = 1;
    
    self.btnPraise.layer.borderColor = _rgb2uic(0xe1e1e1, 1).CGColor;
    self.btnPraise.layer.borderWidth = 1;
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 20, 20);
    [okBtn setBackgroundImage:[UIImage imageNamed:@"share_arrow"] forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * ritem = [[UIBarButtonItem alloc] initWithCustomView:okBtn] ;
    [self.navigationItem setRightBarButtonItem:ritem];
}

- (void)loadRemoteUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest:request];
    
}

-(void)toShare{
    NSLog(@"toShare");
}


-(IBAction)toSignUp:(id)sender{
    NSLog(@"toSignUp");
    ActivitySignUpViewController *as = [[ActivitySignUpViewController alloc]init];
    [self.navigationController pushViewController:as animated:YES];
}
-(IBAction)toPraise:(id)sender{
    NSLog(@"toPraise");
}
-(IBAction)toCommend:(id)sender{
    NSLog(@"toCommend");
    EditTextViewController *ec = [[EditTextViewController alloc]initWithType:PrivateEditTextFoodCommend delegate:nil];
    [self.navigationController pushViewController:ec animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
