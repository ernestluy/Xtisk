
#import "InfoViewController.h"
@interface InfoViewController ()

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
    CGFloat h = bounds.size.height - y;

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    webView.scalesPageToFit = YES;
    webView.delegate = self;
    webView.autoresizesSubviews = YES;
	webView.autoresizingMask=UIViewAutoresizingNone;
//    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    [self loadRemoteUrl:self.tUrl];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网络连接错误");
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

@end
