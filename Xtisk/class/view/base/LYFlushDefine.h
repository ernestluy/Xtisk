//
//  LYFlushDefine.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LYFlushViewDelegate <NSObject>
- (void)startToFlushUp:(NSObject *)ly;
- (void)flushUpEnd:(NSObject *)ly;
- (void)startToFlushDown:(NSObject *)ly;
- (void)flushDownEnd:(NSObject *)ly;
@end
@interface LYFlushDefine : NSObject

@end
