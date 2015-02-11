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
#import "PublicDefine.h"
#import "ServiceItem.h"
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
    NSArray *nameArr = @[@"船票",@"周边",@"园区活动"];
    NSArray *imgArr = @[@"service_icon_ticket",@"service_icon_near",@"service_icon_park_activity"];
    
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
            [self.navigationController pushViewController:[[TicketQueryViewController alloc]init] animated:YES];
            break;
        }
        case XtServiceNear:{
            
            break;
        }
        case XtServiceParkActivities:{
            
            break;
        }
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
