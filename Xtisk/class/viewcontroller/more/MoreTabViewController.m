//
//  MoreTabViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MoreTabViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
#import "MoreTableViewHeaderView.h"
#import "CTLCustom.h"
#import "SettingService.h"
#import "QRCodeScanViewController.h"
#import "PrivateViewController.h"
#import "SettingViewController.h"

#import "UMSocialScreenShoter.h"

#import "BaiduMapViewController.h"
#import "GeocodeDemoViewController.h"
#import "MyActivityViewController.h"
#import "MyTicketViewController.h"
#import "LogViewerController.h"
#define MORE_HEIGHT 44.0
#define REQUEST_HEADER_TAG 88
@interface MoreTabViewController ()
{
    NSArray *titleArr;
    NSArray *imgArr;
    MoreTableViewHeaderView *outHeaderView;
    MoreTableViewHeaderView *inHeaderView;
}
@end

@implementation MoreTabViewController
@synthesize tTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tTableView.bounces = NO;
    titleArr = @[@"船票订单",@"我的活动",@"推荐给好友",@"扫一扫",@"设置"];
    imgArr = @[@"more_cell_ticket_icon",@"more_cell_activity_icon",@"more_cell_recommend_icon",@"more_cell_scan_icon",@"more_cell_setting_icon"];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MoreTableViewHeaderView" owner:self options:nil];
    for (UIView *tmpCustomView in nib) {
        
        if (tmpCustomView && tmpCustomView.tag == 0 && [tmpCustomView isKindOfClass:[MoreTableViewHeaderView class]]) {
            outHeaderView = (MoreTableViewHeaderView*)tmpCustomView;
            [CTLCustom setButtonRadius:outHeaderView.btnLogin];
            [outHeaderView.btnLogin addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
        }else if (tmpCustomView && tmpCustomView.tag == 1 && [tmpCustomView isKindOfClass:[MoreTableViewHeaderView class]]) {
            inHeaderView = (MoreTableViewHeaderView*)tmpCustomView;
            inHeaderView.backgroundColor = [UIColor lightGrayColor];
            [inHeaderView.inBtnReset addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
            CGRect rect = inHeaderView.inLine.frame;
            inHeaderView.inLine.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 0.4);
        }
    }
    if ([[SettingService sharedInstance] isLogin]) {
        self.tTableView.tableHeaderView = inHeaderView;
        [inHeaderView inSetDataWith:[SettingService sharedInstance].iUser];
    }else{
        self.tTableView.tableHeaderView = outHeaderView;
    }
    
    
    
//    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showLogView)];
//    longPressGr.minimumPressDuration = 3.0;
//    [self.view addGestureRecognizer:longPressGr];
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLogView)];
    pan.numberOfTapsRequired  = 4;
    [self.view addGestureRecognizer:pan];
}

-(void)showLogView{
    LogViewerController *lv = [[LogViewerController alloc]init] ;
    [self.navigationController pushViewController:lv animated:YES];
}

-(void)toLogin:(id)sender{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:lv animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"我的";
    
    if ([[SettingService sharedInstance] isLogin]) {
        self.tTableView.tableHeaderView = inHeaderView;
        IUser *tUser = [SettingService sharedInstance].iUser;
        [inHeaderView inSetDataWith:[SettingService sharedInstance].iUser];
        
        //判断头像是否已经下载
        if (tUser.headImageUrl && tUser.headImageUrl.length >3) {
            inHeaderView.inImageHead.layer.masksToBounds = YES;
            inHeaderView.inImageHead.layer.cornerRadius = inHeaderView.inImageHead.frame.size.width/2;
            UIImage *tImg = [XTFileManager getDocFolderFileWithUrlPath:tUser.headImageUrl];
            if (!tImg) {
                AsyncImgDownLoadRequest *request = [[HttpService sharedInstance] getImgRequest:self url:tUser.headImageUrl];
                request.tTag = REQUEST_HEADER_TAG;
                [request startAsynchronous];
            }else{
                inHeaderView.inImageHead.contentMode = DefaultImageViewContentMode;
                
                inHeaderView.inImageHead.image = tImg;
            }
        }
        
    }else{
        self.tTableView.tableHeaderView = outHeaderView;
    }
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
-(IBAction)settingAction:(id)sender{
    PrivateViewController *pv = [[PrivateViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArr.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"cell";
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = [titleArr objectAtIndex:(int)indexPath.section];
    cell.imageView.image = [UIImage imageNamed:[imgArr objectAtIndex:(int)indexPath.section]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, MORE_HEIGHT)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MORE_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
//            [[SettingService sharedInstance] PermissionBaiduMap];
//            BaiduMapViewController *bv = [[BaiduMapViewController alloc] initWithLong:114.056 lat:22.552];
//            [self.navigationController pushViewController:bv animated:YES];
            
            if (!authorityTicket) {
                [SVProgressHUD showSuccessWithStatus:@"即将上线，敬请期待！" duration:2];
                return;
            }
            
            if (![[SettingService sharedInstance] isLogin]){
                MyTicketViewController *mtc = [[MyTicketViewController alloc] init];
                LoginViewController *lv = [[LoginViewController alloc]initWithVc:mtc];
                [self.navigationController pushViewController:lv animated:YES];
                return;
            }
            MyTicketViewController *mtc = [[MyTicketViewController alloc] init];
            [self.navigationController pushViewController:mtc animated:YES];

            break;
        }
        case 1:{
//            GeocodeDemoViewController *gdc = [[GeocodeDemoViewController alloc] init];
//            [self.navigationController pushViewController:gdc animated:YES];
            if (![[SettingService sharedInstance] isLogin]){
                MyActivityViewController *mav = [[MyActivityViewController alloc] init];
                LoginViewController *lv = [[LoginViewController alloc]initWithVc:mav];
                [self.navigationController pushViewController:lv animated:YES];
                return;
            }
            MyActivityViewController *mav = [[MyActivityViewController alloc] init];
            [self.navigationController pushViewController:mav animated:YES];
            break;
        }
        case 2:{//分享
            NSString *tUrl = @"http://udm.ishekou.com:82/DownloadAction!toDownloadPage.action";
            [UMSocialWechatHandler setWXAppId:IshekouWXAppId appSecret:IshekouWXAppSecret url:tUrl];
            NSArray *tmpArr = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToTencent,UMShareToQzone];
            NSString *shareText = @"为蛇口网谷企业员工，提供周边订餐服务，船票服务，周边美食，园区活动，拼车等服务";             //分享内嵌文字
            UIImage *shareImage = [UIImage imageNamed:@"index_header_icon"];          //分享内嵌图片
            
            [Util snsShareInitDataWith:shareText url:tUrl];
            //调用快速分享接口
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UmengAppkey
                                              shareText:shareText
                                             shareImage:shareImage
                                        shareToSnsNames:tmpArr
                                               delegate:self];
            
            break;
        }
        case 3:{
            QRCodeScanViewController *qsc = [[QRCodeScanViewController alloc] init];
            [self.navigationController pushViewController:qsc animated:YES];
            break;
        }
        case 4:{
            
            
            SettingViewController *st = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:st animated:YES];
            break;
        }
        default:
            break;
    }
   
}


#pragma mark -  UMSocialUIDelegate  UMSocialShakeDelegate
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

//下面设置点击分享列表之后，可以直接分享
//-(BOOL)isDirectShareInIconActionSheet
//{
//    return YES;
//}

//-(UMSocialShakeConfig)didShakeWithShakeConfig
//{
//    //下面可以设置你用自己的方法来得到的截屏图片
////    [UMSocialShakeService setScreenShotImage:[UIImage imageNamed:@"UMS_social_demo"]];
//    return UMSocialShakeConfigDefault;
//}

//-(void)didCloseShakeView
//{
//    NSLog(@"didCloseShakeView");
//}

-(void)didFinishShareInShakeView:(UMSocialResponseEntity *)response
{
    NSLog(@"finish share with response is %@",response);
}

#pragma mark -  AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <DefaultImageMinSize) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];

                
                if (REQUEST_HEADER_TAG == ir.tTag) {
                    [XTFileManager saveDocFolderFileWithUrlPath:[SettingService sharedInstance].iUser.headImageUrl with:rImage];
                    inHeaderView.inImageHead.layer.cornerRadius = inHeaderView.inImageHead.frame.size.width/2;
                    inHeaderView.inImageHead.contentMode = DefaultImageViewContentMode;
                    inHeaderView.inImageHead.image = rImage;
                }
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        default:{
            break;
        }
    }
}
@end
