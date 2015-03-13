//
//  LYScrollView.h
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYFlushDefine.h"
#import "PublicDefine.h"
@interface LYScrollView : UIScrollView
@property(nonatomic)BOOL isCanFlush;
@property(nonatomic,weak)id<LYFlushViewDelegate> lyDelegate;
@property(nonatomic)int flushDirType;
-(void)setIsDraging:(BOOL)b;
-(void)judgeDragIng;
-(void)judgeDragEnd;
-(void)reloadUpDragFlushCtl;
-(void)reloadDownDragFlushCtl;

-(void)upToStartFlush;

-(void)changeToNormalStatus;
-(void)changeToFlushStatus;

-(void)setNeedTopFlush;
-(void)setNeedBottomFlush;

-(void)flushDoneStatus:(BOOL)resp;

-(void)hiddenBottomFlush;
@end