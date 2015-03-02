
#import "InfoViewController.h"
#import "PublicDefine.h"
@interface InfoViewController ()
{
    NSTimer *timer;
}
@end

@implementation InfoViewController
@synthesize tTitle, tUrl;
-(id)initWithUrl:(NSString *)urlString{
    self = [super init];
    self.tUrl = urlString;
    self.tTitle = @"信息";
    return self;
}
-(id)initWithUrl:(NSString *)urlString title:(NSString *)tl{
    self = [super init];
    self.tUrl = urlString;
    self.tTitle = tl;
    return self;
}
-(void)dealloc{

    NSLog(@"InfoViewController dealloc ");
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([webView isLoading]) {
        [webView stopLoading];
    }
    webView.delegate = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.tTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = bounds.size.width;
    CGFloat h = bounds.size.height - 64;

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    webView.scalesPageToFit = YES;
    webView.delegate = self;
    webView.autoresizesSubviews = YES;
	webView.autoresizingMask=UIViewAutoresizingNone;
//    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(judgeTimeOut) userInfo:nil repeats:NO];
    [self loadRemoteUrl:self.tUrl];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:@"正在加载..." ];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (void)loadRemoteUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [webView loadRequest:request];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  webviewDelegate
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网络连接错误");
//    [SVProgressHUD showErrorWithStatus:@"加载失败" duration:2];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

@end
