//
//  IndexTabViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
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
#import "LYTableView.h"
#import "LYCollectionView.h"
@interface IndexTabViewController ()
{
    NSMutableArray *pmArr;
    LYCollectionView *tLyCollectionView;
    
    NSArray *tRecommendList;
    
    NSMutableArray *tmpMarr;
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
    tmpMarr = [NSMutableArray array];
    for (int i = 0; i<1; i++) {
        PosterItem *pi = [[PosterItem alloc] init];
        pi.posterUrl   = [urlArr objectAtIndex:i];
        pi.posterTitle = [titleArr objectAtIndex:i];
        pi.posterPic   = [imgArr objectAtIndex:i];
        [pmArr addObject:pi];
        
        RecommendItem *tri = [[RecommendItem alloc]init];
        tri.recomPic = [imgArr objectAtIndex:i];
        tri.recomUrl = @"http://www.sina.com.cn";
        [tmpMarr addObject:tri];
    }
    tRecommendList = tmpMarr;
    
    
//    NSArray *ttdic = @[@{@"recomPic":@"http://img3.3lian.com/2006/013/02/016.jpg",@"recomUrl":@"http://www.sina.com.cn"},@{@"recomPic":@"http://img.159.com/desk/user/2012/4/7/Jiker201236151827921.jpg",@"recomUrl":@"http://www.sina.com.cn"},@{@"recomPic":@"http://pica.nipic.com/2007-11-09/2007119122712983_2.jpg",@"recomUrl":@"http://www.sina.com.cn"}];
//    NSString *tttt = PathDocFile(IndexRecomList);
//    [ttdic writeToFile:PathDocFile(IndexRecomList) atomically:YES];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    int insetY = 6;
    //轮播图
    circulaScrollView = [[CirculaScrollView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 130)];
//    [circulaScrollView setPostersData:pmArr];
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
    NSArray *btnTitle = @[@"船票",@"周 边",@"拼 车",@"园区活动"];
    

    
    for (int i = 0; i<4; i++) {
        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tmpBtn.tag = i;
        [tmpBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        tmpBtn.frame = CGRectMake(btnInset + (btnInset +btnWH)*i, (fH - btnWH)/2, btnWH , btnWH);
        [tmpBtn setImage:[UIImage imageNamed:[btnImgArr objectAtIndex:i]] forState:UIControlStateNormal];//Background
        [tmpBtn setImage:[UIImage imageNamed:[btnImgArr objectAtIndex:i]] forState:UIControlStateHighlighted];
        [fourView addSubview:tmpBtn];
        
        UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 37, btnWH, 18)];
        tmpLab.font = [UIFont systemFontOfSize:10];
        tmpLab.textAlignment = NSTextAlignmentCenter;
        tmpLab.text = [btnTitle objectAtIndex:i];
        tmpLab.textColor = defaultTextColor;//575757
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
    int rmtjH = 16;
    UIView *rmtjView = [[UIView alloc]initWithFrame:CGRectMake(0, nY, rect.size.width, rmtjH)];
    rmtjView.backgroundColor = [UIColor whiteColor];
    UILabel *rmtjLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 200, 14)];
    rmtjLabel.textColor = _rgb2uic(0xe62100, 1);
    rmtjLabel.text = @"热门推荐";
    rmtjLabel.font = [UIFont systemFontOfSize:13];
    rmtjLabel.textAlignment = NSTextAlignmentLeft;
    [rmtjView addSubview:rmtjLabel];
    
    [headerView addSubview:rmtjView];
    
    nY += rmtjH;
    headerView.frame = CGRectMake(0, 0, rect.size.width, nY);
    gridMainView = [[GridMainView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 64 - 49)];
    gridMainView.delegate = self;
    [gridMainView setHeaderView:headerView];
    
    tLyCollectionView = gridMainView.tCollectionView;
    [tLyCollectionView setNeedBottomFlush];
    [tLyCollectionView setNeedTopFlush];
    tLyCollectionView.lyDelegate = self;
    
    [self.view addSubview:gridMainView];
    
    [self initLastData];
//    StarCommendView *sc = [[StarCommendView alloc]init];
//    sc.frame = CGRectMake(100, 100, 75, 15);
//    [sc setNums:7.5];
//    sc.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:sc];
//    [[[HttpService sharedInstance] getRequestPosterList:self] startAsynchronous];
//    [[[HttpService sharedInstance] getRequestRecomList:self] startAsynchronous];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"首页";
    [gridMainView initFlushCtl];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!isRequestSucMark) {
        [tLyCollectionView upToStartFlush];
    }
    
}


//persistence
-(void)initLastData{
    NSArray *tmpRecArrs = [[NSArray alloc]initWithContentsOfFile:PathDocFile(IndexRecomList)];
    if (tmpRecArrs && tmpRecArrs.count>0) {
        tRecommendList = [RecommendItem getRecommendItemsWithArr:tmpRecArrs];
        [gridMainView setDataArr:tRecommendList];
    }
    NSArray* tmpArr = [[NSArray alloc]initWithContentsOfFile:PathDocFile(IndexPosterList)];
    if (tmpArr && tmpArr.count>0) {
        NSArray *tmpRecArrs = [PosterItem getPosterItemsWithArr:tmpArr];
        [circulaScrollView setPostersData:tmpRecArrs];
    }
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
            ServiceMenuComViewController *scv = [[ServiceMenuComViewController alloc]initWithLevel:ServiceFirst title:@"周边"];
            [self.navigationController pushViewController:scv animated:YES];
            break;
        }
        case 2:{
//            XT_SHOWALERT(@"该功能暂不开放");
//            [SVProgressHUD showWithStatus:@"该功能暂不开放"];
            [SVProgressHUD showErrorWithStatus:@"该功能暂不开放" duration:1.5];
            
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

#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    [[[HttpService sharedInstance] getRequestPosterList:self] startAsynchronous];
    
    [[[HttpService sharedInstance] getRequestRecomList:self] startAsynchronous];
}
- (void)startToFlushDown:(NSObject *)ly{
    [[[HttpService sharedInstance] getRequestPosterList:self] startAsynchronous];
    
    [[[HttpService sharedInstance] getRequestRecomList:self] startAsynchronous];
}
#pragma mark - GridMainViewDelegate
- (void)gridMainView:(GridMainView *)mainView{
    
//    [self.navigationController pushViewController:[[TicketQueryViewController alloc]init] animated:YES];
    NSLog(@"GridMainViewDelegate");
    int tSelectedIndex = (int)mainView.tIndexPath.row;
    if (tRecommendList.count <=tSelectedIndex) {
        return;
    }
    if (tRecommendList) {
        RecommendItem *ri = [tRecommendList objectAtIndex:tSelectedIndex];
        InfoViewController *iv = [[InfoViewController alloc]initWithUrl:ri.recomUrl title:@"热门活动"];
        [self.navigationController pushViewController:iv animated:YES];
        return;
    }
    
    InfoViewController *iv = [[InfoViewController alloc]initWithUrl:@"http://www.baidu.com" title:@"百度"];
    [self.navigationController pushViewController:iv animated:YES];

}
#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        case HttpRequestType_XT_POSTERLIST:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    isRequestSucMark = YES;
                    NSDictionary *tmpDic = (NSDictionary *)br.data;
                    NSArray *posterList = [tmpDic objectForKey:IndexPosterList];//@"posterList"
                    if (posterList) {
                        NSArray *pArr = [PosterItem getPosterItemsWithArr:posterList];
                        
                        if (pArr.count>0) {
                            [posterList writeToFile:PathDocFile(IndexPosterList) atomically:YES];
                            [circulaScrollView setPostersData:pArr];
                        }
                    }
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
            }
            [tLyCollectionView flushDoneStatus:NO];
            break;
        }
        case HttpRequestType_XT_RECOMMENDLIST:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    isRequestSucMark = YES;
                    NSDictionary *tmpDic = (NSDictionary *)br.data;
                    NSArray *tmpArr = [tmpDic objectForKey:IndexRecomList];
                    if (tmpArr== nil || tmpArr.count == 0) {
                        return;
                    }
                    if (tmpArr) {
                        tRecommendList = [RecommendItem getRecommendItemsWithArr:tmpArr];
                        if (tRecommendList.count>0) {
                            [tmpArr writeToFile:PathDocFile(IndexRecomList) atomically:YES];
                            [gridMainView setDataArr:tRecommendList];
                        }
                    }
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
            }
            [tLyCollectionView flushDoneStatus:NO];
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
