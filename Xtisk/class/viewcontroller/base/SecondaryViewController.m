//
//  SecondaryViewController.m
//  Xtisk
//
//  Created by 卢一 on 15-1-31.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface SecondaryViewController ()

@end

@implementation SecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isRequestSucMark = NO;
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 36);
    [backBtn setImage:[UIImage imageNamed:@"base_back.png"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 0, 9, 42);
    
    [backBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    [self.navigationItem setLeftBarButtonItem:back];
    
//    UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 50, 44)];
//    tView.backgroundColor = [UIColor redColor];
//    self.navigationItem.titleView = tView;
////    [self.navigationItem.titleView addSubview:tView];
}
-(void)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
