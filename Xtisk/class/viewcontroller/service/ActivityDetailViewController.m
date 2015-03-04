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
@interface ActivityDetailViewController ()
{
    NSTimer *timer;
}
-(void)flushUIData;
@end

@implementation ActivityDetailViewController


-(id)initWithType:(int)t{
    self = [super init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动详情";
    [self loadRemoteUrl:@"http://www.sina.com.cn"];
    
    
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
    
    UIButton *btnTmp = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTmp.frame = CGRectMake(100, 100, 100, 100);
    btnTmp.backgroundColor = [UIColor orangeColor];
    [btnTmp addTarget:self action:@selector(toBrowCommendList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTmp];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(judgeTimeOut) userInfo:nil repeats:NO];
    [SVProgressHUD showWithStatus:@"正在加载..." ];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.title = self.mActivityItem.activityTitle;
    
    if (!isRequestSucMark) {
        [[[HttpService sharedInstance] getRequestActivityDetail:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];
    }
    
    [self flushUIData];
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self judgeTimeOut];
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


-(void)flushUIData{
    [self.btnCommend setTitle:int2str(self.mActivityItem.reviews) forState:UIControlStateNormal];
    [self.btnPraise setTitle:int2str(self.mActivityItem.favorite) forState:UIControlStateNormal];
    
    if (![[SettingService sharedInstance] isLogin]) {
        return;
    }
    //点赞判断
    
    if (self.mActivityItem.isFavorite) {
        [self.btnPraise setImage:[UIImage imageNamed:@"heart_good_yes"] forState:UIControlStateNormal];
    }else{
        [self.btnPraise setImage:[UIImage imageNamed:@"heart_good_no"] forState:UIControlStateNormal];
    }
    
    //是否允许评论
    self.btnSignUp.enabled = YES;
    self.btnSignUp.alpha = 1;
    if (self.mActivityItem.allowReview) {
        self.btnCommend.enabled = YES;
        self.btnCommend.alpha = 1.0;
    }else{
        self.btnCommend.enabled = NO;
        self.btnCommend.alpha = DefaultEnableAlhpe;
    }
    
    //是否允许报名
    if (self.mActivityItem.isJoin) {
        [self.btnSignUp setTitle:@"查看报名信息" forState:UIControlStateNormal];
    }else if (self.mActivityItem.allowJoin){
        [self.btnSignUp setTitle:@"我要报名" forState:UIControlStateNormal];
    }else if (!self.mActivityItem.allowJoin){
        [self.btnSignUp setTitle:@"报名已结束" forState:UIControlStateNormal];
        self.btnSignUp.enabled = NO;
        self.btnSignUp.alpha = DefaultEnableAlhpe;
    }else if (!self.mActivityItem.isFull){
        [self.btnSignUp setTitle:@"报名已满" forState:UIControlStateNormal];
        self.btnSignUp.enabled = NO;
        self.btnSignUp.alpha = DefaultEnableAlhpe;
    }
}

- (void)loadRemoteUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest:request];
    
}

-(void)toShare{
    NSLog(@"toShare");
    [UMSocialWechatHandler setWXAppId:IshekouWXAppId appSecret:IshekouWXAppSecret url:@"http://code4app.com/"];
    NSArray *tmpArr = @[UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite];
    NSString *shareText = @"程序员最 傻逼 的事情就是：重复造轮子。我们不需要造轮子，我们应该将我们的聪明才智发挥到其他更 牛逼 的创意上去。所以，我们做了 Code4App。 http://code4app.com/";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"service_icon_near"];          //分享内嵌图片
    
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
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        lv.delegate = self;
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    EditTextViewController *ec = [[EditTextViewController alloc]initWithType:PrivateEditTextActivity delegate:nil];
    ec.activityId = self.mActivityItem.activityId;
    [self.navigationController pushViewController:ec animated:YES];
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
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                //                if (!data || data.length <2000) {
                //                    NSLog(@"请求图片失败");
                //                    [request requestAgain];
                //                    return;
                //                }
                NSLog(@"img.len:%d",(int)data.length);
                
                
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
