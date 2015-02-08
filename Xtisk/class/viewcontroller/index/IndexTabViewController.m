//
//  IndexTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "IndexTabViewController.h"
#import "PosterItem.h"
@interface IndexTabViewController ()

@end

@implementation IndexTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *titleArr = @[@"title1",@"title2",@"title3",@"title4"];
    NSArray *urlArr = @[@"http://img3.3lian.com/2006/013/02/016.jpg",@"http://img.159.com/desk/user/2012/4/7/Jiker201236151827921.jpg",@"http://www.jpppt.com/uploads/allimg/140705/1-140F5225415603.jpg",@"http://221.2.159.215:90/uploads/allimg/090705/1345133136-0.jpg"];
    NSArray *imgArr = @[@"http://pica.nipic.com/2007-11-09/2007119122712983_2.jpg",@"http://img.sucai.redocn.com/attachments/images/200912/20091221/20091217_fa2a743db1f556f82b9asJ320coGmYFf.jpg",@"http://pica.nipic.com/2008-07-31/2008731185451532_2.jpg",@"http://pic1.ooopic.com/uploadfilepic/sheji/2010-01-13/OOOPIC_1982zpwang407_201001136c7dcf1171883f2b.jpg"];
    NSMutableArray *pmArr = [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        PosterItem *pi = [[PosterItem alloc] init];
        pi.posterUrl   = [urlArr objectAtIndex:i];
        pi.posterTitle = [titleArr objectAtIndex:i];
        pi.posterPic   = [imgArr objectAtIndex:i];
        [pmArr addObject:pi];
    }
    
    CGRect rect = [UIScreen mainScreen].bounds;
    circulaScrollView = [[CirculaScrollView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 160)];
    [circulaScrollView setPostersData:pmArr];
    circulaScrollView.cDelegate = self;
    
    
    gridMainView = [[GridMainView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 64 - 49)];
    gridMainView.delegate = self;
    [self.view addSubview:gridMainView];
    [gridMainView setHeaderView:circulaScrollView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"首页";
    [gridMainView initFlushCtl];
}
#pragma mark - CirculaScrollViewDelegate
- (void)didSelected:(PosterItem *)pi{
    NSLog(@"didSelected:%@",pi.posterTitle);
}
#pragma mark - GridMainViewDelegate
- (void)gridMainView:(GridMainView *)mainView{
    
//    [self.navigationController pushViewController:[[TicketQueryViewController alloc]init] animated:YES];
    NSLog(@"GridMainViewDelegate");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
