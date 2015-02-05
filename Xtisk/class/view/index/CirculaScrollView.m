//
//  testScrollViewViewControllerViewController.m
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import "CirculaScrollView.h"
#import "PublicDefine.h"
@interface CirculaScrollView ()
{
    BOOL isMoving;
    NSTimer *timer;
}

-(void)stopTimer;
@end

@implementation CirculaScrollView

@synthesize scrollView, slideImages;
@synthesize text;
@synthesize pageControl,labelTitle;

-(void)dealloc{
    [self stopTimer];
}
-(void)stopTimer{
    if (timer) {
        if (timer.valid) {
            [timer invalidate];
            timer = nil;
        }
    }
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    isMoving = NO;
    slideImages = [[NSMutableArray alloc] init];
    int barHeight = 20;
    
    // 定时器 循环
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    // 初始化 scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - barHeight, frame.size.width, barHeight)];
    tmpView.backgroundColor = _rgb2uic(0x000000, 0.3);
    [self addSubview:tmpView];
    
    self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - barHeight, 220, barHeight)];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:13];
    self.labelTitle.text = @"app订船票业务上线啦";
    [self addSubview:labelTitle];
    

    // 初始化 pagecontrol
    CGRect pRect = CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - barHeight, 100, barHeight);
    self.pageControl = [[UIPageControl alloc]initWithFrame:pRect]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:headerColor];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    pageControl.numberOfPages = [self.slideImages count];
    pageControl.currentPage = 0;
    //    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self addSubview:pageControl];
    
    
    
    
    NSArray *imgArr = @[[UIImage imageNamed:@"1-1.jpg"],[UIImage imageNamed:@"1-2.jpg"],[UIImage imageNamed:@"1-3.jpg"],[UIImage imageNamed:@"1-4.jpg"]];
    [self setImageData:imgArr];
    return self;
}

-(void)setImageData:(NSArray *)imgArr{
    // 初始化 数组 并添加四张图片
    [slideImages removeAllObjects];
    [slideImages addObjectsFromArray:imgArr];
    pageControl.numberOfPages = [self.slideImages count];
    // 创建四个图片 imageview
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[slideImages objectAtIndex:i]];
        imageView.frame = CGRectMake((self.frame.size.width * i) + self.frame.size.width, 0, self.frame.size.width  , self.frame.size.height);
        [scrollView addSubview:imageView];
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[slideImages objectAtIndex:([slideImages count]-1)]];
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[slideImages objectAtIndex:0]];
    imageView.frame = CGRectMake((self.frame.size.width * ([slideImages count] + 1)) , 0, self.frame.size.width, self.frame.size.height); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(self.frame.size.width * ([slideImages count] + 2), self.frame.size.height)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
}
#pragma mark -  UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
    isMoving = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    isMoving = NO;
    int index = self.scrollView.contentOffset.x / self.frame.size.width;
    
    if (index == 0) {
        pageControl.currentPage = slideImages.count - 1;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * slideImages.count,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else if (index>slideImages.count) {
        pageControl.currentPage  = 0;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width ,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else{
        pageControl.currentPage = index - 1;
    }
    
}
#pragma mark - 
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)pageControl.currentPage; // 获取当前的page
    if (page == 0) {//从最后一页反到首页
        if (self.scrollView.contentOffset.x >0) {
            [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*(slideImages.count+1),0,self.frame.size.width,self.frame.size.height) animated:YES];
        }
    }else{
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*(page+1),0,self.frame.size.width,self.frame.size.height) animated:YES];
    }
}
// 定时器 绑定的方法
- (void)runTimePage
{
    if (isMoving) {
        //正在转动，不执行
        return;
    }
    int page = (int)pageControl.currentPage; // 获取当前的page
    page++;
    page = page >= slideImages.count ? 0 : page ;
    pageControl.currentPage = page;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentOffset.x + self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:YES];
    [self performSelector:@selector(judgeResult) withObject:nil afterDelay:0.5];
}

-(void)judgeResult{
    int index = self.scrollView.contentOffset.x / self.frame.size.width;
    
    if (index == 0) {
//        pageControl.currentPage = slideImages.count - 1;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * slideImages.count,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else if (index>slideImages.count) {
//        pageControl.currentPage  = 0;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width ,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else{
//        pageControl.currentPage = index - 1;
    }
}

@end
