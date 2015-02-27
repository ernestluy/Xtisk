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
@interface ActivityDetailViewController ()
{
    NSTimer *timer;
}
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
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(judgeTimeOut) userInfo:nil repeats:NO];
    [SVProgressHUD showWithStatus:@"正在加载..." ];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    ActivitySignUpViewController *as = [[ActivitySignUpViewController alloc]init];
    [self.navigationController pushViewController:as animated:YES];
}
-(IBAction)toPraise:(id)sender{
    NSLog(@"toPraise");
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
}
-(IBAction)toCommend:(id)sender{
    NSLog(@"toCommend");
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    EditTextViewController *ec = [[EditTextViewController alloc]initWithType:PrivateEditTextFoodCommend delegate:nil];
    [self.navigationController pushViewController:ec animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
