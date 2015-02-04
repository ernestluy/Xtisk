//
//  MoreTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MoreTabViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
@interface MoreTabViewController ()

@end

@implementation MoreTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"更多";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)logout:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CustomNavigationController *nav = [[CustomNavigationController alloc]init];
    nav.interactivePopGestureRecognizer.enabled = NO;
    [nav pushViewController:[[LoginViewController alloc]init] animated:NO];
    appDelegate.window.rootViewController = nav;
}

@end
