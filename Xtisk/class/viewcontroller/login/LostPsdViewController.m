//
//  LostPsdViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "LostPsdViewController.h"
#import "PublicDefine.h"
@interface LostPsdViewController ()


@property(nonatomic,weak)IBOutlet UIButton *btnTest;
@end

@implementation LostPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    
    self.view.backgroundColor = _rgb2uic(0xeff9fb, 1);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self performSelector:@selector(showUI) withObject:nil afterDelay:1];
}

-(void)showUI{
    CGRect bRect = self.btnTest.frame;
    NSLog(@"showUI");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
