//
//  TestViewController.h
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "LYScrollView.h"
@interface TestViewController : SecondaryViewController<LYFlushViewDelegate,UIScrollViewDelegate>


@property(nonatomic,weak)IBOutlet LYScrollView *tScrollView;
@end
