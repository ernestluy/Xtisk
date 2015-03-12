//
//  TestViewController.m
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"测试";
    [self.tScrollView setNeedBottomFlush];
    self.tScrollView.lyDelegate = self;
    self.tScrollView.delegate = self;
    self.tScrollView.backgroundColor = [UIColor yellowColor];
    UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    tview.backgroundColor = [UIColor redColor];
    [self.tScrollView addSubview:tview];
    self.tScrollView.contentSize = CGSizeMake(320, 500);
}
- (void)startToFlushUp:(NSObject *)ly{
    
}
- (void)flushUpEnd:(NSObject *)ly{
    
}
- (void)startToFlushDown:(NSObject *)ly{
    NSLog(@"startToFlushDown");
    [self.tScrollView performSelector:@selector(flushDoneStatus:) withObject:nil afterDelay:2];
}
- (void)flushDownEnd:(NSObject *)ly{
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.tScrollView setIsDraging:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [self.tScrollView judgeDragIng];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    NSLog(@"drag end");
    [self.tScrollView judgeDragEnd];
    
}

#pragma mark - Navigation



@end
