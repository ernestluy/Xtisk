//
//  ServiceTabViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ServiceTabViewController.h"
#import "ServiceMainView.h"
#import "TicketQueryViewController.h"
#import "PublicDefine.h"
#import "ServiceItem.h"
#import "ServiceMenuComViewController.h"
#import "ActivityViewController.h"
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
    NSArray *nameArr = @[@"船 票",@"周 边",@"园区活动",@"小猪巴士"];
    NSArray *imgArr = @[@"service_icon_ticket",@"service_icon_near",@"service_icon_park_activity",@"service_icon_car_pool"];
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<nameArr.count; i++) {
        ServiceItem *si = [[ServiceItem alloc]init];
        si.serviceTitle = [nameArr objectAtIndex:i];
        si.serviceTag = i;
        si.serviceImg = [imgArr objectAtIndex:i];
        [mArr addObject:si];
    }
    
    mainView = [[ServiceMainView alloc]initWithFrame:CGRectMake(0, 0, mRect.size.width, mRect.size.height - 64 - 49)];
    mainView.delegate =self;
    [self.view addSubview:mainView];
    [mainView setData:mArr];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"服务";
    
}

#pragma mark - ServiceMainViewDelegate
- (void)serviceMainView:(ServiceMainView *)mView{
    int tTag = (int)mView.tIndexPath.row;
    switch (tTag) {
        case XtServiceTicket:{
            if (!authorityTicket) {
                [SVProgressHUD showSuccessWithStatus:@"即将上线，敬请期待！" duration:2];
                return;
            }
            [self.navigationController pushViewController:[[TicketQueryViewController alloc]init] animated:YES];
            break;
        }
        case XtServiceNear:{
            ServiceMenuComViewController *scv = [[ServiceMenuComViewController alloc]initWithLevel:ServiceFirst title:@"周边"];
            [self.navigationController pushViewController:scv animated:YES];
            break;
        }
        case XtServiceParkActivities:{
            
            ActivityViewController *ac = [[ActivityViewController alloc]init];
            [self.navigationController pushViewController:ac animated:YES];
            break;
        }
        default:{
            [SVProgressHUD showSuccessWithStatus:@"即将上线，敬请期待！" duration:2];
            break;
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
