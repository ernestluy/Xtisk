//
//  LYCollectionView.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYFlushDefine.h"
@interface LYCollectionView : UICollectionView

@property(nonatomic)BOOL isCanFlush;
@property(nonatomic,weak)id<LYFlushViewDelegate> lyDelegate;
-(void)setIsDraging:(BOOL)b;
-(void)judgeDragIng;
-(void)judgeDragEnd;
-(void)reloadUpDragFlushCtl;
-(void)reloadDownDragFlushCtl;

-(void)changeToNormalStatus;
-(void)changeToFlushStatus;

-(void)flushDone;
@end
