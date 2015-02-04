//
//  testScrollViewViewControllerViewController.h
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirculaScrollView: UIView<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;
@property (strong, nonatomic)UILabel *labelTitle;

-(void)setImageData:(NSArray *)arr;
@end
