
#import "CustomMenuTutorialController.h"
#import "PublicDefine.h"
#import "MainTabBarViewController.h"
#import "CustomNavigationController.h"
#import "AppDelegate.h"
@interface CustomMenuTutorialController ()
{
    int screenWidth;
}
-(void)into:(id)sender;
@end

@implementation CustomMenuTutorialController



-(void)setItutorialNum:(int)num{
    iTutorialNum = num;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setItutorialNum:4];
    [self initLayout];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
//    UIEdgeInsets ei = tutorialView.contentInset;
    
    tutorialView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)initLayout{
    //applicationFrame = origin=(x=0, y=20) size=(width=320, height=548)
    //3d4456
    self.view.backgroundColor = _rgb2uic(0x3d4456, 1);
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    CGRect bounds = [UIScreen mainScreen].bounds;
    screenWidth = applicationFrame.size.width;
    CGRect sRect = bounds;
    tutorialView = [[UIScrollView alloc] initWithFrame:sRect];//CGRectMake(0, 0, sRect.size.width, sRect.size.height)
    tutorialView.pagingEnabled = YES;
    tutorialView.showsHorizontalScrollIndicator = NO;
    tutorialView.showsVerticalScrollIndicator = NO;
    tutorialView.contentSize= CGSizeMake(sRect.size.width * iTutorialNum, sRect.size.height);
    tutorialView.delegate = self;
    tutorialView.backgroundColor = [UIColor redColor];
    tutorialView.bounces = NO;
    [self.view addSubview:tutorialView];
    tutorialView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, sRect.size.height - 50, sRect.size.width, 30)];
    pageControl.numberOfPages = iTutorialNum;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
//    UIEdgeInsets ei = tutorialView.contentInset;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

    for ( int  i = 1; i<=iTutorialNum; i++) {

        UIImage *tmpImg = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",i]];
        UIImageView *tmpImageView = [[UIImageView alloc] init];
        tmpImageView.image = tmpImg;
        tmpImageView.frame = CGRectMake((i-1)*sRect.size.width, 0, sRect.size.width, sRect.size.height);
        
        [tutorialView addSubview:tmpImageView];
        if (i == iTutorialNum) {
            
            
            UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnDone setTitleColor:_rgb2uic(0xec2c2c, 1) forState:UIControlStateNormal];
            [btnDone setTitle:@"立即开始" forState:UIControlStateNormal];
            btnDone.titleLabel.font = [UIFont systemFontOfSize:20];
            //ffecec
            btnDone.backgroundColor = _rgb2uic(0xffecec, 1);
//            btnDone.layer.borderColor = [UIColor whiteColor].CGColor;
//            btnDone.layer.borderWidth = 1;
            btnDone.layer.cornerRadius = 20;
            [btnDone addTarget:self action:@selector(into:) forControlEvents:UIControlEventTouchUpInside];
            
            btnDone.frame  = CGRectMake(100, 100, 240, 40);
            btnDone.center = CGPointMake((i-1)*sRect.size.width + applicationFrame.size.width/2, applicationFrame.size.height - 100);
            
            [tutorialView addSubview:btnDone];
        }
    }
}

-(void)changePage:(id)sender{
    NSLog(@"changePage");
    int index = (int)pageControl.currentPage;
    [tutorialView setContentOffset:CGPointMake(screenWidth*index, 0) animated:YES];
}

-(void)into:(id)sender{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:GuideMark];
    MainTabBarViewController *mTabBar = [[MainTabBarViewController alloc]init];
    CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:mTabBar];
    nav.interactivePopGestureRecognizer.enabled = NO;
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = nav;
}

#pragma mark - scrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidEndDecelerating:%f",scrollView.contentOffset.x);
    int index = scrollView.contentOffset.x / screenWidth;
    pageControl.currentPage = index;
}


#pragma mark - dealloc
-(void)dealloc{
    NSLog(@"CustomMenuTutorialController dealloc");
    
}

@end
