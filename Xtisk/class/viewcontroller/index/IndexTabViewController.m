//
//  IndexTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "IndexTabViewController.h"
#import "PosterItem.h"
#import "PublicDefine.h"
#import "InfoViewController.h"
#import "ServiceMenuComViewController.h"
#import "FoodDetailViewController.h"
#import "ActivityViewController.h"
#import "StarCommendView.h"
#import "TicketQueryViewController.h"
@interface IndexTabViewController ()
{
    NSMutableArray *pmArr;
}


@end

@implementation IndexTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"title1",@"title2",@"title3",@"title4"];
    NSArray *urlArr = @[@"http://img3.3lian.com/2006/013/02/016.jpg",@"http://img.159.com/desk/user/2012/4/7/Jiker201236151827921.jpg",@"http://www.jpppt.com/uploads/allimg/140705/1-140F5225415603.jpg",@"http://221.2.159.215:90/uploads/allimg/090705/1345133136-0.jpg"];
    NSArray *imgArr = @[@"http://pica.nipic.com/2007-11-09/2007119122712983_2.jpg",@"http://img.sucai.redocn.com/attachments/images/200912/20091221/20091217_fa2a743db1f556f82b9asJ320coGmYFf.jpg",@"http://pica.nipic.com/2008-07-31/2008731185451532_2.jpg",@"http://pic1.ooopic.com/uploadfilepic/sheji/2010-01-13/OOOPIC_1982zpwang407_201001136c7dcf1171883f2b.jpg"];
    pmArr = [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        PosterItem *pi = [[PosterItem alloc] init];
        pi.posterUrl   = [urlArr objectAtIndex:i];
        pi.posterTitle = [titleArr objectAtIndex:i];
        pi.posterPic   = [imgArr objectAtIndex:i];
        [pmArr addObject:pi];
    }
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    int insetY = 10;
    //轮播图
    circulaScrollView = [[CirculaScrollView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 130)];
    [circulaScrollView setPostersData:pmArr];
    circulaScrollView.cDelegate = self;
    [headerView addSubview:circulaScrollView];
    
    //四个图标
    int btnWH = 65;
    int fH = 90;
    int btnInset = (rect.size.width - btnWH *4)/5;
    int nY = CGRectGetMaxY(circulaScrollView.frame) + insetY;
    UIView *fourView = [[UIView alloc]initWithFrame:CGRectMake(0, nY, rect.size.width, fH)];
    fourView.backgroundColor = [UIColor whiteColor];
    NSArray *btnImgArr = @[@"service_icon_ticket",@"service_icon_near",@"service_icon_car_pool",@"service_icon_park_activity"];
    NSArray *btnTitle = @[@"船票",@"周边",@"拼车",@"园区活动"];
    

    
    for (int i = 0; i<4; i++) {
        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tmpBtn.tag = i;
        [tmpBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        tmpBtn.frame = CGRectMake(btnInset + (btnInset +btnWH)*i, (fH - btnWH)/2, btnWH , btnWH);
        [tmpBtn setImage:[UIImage imageNamed:[btnImgArr objectAtIndex:i]] forState:UIControlStateNormal];//Background
        [tmpBtn setImage:[UIImage imageNamed:[btnImgArr objectAtIndex:i]] forState:UIControlStateHighlighted];
        [fourView addSubview:tmpBtn];
        
        UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 37, btnWH, 18)];
        tmpLab.font = [UIFont systemFontOfSize:11];
        tmpLab.textAlignment = NSTextAlignmentCenter;
        tmpLab.text = [btnTitle objectAtIndex:i];
        tmpLab.textColor = _rgb2uic(0x575757, 1);
        [tmpBtn addSubview:tmpLab];
    }
     
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fourView.frame.size.width, 0.5)];
    separatorLine.backgroundColor = _rgb2uic(0xd8d8d8, 1);
    [fourView addSubview:separatorLine];
    
    separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0,fourView.frame.size.height - 0.5, fourView.frame.size.width, 0.5)];
    separatorLine.backgroundColor = _rgb2uic(0xd8d8d8, 1);
    [fourView addSubview:separatorLine];
    [headerView addSubview:fourView];
    
    
    //热门推荐bar
    nY += (fH + insetY);
    int rmtjH = 30;
    UIView *rmtjView = [[UIView alloc]initWithFrame:CGRectMake(0, nY, rect.size.width, rmtjH)];
    rmtjView.backgroundColor = [UIColor whiteColor];
    UILabel *rmtjLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    rmtjLabel.textColor = _rgb2uic(0xe62100, 1);
    rmtjLabel.text = @"热门推荐";
    rmtjLabel.textAlignment = NSTextAlignmentLeft;
    [rmtjView addSubview:rmtjLabel];
    
    [headerView addSubview:rmtjView];
    
    nY += rmtjH;
    headerView.frame = CGRectMake(0, 0, rect.size.width, nY);
    gridMainView = [[GridMainView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 64 - 49)];
    gridMainView.delegate = self;
    [gridMainView setHeaderView:headerView];
    
    
    
    [self.view addSubview:gridMainView];
    
    
//    StarCommendView *sc = [[StarCommendView alloc]init];
//    sc.frame = CGRectMake(100, 100, 75, 15);
//    [sc setNums:7.5];
//    sc.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:sc];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"首页";
    [gridMainView initFlushCtl];
}

-(void)selectAction:(id)sender{
    NSLog(@"selectAction");
//    InfoViewController *iv = [[InfoViewController alloc]initWithUrl:@"http://www.baidu.com" title:@"百度"];
//    [self.navigationController pushViewController:iv animated:YES];
    UIButton * btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:{
//            FoodDetailViewController *fc = [[FoodDetailViewController alloc]init];
//            [self.navigationController pushViewController:fc animated:YES];
            TicketQueryViewController *tqv = [[TicketQueryViewController alloc] init];
            [self.navigationController pushViewController:tqv animated:YES];
            break;
        }
        case 1:{
            ServiceMenuComViewController *scv = [[ServiceMenuComViewController alloc]initWithLevel:ServiceSecond title:@"周边"];
            [self.navigationController pushViewController:scv animated:YES];
            break;
        }
        case 2:{
            XT_SHOWALERT(@"该功能暂不开放");
            break;
        }
        case 3:{
            ActivityViewController *ac = [[ActivityViewController alloc]init];
            [self.navigationController pushViewController:ac animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - CirculaScrollViewDelegate
- (void)didSelected:(PosterItem *)pi{
    NSLog(@"didSelected:%@",pi.posterTitle);
    
    InfoViewController *info = [[InfoViewController alloc]initWithUrl:pi.posterUrl title:pi.posterTitle];
    [self.navigationController pushViewController:info animated:YES];
}
#pragma mark - GridMainViewDelegate
- (void)gridMainView:(GridMainView *)mainView{
    
//    [self.navigationController pushViewController:[[TicketQueryViewController alloc]init] animated:YES];
    NSLog(@"GridMainViewDelegate");
    InfoViewController *iv = [[InfoViewController alloc]initWithUrl:@"http://www.baidu.com" title:@"百度"];
    [self.navigationController pushViewController:iv animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
