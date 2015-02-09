

#import "SecondaryViewController.h"


@interface InfoViewController : SecondaryViewController<UIWebViewDelegate>
{
    UIWebView * webView;
    
}
@property (nonatomic, strong) NSString * tTitle;
@property (nonatomic, strong) NSString * tUrl;

- (void)loadRemoteUrl:(NSString *)urlString;

-(id)initWithUrl:(NSString *)urlString;
-(id)initWithUrl:(NSString *)urlString title:(NSString *)title;
@end
