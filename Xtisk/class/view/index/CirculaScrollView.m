//
//  testScrollViewViewControllerViewController.m
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import "CirculaScrollView.h"
#import "PublicDefine.h"
#import "PosterItem.h"
#import "AsyncImgDownLoadRequest.h"
@interface CirculaScrollView ()
{
    BOOL isMoving;
    NSTimer *timer;
    NSMutableArray *labArr;
    NSMutableArray *imgViewArr;
    
    NSMutableArray *dataArr;
    
    int allCount;
    int nTag;
}
-(void)selectedEnd:(int)tag;
-(void)stopTimer;
@end

@implementation CirculaScrollView

@synthesize scrollView;
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

- (void) imageViewHandlePan: (UIPanGestureRecognizer *)rec{
    NSLog(@"self.view UITapGestureRecognizer");
    int ttag = (int)rec.view.tag;

    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(didSelected:)]) {
        [self.cDelegate didSelected:[dataArr objectAtIndex:ttag]];
    }
    
}

-(void)didSelectedAction:(UIButton *)btn{
    if (dataArr.count <= btn.tag) {
        return;
    }
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(didSelected:)]) {
        [self.cDelegate didSelected:[dataArr objectAtIndex:btn.tag]];
    }
}
-(void)selectedEnd:(int)tag{
//    NSLog(@"selectedEnd");
    nTag = tag;
    
    if (dataArr && dataArr.count>nTag) {
        PosterItem *pi = [dataArr objectAtIndex:nTag];
        self.labelTitle.text = pi.posterTitle;
        
    }else{
        self.labelTitle.text = @"";
    }
    
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    isMoving = NO;
    allCount = 4;
    int barHeight = 20;
    labArr = [NSMutableArray array];
    imgViewArr = [NSMutableArray array];
    dataArr = [NSMutableArray array];
    // 定时器 循环
    nTag = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    // 初始化 scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - barHeight, frame.size.width, barHeight)];
    tmpView.backgroundColor = _rgb2uic(0xd5d5d5, 0.4);
    [self addSubview:tmpView];
    
    UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, frame.size.height - barHeight, 210, barHeight)];
    tLabel.textColor = [UIColor whiteColor];
    tLabel.font = [UIFont systemFontOfSize:13];
    tLabel.text = @"";
    self.labelTitle = tLabel;
    [self addSubview:tLabel];
    

    

    // 初始化 pagecontrol
    CGRect pRect = CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - barHeight, 100, barHeight);
    self.pageControl = [[UIPageControl alloc]initWithFrame:pRect]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:headerColor];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    
    
    
    
    [self initPosterData];
//    原理：3-[0-1-2-3]-0
    
    [self selectedEnd:0];
    return self;
}
-(void)setPostersData:(NSArray *)arr{
    [dataArr removeAllObjects];
    [dataArr addObjectsFromArray:arr];
    [self selectedEnd:nTag];
    for (int i = 0; i<dataArr.count; i++) {
        PosterItem *pi = [dataArr objectAtIndex:i];
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:pi.posterPic
                                                                                       target:self
                                                                                         type:HttpRequestType_Img_LoadDown];

        request.tTag = i;
        [request setRequestMethod:@"GET"];
        [request startAsynchronous];
    }
    
}
-(void)initPosterData{
    // 初始化 数组 并添加四张图片
    pageControl.numberOfPages = 4;
    NSString *dStr = @"down_img";
    int count = 4;
    // 创建四个图片 imageview
    for (int i = 0;i<count;i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:dStr]];
        imageView.frame = CGRectMake((self.frame.size.width * i) + self.frame.size.width, 0, self.frame.size.width  , self.frame.size.height);
        imageView.contentMode = UIViewContentModeCenter;
        [imgViewArr addObject:imageView];
        [scrollView addSubview:imageView];
        [scrollView sendSubviewToBack:imageView];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(didSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = imageView.frame;
        [scrollView addSubview:btn];
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:dStr]];
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height); // 添加最后1页在首页 循环
    imageView.contentMode = UIViewContentModeCenter;
    [scrollView addSubview:imageView];
    [imgViewArr insertObject:imageView atIndex:0];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 3;
    [btn addTarget:self action:@selector(didSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = imageView.frame;
    [scrollView addSubview:btn];
    
    //    原理：3-[0-1-2-3]-0
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:dStr]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = CGRectMake((self.frame.size.width * (count + 1)) , 0, self.frame.size.width, self.frame.size.height); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    [imgViewArr addObject:imageView];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 0;
    [btn addTarget:self action:@selector(didSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = imageView.frame;
    [scrollView addSubview:btn];
    
    
    [scrollView setContentSize:CGSizeMake(self.frame.size.width * (count + 2), self.frame.size.height)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];
}

#pragma mark -  UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewWillBeginDragging");
    isMoving = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidEndDecelerating");
    
    isMoving = NO;
    int index = self.scrollView.contentOffset.x / self.frame.size.width;
    
    if (index == 0) {
        pageControl.currentPage = allCount - 1;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * allCount,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else if (index>allCount) {
        pageControl.currentPage  = 0;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width ,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else{
        pageControl.currentPage = index - 1;
    }
    [self selectedEnd:(int)pageControl.currentPage];
//    NSLog(@"scrollViewDidEnd,page:%d,x:%f",(int)pageControl.currentPage,self.scrollView.contentOffset.x);
}
#pragma mark - 

// 定时器 绑定的方法
- (void)runTimePage
{
    if (isMoving) {
        //正在转动，不执行
        return;
    }
    int page = (int)pageControl.currentPage; // 获取当前的page
    page++;
    page = page >= allCount ? 0 : page ;
    [self selectedEnd:page];
    pageControl.currentPage = page;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentOffset.x + self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:YES];
    [self performSelector:@selector(judgeResult) withObject:nil afterDelay:0.5];
}

-(void)judgeResult{
    int index = self.scrollView.contentOffset.x / self.frame.size.width;
    
    if (index == 0) {
//        pageControl.currentPage = slideImages.count - 1;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * allCount,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else if (index>allCount) {
//        pageControl.currentPage  = 0;
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width ,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else{
//        pageControl.currentPage = index - 1;
    }
    
//    NSLog(@"scrollViewDidEnd,page:%d,x:%f",(int)pageControl.currentPage,self.scrollView.contentOffset.x);
}

#pragma mark -  AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <2000) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                UIImageView *iv =  [imgViewArr objectAtIndex:(ir.tTag+1)];
                iv.image = rImage;
                iv.contentMode = UIViewContentModeScaleToFill;
                //    原理：3-[0-1-2-3]-0
                if (ir.tTag == 0) {
                    iv =  [imgViewArr objectAtIndex:5];
                    iv.image = rImage;
                }else if(ir.tTag == 3){
                    iv =  [imgViewArr objectAtIndex:0];
                    iv.image = rImage;
                }
                iv.contentMode = UIViewContentModeScaleToFill;
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        default:{
            break;
        }
    }
}
@end
