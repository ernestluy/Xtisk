//
//  testScrollViewViewControllerViewController.h
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImgDownLoadRequest.h"
#import "PosterItem.h"
@class CirculaScrollView;
@protocol CirculaScrollViewDelegate <NSObject>
- (void)didSelected:(PosterItem *)pi;
@end

@interface CirculaScrollView: UIView<UIScrollViewDelegate,AsyncHttpRequestDelegate>
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;
@property (strong, nonatomic)UILabel *labelTitle;
@property (weak, nonatomic)id<CirculaScrollViewDelegate> cDelegate;
-(void)setImageData:(NSArray *)arr;
-(void)initPosterData;
-(void)setPostersData:(NSArray *)arr;
@end
