//
//  IndexTabViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "CirculaScrollView.h"
#import "GridMainView.h"
@interface IndexTabViewController : SecondaryViewController<GridMainViewDelegate,CirculaScrollViewDelegate,AsyncHttpRequestDelegate,LYFlushViewDelegate>

{
    CirculaScrollView *circulaScrollView;
    GridMainView *gridMainView;
}

-(void)selectAction:(id)sender;
@end
