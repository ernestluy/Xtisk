//
//  ServiceTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ServiceTabViewController.h"
#import "ServiceMainView.h"
#import "TicketQueryViewController.h"
@interface ServiceTabViewController ()
{
    ServiceMainView  *mainView;
}
@end

@implementation ServiceTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect mRect = [UIScreen mainScreen].bounds;
    mainView = [[ServiceMainView alloc]initWithFrame:CGRectMake(0, 0, mRect.size.width, mRect.size.height - 64 - 49)];
    mainView.delegate =self;
    [self.view addSubview:mainView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"服务";
    
}

#pragma mark - ServiceMainViewDelegate
- (void)serviceMainView:(ServiceMainView *)mainView{
    
    [self.navigationController pushViewController:[[TicketQueryViewController alloc]init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
