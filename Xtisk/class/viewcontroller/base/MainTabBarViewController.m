//
//  MainViewController.m
//  TestTabBarController
//
//  Created by 兴天科技 on 13-4-2.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "Util.h"
#import "PublicDefine.h"
#import "IndexTabViewController.h"
#import "MessageTabViewController.h"
#import "ServiceTabViewController.h"
#import "MoreTabViewController.h"
#import "SettingService.h"
#import "LoginViewController.h"
#import "DBManager.h"
#import "MessageDBManager.h"
#import "MsgPlaySound.h"
#import "MessageListViewController.h"
typedef enum {
    TAB_BAR_INDEX = 0,
    TAB_BAR_MSG,
    TAB_BAR_SERVICE,
    TAB_BAR_MORE,
}TabBarIndex;

@interface MainTabBarViewController ()
{
    UIView *tTitleView;
    UIImageView *tImgView;
    
    UIViewController *msgVc;
    
    BOOL isRequestSuc;
}
@end

@implementation MainTabBarViewController

- (id)init
{
    self = [super init];
    if (self) {
     
        m_selectedIndex=-1;
        tTitleView = nil;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"MainTabBarViewController dealloc");
}
-(void)viewDidUnload{
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (tTitleView == nil) {
//        tTitleView = self.navigationController.navigationBar.topItem.titleView;
//    }
    if (self.selectedIndex == 0) {
        [self.navigationController.navigationBar.topItem setTitleView:tImgView];
    }
    
//    if (!isRequestSuc && [[SettingService sharedInstance] isLogin]) {
//        [self requestMsgData];
//    }
}
- (void)viewDidLoad
{

    [super viewDidLoad];
    isRequestSuc = NO;
    
    tImgView = [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"index_header_icon"];
    tImgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    tImgView.image = image;
    
    NSMutableArray *baritems = [NSMutableArray array];

    NSArray *xibArray = [NSArray arrayWithObjects:@"IndexTabViewController",@"MessageTabViewController",@"ServiceTabViewController",@"MoreTabViewController", nil];
    NSArray *tabBarItemBg = [NSArray arrayWithObjects:@"icon_index.png",@"icon_msg.png",@"icon_service.png",@"icon_more.png", nil];
    NSArray *tabBarItemSelectedBg = [NSArray arrayWithObjects:@"icon_index_selected.png",@"icon_msg_selected.png",@"icon_service_selected.png",@"icon_more_selected.png", nil];
    NSArray *btnName = [NSArray arrayWithObjects:@"首页",@"消息",@"服务",@"我的",nil];
    for (int i = 0; i<[xibArray count]; i++) {
        UIViewController *ctl =nil;
        if (i == TAB_BAR_INDEX) {
            ctl = [[IndexTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }else if(i == TAB_BAR_MSG){
            ctl = [[MessageTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
            msgVc = ctl;
        }else if(i == TAB_BAR_SERVICE){
            
            ctl = [[ServiceTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }else if(i == TAB_BAR_MORE){
            ctl = [[MoreTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }
        
//        ctl.title = [tabBarItemBg objectAtIndex:i];
        UIImage *imageBg = [UIImage imageNamed:[tabBarItemBg objectAtIndex:i]];
        UIImage *imageSelectedBg = [UIImage imageNamed:[tabBarItemSelectedBg objectAtIndex:i]];
//        UITabBarItem *item = [[UITabBarItem alloc] init] ;
//        item.tag = i;
//        item.title = [btnName objectAtIndex:i];
//        [item setFinishedSelectedImage:imageSelectedBg withFinishedUnselectedImage:imageBg];
//        UIColor *selectedColor = [UIColor colorWithRed:71.0/255.0 green:94.0/255.0 blue:136.0/255.0 alpha:1.0];
//        [item setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor redColor] } forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{ UITextAttributeTextColor : selectedColor } forState:UIControlStateHighlighted];
//        ctl.tabBarItem  = item;
        
//        ctl.tabBarItem = [[UITabBarItem alloc] initWithTitle:[btnName objectAtIndex:i] image:imageBg tag:i];
        ctl.tabBarItem = [[UITabBarItem alloc] initWithTitle:[btnName objectAtIndex:i] image:imageBg selectedImage:imageSelectedBg];
//        ctl.tabBarItem.badgeValue = @"100";
        ctl.tabBarItem.tag = i;
        [baritems addObject:ctl];
        
    }
    

    
    
    self.delegate = self;
    self.viewControllers = baritems;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        [self.tabBar setTintColor:headerColor];
//    }else{
//        [self.tabBar setTintColor:_rgb2uic(0xFFFFFF, 1)];
//        [self.tabBar setSelectedImageTintColor:headerColor];
//        self.tabBar.shadowImage = nil;
//    }
    
    [self.tabBar setTintColor:_rgb2uic(0x0095f1, 1)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealRemoteMsg) name:kPushMessageReceiveRemote object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealTicketOrderMsg) name:kTicketOrderGeneration object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTabBadge) name:kPushMessageFlush object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealLogout) name:kLogout object:nil];
    
}

-(void)setTabBadge{
    NSLog(@"setTabBadge");
    int unReadMsg = [DBManager queryCountUnReadMsgWithAccount:[SettingService sharedInstance].iUser.phone];
    [SettingService sharedInstance].badgeMsg = unReadMsg;
    int allUnRead = [SettingService sharedInstance].badgeTicket + [SettingService sharedInstance].badgeMsg;
    if (allUnRead == 0) {
        msgVc.tabBarItem.badgeValue = nil;
    }else{
        [[MsgPlaySound sharedInstance] playReceiveMsg];
        
        msgVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",allUnRead];
    }
}

-(void)dealLogout{
    msgVc.tabBarItem.badgeValue = nil;
}

-(void)requestMsgData{
    [[[HttpService sharedInstance] getRequestGetUserUnreadMsg:self type:@""]startAsynchronous];
}
-(void)dealRemoteMsg{
    NSLog(@"dealRemoteMsg");
    if (![[SettingService sharedInstance] isLogin]) {
        
        return;
    }
    //如果当前处于查看ishekou消息状况下
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MessageListViewController class]]) {
            NSLog(@"当前处于聊天状态，此处不处理");
            return;
        }
    }
//    [self setTabBadge];
    [self requestMsgData];
}
-(void)dealTicketOrderMsg{
    NSLog(@"dealTicketOrderMsg");
    if (![[SettingService sharedInstance] isLogin]) {
        return;
    }
}
-(void)doubleClick:(UIViewController *)controller{
    int index = (int)controller.tabBarItem.tag;
    //NSLog(@"didSelectViewController:%d",index);
    if (m_selectedIndex == index  && m_selectedIndex == TAB_BAR_INDEX) {
        
    }
    
    m_selectedIndex = index;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"didSelectViewController");
//    [self doubleClick:viewController];
    if((int)viewController.tabBarItem.tag == TAB_BAR_INDEX){
        
        [self.navigationController.navigationBar.topItem setTitleView:tImgView];
    }else{
        [self.navigationController.navigationBar.topItem setTitleView:nil];
    }
}

#pragma mark - LoginViewControllerDelegate
- (void)loginSucBack:(LoginViewController *)loginVc{
    if (loginVc.tType == INTO_TAB_MSG) {
        [self setSelectedIndex:TAB_BAR_MSG];
    }
}
#pragma mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
//    NSLog(@"shouldSelectViewController");
    if((int)viewController.tabBarItem.tag == TAB_BAR_MSG){
        if([[SettingService sharedInstance] isLogin]){
            return YES;
        }else{
            LoginViewController *lv = [[LoginViewController alloc]initWithType:INTO_TAB_MSG];
            lv.delegate = self;
            [self.navigationController pushViewController:lv animated:YES];
            return NO;
        }
        
    }
    return YES;
}



#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                //                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <DefaultImageMinSize) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                //                UIImage *rImage = [UIImage imageWithData:data];
                //                StoreItem *tmpStroeItem = [mDataArr objectAtIndex:ir.indexPath.row];
                //                [XTFileManager saveTmpFolderFileWithUrlPath:tmpStroeItem.storeMiniPic with:rImage];
                //                FoodListTableViewCell  * pc = (FoodListTableViewCell * )[self.tTableView cellForRowAtIndexPath:ir.indexPath];
                //                if (pc) {
                //                    pc.imgHeader.contentMode = DefaultImageViewContentMode;
                //                    pc.imgHeader.image = rImage;
                //                }
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_GET_USER_UNREAD_MSG:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    isRequestSuc = YES;
                    NSArray *tmpArr = (NSArray *)br.data;
                    if (tmpArr) {
                        NSArray *msgArr = [PushMessageItem getPushMessageItemsWithArr:tmpArr];
                        int intSuc = [DBManager insertPushMessageItems:msgArr];
                        NSLog(@"intSuc:%d",intSuc);
                        [[NSNotificationCenter defaultCenter]postNotificationName:kPushMessageFlush object:nil];
                        
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        default:
            break;
    }
}

@end


