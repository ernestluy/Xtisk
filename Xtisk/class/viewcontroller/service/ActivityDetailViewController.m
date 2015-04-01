//
//  ActivityDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "EditTextViewController.h"
#import "PublicDefine.h"
#import "ActivitySignUpViewController.h"
#import "LoginViewController.h"
#import "ComCommendViewController.h"
#import "CommentPad.h"
@interface ActivityDetailViewController ()
{
    NSTimer *timer;
    CommentPad *commentPad;
    
    NSTimer *uiTimer;
}
-(void)flushUIData;
@end

@implementation ActivityDetailViewController


-(id)initWithType:(int)t{
    self = [super init];
    
    return self;
}

-(void)dealloc{
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动详情";
//    [self loadRemoteUrl:@"http://www.sina.com.cn"];
    
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    self.btnCommend.layer.borderColor = _rgb2uic(0xe1e1e1, 1).CGColor;
    self.btnCommend.layer.borderWidth = 1;
    
    self.btnPraise.layer.borderColor = _rgb2uic(0xe1e1e1, 1).CGColor;
    self.btnPraise.layer.borderWidth = 1;
    
    self.webView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64 - 50);
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 20, 20);
    [okBtn setBackgroundImage:[UIImage imageNamed:@"share_arrow"] forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * ritem = [[UIBarButtonItem alloc] initWithCustomView:okBtn] ;
    [self.navigationItem setRightBarButtonItem:ritem];
    
//    UIButton *btnTmp = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnTmp.frame = CGRectMake(100, 100, 100, 100);
//    btnTmp.backgroundColor = [UIColor orangeColor];
//    [btnTmp addTarget:self action:@selector(toBrowCommendList:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnTmp];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(judgeTimeOut) userInfo:nil repeats:NO];
    [SVProgressHUD showWithStatus:@"正在加载..." ];
    
    commentPad = [[CommentPad alloc] init];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if (self.titleShowType == 0) {
        self.title = self.mActivityItem.activityTitle;
    }
    self.title = @"活动详情";
    
    if (!isRequestSucMark) {
        [[[HttpService sharedInstance] getRequestActivityDetail:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];
    }else{
        [[[HttpService sharedInstance] getRequestActivityDetail:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];
    }
    
    [self flushUIData];
    
    
    [self startTimer];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self judgeTimeOut];
    [self stopTimer];
}
-(void)judgeTimeOut{
    if (timer) {
        if ([timer isValid]) {
            [timer invalidate];
            timer = nil;
        }
    }
    [SVProgressHUD dismiss];
}

-(void)startTimer{
    [self stopTimer];
    uiTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(flushUIData) userInfo:nil repeats:YES];
}

-(void)stopTimer{
    if (uiTimer) {
        if ([uiTimer isValid]) {
            [uiTimer invalidate];
            uiTimer = nil;
        }
    }
}


-(void)flushUIData{
    NSLog(@"flushUIData");
    [self.btnCommend setTitle:int2str(self.mActivityItem.reviews) forState:UIControlStateNormal];
    [self.btnPraise setTitle:int2str(self.mActivityItem.favorite) forState:UIControlStateNormal];
    
    self.btnSignUp.enabled = YES;
    self.btnSignUp.hidden = NO;
    self.btnSignUp.alpha = 1;
    //是否允许报名
    if (!self.mActivityItem.allowJoin){
        [self.btnSignUp setTitle:@"不允许报名" forState:UIControlStateNormal];
        self.btnSignUp.enabled = NO;
        self.btnSignUp.alpha = DefaultEnableAlhpe;
        
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
        }
        
        if (self.mActivityItem.activityBeginJoinTime) {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *nDate = nil;
            if([SettingService sharedInstance].strTime){
                nDate = [dateFormatter dateFromString:[SettingService sharedInstance].strTime];
            }
            if(nDate == nil){
                nDate = [NSDate date];
            }
            
            NSDate *bjDate = [dateFormatter dateFromString:self.mActivityItem.activityBeginJoinTime];
            NSString *strLog = [NSString stringWithFormat:@"nDate:%@,joinTime:%@",[dateFormatter stringFromDate:nDate],self.mActivityItem.activityBeginJoinTime];
            PRINT_LOG([strLog UTF8String]);
            NSComparisonResult r = [nDate compare:bjDate];
            if (bjDate == nil) {
                PRINT_LOG("bjDate is nil.");
            }
            if (NSOrderedDescending == r) {
                //当前时间比报名时间晚
                PRINT_LOG("报名已结束");
                [self.btnSignUp setTitle:@"报名已结束" forState:UIControlStateNormal];
            }else{
                PRINT_LOG("未到报名时间");
                [self.btnSignUp setTitle:@"未到报名时间" forState:UIControlStateNormal];
            }
        }else{
            PRINT_LOG("报名时间是空的");
            self.btnSignUp.hidden = YES;
        }
//        if (!self.mActivityItem.isFull){
//            [self.btnSignUp setTitle:@"报名已满" forState:UIControlStateNormal];
//            self.btnSignUp.enabled = NO;
//            self.btnSignUp.alpha = DefaultEnableAlhpe;
//        }
        
        
//        [@"2014-3-12" compare:@"2015-2-2"];
        
    }else if (self.mActivityItem.isJoin) {
        [self.btnSignUp setTitle:@"查看报名信息" forState:UIControlStateNormal];
    }else if (self.mActivityItem.allowJoin){
        [self.btnSignUp setTitle:@"我要报名" forState:UIControlStateNormal];
    }
    
    if (![[SettingService sharedInstance] isLogin]) {
        return;
    }
    //点赞判断
    
    if (self.mActivityItem.isFavorite) {
        [self.btnPraise setImage:[UIImage imageNamed:@"heart_good_yes"] forState:UIControlStateNormal];
        [self.btnPraise setTitleColor:_rgb2uic(0xed4d1c, 1) forState:UIControlStateNormal];
    }else{
        [self.btnPraise setImage:[UIImage imageNamed:@"heart_good_no"] forState:UIControlStateNormal];
        //_rgb2uic(0x808080, 1)
        [self.btnPraise setTitleColor:defaultTextGrayColor forState:UIControlStateNormal];
    }
    
    //是否允许评论
    
//    if (self.mActivityItem.allowReview) {
//        self.btnCommend.enabled = YES;
//        self.btnCommend.alpha = 1.0;
//    }else{
//        self.btnCommend.enabled = NO;
//        self.btnCommend.alpha = DefaultEnableAlhpe;
//    }
    
    
    
}

- (void)loadRemoteUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest:request];
    
}

-(void)toShare{
    NSLog(@"toShare");
    NSString *tUrl = [NSString stringWithFormat:@"http://%@/%@",SERVICE_HOME,self.mActivityItem.shareUrl];
    if (!self.mActivityItem.shareUrl || self.mActivityItem.shareUrl.length<5) {
        tUrl = @"http://udm.ishekou.com:82/DownloadAction!toDownloadPage.action";
    }
    
    [UMSocialWechatHandler setWXAppId:IshekouWXAppId appSecret:IshekouWXAppSecret url:tUrl];
    NSArray *tmpArr = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToTencent,UMShareToQzone];
    NSString *shareText = self.mActivityItem.activityTitle;             //分享内嵌文字
//    UIImage *shareImage = [UIImage imageNamed:@"service_icon_near"];          //分享内嵌图片
    UIImage *shareImage = [XTFileManager getTmpFolderFileWithUrlPath:self.mActivityItem.activityPic];
    if (!shareImage) {
        shareImage = [UIImage imageNamed:@"index_header_icon"];
    }
    
    [Util snsShareInitDataWith:shareText url:tUrl];

    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:tmpArr
                                       delegate:self];
}


-(IBAction)toSignUp:(id)sender{
    NSLog(@"toSignUp");
    

    
    
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        lv.delegate = self;
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    
    //是否允许报名
    if (self.mActivityItem.isJoin) {
        //        [self.btnSignUp setTitle:@"查看报名信息" forState:UIControlStateNormal];
        ActivitySignUpViewController *as = [[ActivitySignUpViewController alloc]init];
        as.signUpInfoType = ActivityVcBrow;
        as.mActivityItem = self.mActivityItem;
        [self.navigationController pushViewController:as animated:YES];
        return;
    }else if (self.mActivityItem.allowJoin){
        //        [self.btnSignUp setTitle:@"我要报名" forState:UIControlStateNormal];
        ActivitySignUpViewController *as = [[ActivitySignUpViewController alloc]init];
        as.signUpInfoType = ActivityVcSignUp;
        as.mActivityItem = self.mActivityItem;
        [self.navigationController pushViewController:as animated:YES];
        return;
    }else if (!self.mActivityItem.allowJoin){
        //        [self.btnSignUp setTitle:@"报名已结束" forState:UIControlStateNormal];
        //        self.btnSignUp.enabled = NO;
        //        self.btnSignUp.alpha = DefaultEnableAlhpe;
    }else if (!self.mActivityItem.isFull){
        //        [self.btnSignUp setTitle:@"报名已满" forState:UIControlStateNormal];
        //        self.btnSignUp.enabled = NO;
        //        self.btnSignUp.alpha = DefaultEnableAlhpe;
    }
    
    
//    ActivitySignUpViewController *as = [[ActivitySignUpViewController alloc]init];
//    [self.navigationController pushViewController:as animated:YES];
}
-(IBAction)toPraise:(id)sender{
    NSLog(@"toPraise");
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        lv.delegate = self;
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    
    
    [[[HttpService sharedInstance] getRequestFavoriteActivity:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];
    
}
-(IBAction)toCommend:(id)sender{
    NSLog(@"toCommend");
    
    ComCommendViewController *ccc = [[ComCommendViewController alloc]init];
    ccc.activityId = self.mActivityItem.activityId;
    ccc.vcType = CommendVcActivity;
    ccc.mActivityItem = self.mActivityItem;
    [self.navigationController pushViewController:ccc animated:YES];
    

    
//    if (![[SettingService sharedInstance] isLogin]) {
//        LoginViewController *lv = [[LoginViewController alloc]init];
//        lv.delegate = self;
//        [self.navigationController pushViewController:lv animated:YES];
//        return;
//    }
//    EditTextViewController *ec = [[EditTextViewController alloc]initWithType:PrivateEditTextActivity delegate:nil];
//    ec.activityId = self.mActivityItem.activityId;
//    ec.mActivityItem = self.mActivityItem;
//    [self.navigationController pushViewController:ec animated:YES];
}

-(IBAction)toBrowCommendList:(id)sender{
    ComCommendViewController *ccc = [[ComCommendViewController alloc]init];
    ccc.activityId = self.mActivityItem.activityId;
    ccc.vcType = CommendVcActivity;
    [self.navigationController pushViewController:ccc animated:YES];
}

#pragma mark - LoginViewControllerDelegate
- (void)loginSucBack:(LoginViewController *)loginVc{
    [[[HttpService sharedInstance] getRequestActivityDetail:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];
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

#pragma mark -  webviewDelegate
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网络连接错误");
    [SVProgressHUD showErrorWithStatus:@"加载失败" duration:2];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}




#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
//                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;

//                NSLog(@"img.len:%d",(int)data.length);
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_ACTIVITYDETAIL:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    isRequestSucMark = YES;
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    ActivityItem *ai = [ActivityItem getActivityItemWithDic:dic];
                    if (ai) {
                        self.mActivityItem = ai;
                        NSString *tUrl = [NSString stringWithFormat:@"http://%@/%@",SERVICE_HOME,self.mActivityItem.shareUrl];
                        [self loadRemoteUrl:tUrl];
                    }
                    [self flushUIData];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_FAVORITEACTIVITY:{
            
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"点赞请求成功");
                    //                    [[[HttpService sharedInstance] getRequestQueryStoreDetail:self storeId:int2str(self.mStoreItem.storeId)]startAsynchronous];
                    //{"favoritePeople":2,"isFavorite":true}
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        self.mActivityItem.favorite = [[dic objectForKey:@"favoritePeople"] intValue];
                        self.mActivityItem.isFavorite = [[dic objectForKey:@"isFavorite"] boolValue];
                    }
                    [self flushUIData];
                    NSString *strNote = @"点赞成功";
                    if (!self.mActivityItem.isFavorite) {
                        strNote = @"已经取消点赞";
                    }
                    [SVProgressHUD showSuccessWithStatus:strNote duration:DefaultRequestDonePromptTime];
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
