//
//  IndexTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "IndexTabViewController.h"

@interface IndexTabViewController ()

@end

@implementation IndexTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect rect = [UIScreen mainScreen].bounds;
    circulaScrollView = [[CirculaScrollView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 200)];
//    [self.view addSubview:circulaScrollView];
    
    gridMainView = [[GridMainView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 64 - 49)];
    [self.view addSubview:gridMainView];
    [gridMainView setHeaderView:circulaScrollView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"首页";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
