

#import "SecondaryViewController.h"


@interface InfoViewController : SecondaryViewController<UIWebViewDelegate>
{
    UIWebView * webView;
    
}
@property (nonatomic, strong) NSString * tTitle;
@property (nonatomic, strong) NSString * tUrl;

- (void)loadLocalFile:(NSString *)file;
- (void)loadRemoteUrl:(NSString *)urlString;

-(id)initWithUrl:(NSString *)urlString;
-(id)initWithUrl:(NSString *)urlString title:(NSString *)title;

-(id)initWithLocalUrl:(NSString *)localString title:(NSString *)title;
@end
