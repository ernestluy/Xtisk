//
//  LYScrollView.m
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "LYScrollView.h"
#import "PublicDefine.h"
@interface LYScrollView (){
    
    UIView *viewUpDrag;
    UILabel *labelUpDrag;
    UIActivityIndicatorView *acUpDrag;
    
    
    UIView *viewDownDrag;
    UILabel *labelDownDrag;
    UIActivityIndicatorView *acDownDrag;
    
    BOOL isDraging;
    
    BOOL isFlush;
    
    BOOL isNeedUpFlush;
    BOOL isNeedDownFlush;
    
    
}

-(void)initSet;

@end

@implementation LYScrollView
@synthesize flushDirType;
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    [self initSet];
    return self;
}

-(id)init{
    self = [super init];
    
    [self initSet];
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self initSet];
    return self;
}
-(void)initSet{
    isFlush = NO;
    isDraging = NO;
    
    isNeedUpFlush = NO;
    isNeedDownFlush = NO;
}

-(void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    [self reloadData];
}

-(void)setNeedTopFlush{
    isNeedUpFlush = YES;
    [self reloadUpDragFlushCtl];
}
-(void)setNeedBottomFlush{
    isNeedDownFlush = YES;
    [self reloadData];
}
-(void)hiddenBottomFlush{
    isNeedDownFlush = NO;
    [self reloadData];
}

-(void)reloadData{
    self.isCanFlush = YES;
    //    NSLog(@"reloadData");
    [self reloadUpDragFlushCtl];
    [self reloadDownDragFlushCtl];
    
}
-(void)setIsDraging:(BOOL)b{
    isDraging = b;
}
-(void)flushDone{
    [self changeToNormalStatus];
}
#pragma mark -  回复正常状态
-(void)changeToNormalStatus{
    //    NSLog(@"changeToNormalStatus");
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }completion:^(BOOL finished){
        [self upFlushToNormal];
        [self downFlushToNormal];
        if (flushDirType == FlushDirUp) {
            if (self.lyDelegate && [self.lyDelegate respondsToSelector:@selector(flushUpEnd:)]) {
                [self.lyDelegate flushUpEnd:self];
            }
        }else if (flushDirType == FlushDirDown) {
            if (self.lyDelegate && [self.lyDelegate respondsToSelector:@selector(flushDownEnd:)]) {
                [self.lyDelegate flushDownEnd:self];
            }
        }
        flushDirType = FlushDirNormal;
    }];
    
}
-(void)flushDoneStatus:(BOOL)resp{
    if (resp) {
        if (flushDirType == FlushDirUp) {
            [UIView animateWithDuration:0.5 animations:^{
                self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }completion:^(BOOL finished){
                
            }];
        }else if (flushDirType == FlushDirDown){
            CGFloat tY = self.contentOffset.y;
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.contentOffset = CGPointMake(0, tY);
        }
        [self upFlushToNormal];
        [self downFlushToNormal];
        if (flushDirType == FlushDirUp) {
            if (self.lyDelegate && [self.lyDelegate respondsToSelector:@selector(flushUpEnd:)]) {
                [self.lyDelegate flushUpEnd:self];
            }
        }else if (flushDirType == FlushDirDown) {
            if (self.lyDelegate && [self.lyDelegate respondsToSelector:@selector(flushDownEnd:)]) {
                [self.lyDelegate flushDownEnd:self];
            }
        }
        flushDirType = FlushDirNormal;
    }else{
        [self changeToNormalStatus];
    }
}
-(void)changeToFlushStatus{
    //    NSLog(@"changeToFlushStatus");
    //    [self performSelector:@selector(changeToNormalStatus) withObject:nil afterDelay:3];
}
#pragma mark -  判断下拉，下拉

-(void)judgeDragIng{
    if (!isDraging || isFlush) {
        return;
    }
    if (self.contentOffset.y <0) {//下拉
        if (!isNeedUpFlush) {
            return;
        }
        if (self.contentOffset.y <=-LY_DOWN_FLUSH_HEIGHT) {
            [self promptUpDragFlush];//提示放开就刷新
        }else{
            [self upDragToNormal];//恢复
        }
    }else{//上拉
        if (!isNeedDownFlush) {
            return;
        }
        if (self.contentSize.height<=self.frame.size.height) {
            //            NSLog(@"单页已经显示完，不需要刷新，返回");
            return;
        }
        if (self.contentOffset.y >=(self.contentSize.height - self.frame.size.height + LY_DOWN_FLUSH_HEIGHT)) {
            [self promptDownDragFlush];//提示放开就刷新
        }else{
            [self downDragToNormal];//恢复
        }
    }
}
-(void)judgeDragEnd{
    isDraging = NO;
    if (isFlush) {
        NSLog(@"正在刷新");
        return;
    }
    if (self.contentOffset.y <0) {//下拉
        if (!isNeedUpFlush) {
            return;
        }
        if (self.contentOffset.y <=-LY_DOWN_FLUSH_HEIGHT) {
            [self upToStartFlush];//刷新
        }else{
            [self upDragToNormal];//恢复
        }
    }else{//上拉
        if (!isNeedDownFlush) {
            return;
        }
        if (self.contentSize.height<=self.frame.size.height) {
            NSLog(@"单页已经显示完，不需要刷新，返回");
            return;
        }
        if (self.contentOffset.y >=(self.contentSize.height - self.frame.size.height + LY_DOWN_FLUSH_HEIGHT)) {
            [self downToStartFlush];//刷新
        }else{
            [self downDragToNormal];//恢复
        }
    }
    
}



#pragma mark - 下拉刷新处理函数


#pragma mark - 下拉刷新初始化界面
-(void)reloadUpDragFlushCtl{
    if (!isNeedUpFlush) {
        return;
    }
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (viewUpDrag == nil) {
        
        viewUpDrag = [[UIView alloc]init];
        viewUpDrag.frame = CGRectMake(0, -LY_DOWN_FLUSH_HEIGHT, bounds.size.width, LY_DOWN_FLUSH_HEIGHT);
        //        viewUpDrag.backgroundColor = [UIColor lightGrayColor];
        acUpDrag = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        acUpDrag.color = headerColor;
        [viewUpDrag addSubview:acUpDrag];
        acUpDrag.center = CGPointMake(50, LY_DOWN_FLUSH_HEIGHT/2);
        acUpDrag.hidden = YES;
        
        labelUpDrag = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width , LY_DOWN_FLUSH_HEIGHT)];
        labelUpDrag.textAlignment = NSTextAlignmentCenter;
        labelUpDrag.textColor = [UIColor darkGrayColor];
        labelUpDrag.font = [UIFont systemFontOfSize:14];
        labelUpDrag.text = UP_DRAG_FLUSH_NORMAL;
        [viewUpDrag addSubview:labelUpDrag];
        [self addSubview:viewUpDrag];
    }
    //    [acUpDrag startAnimating];
}
#pragma mark -  拖动中，提示放开刷新
-(void)promptUpDragFlush{
    labelUpDrag.text = RELEASE_DRAG_TO_FLUSH;
}

#pragma mark - 拖动中，提示为正常状态
-(void)upDragToNormal{
    labelUpDrag.text = UP_DRAG_FLUSH_NORMAL;
}

#pragma mark - 进入刷新状态（转起来）
-(void)upToStartFlush{
    isFlush = YES;
    acUpDrag.hidden = NO;
    [acUpDrag startAnimating];
    labelUpDrag.text = UP_DRAG_FLUSH_DOING;
    self.contentInset = UIEdgeInsetsMake(LY_DOWN_FLUSH_HEIGHT, 0, 0, 0);
    flushDirType = FlushDirUp;
    [self changeToFlushStatus];
    if (self.lyDelegate && [self.lyDelegate respondsToSelector:@selector(startToFlushUp:)]) {
        [self.lyDelegate startToFlushUp:self];
    }
}



#pragma mark - 从正在刷新的状态转为平常状态
-(void)upFlushToNormal{
    isDraging = NO;
    isFlush = NO;
    acUpDrag.hidden = YES;
    [acUpDrag stopAnimating];
    labelUpDrag.text = UP_DRAG_FLUSH_NORMAL;
}
#pragma mark -
#pragma mark -
#pragma mark -
#pragma mark -
#pragma mark - 上拉刷新处理函数


#pragma mark - 上拉刷新初始化界面
-(void)reloadDownDragFlushCtl{
    if (!isNeedDownFlush) {
        viewDownDrag.hidden = YES;
        return;
    }
    CGSize cSize = self.contentSize;
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (viewDownDrag == nil) {
        
        viewDownDrag = [[UIView alloc]init];
        //        viewDownDrag.backgroundColor = [UIColor lightGrayColor];
        acDownDrag = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [viewDownDrag addSubview:acDownDrag];
        acDownDrag.color = headerColor;
        acDownDrag.center = CGPointMake(50, LY_DOWN_FLUSH_HEIGHT/2);
        acDownDrag.hidden = YES;
        
        labelDownDrag = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width , LY_DOWN_FLUSH_HEIGHT)];
        labelDownDrag.textAlignment = NSTextAlignmentCenter;
        labelDownDrag.textColor = [UIColor darkGrayColor];
        labelDownDrag.font = [UIFont systemFontOfSize:14];
        labelDownDrag.text = DOWN_DRAG_FLUSH_NORMAL;
        [viewDownDrag addSubview:labelDownDrag];
        [self addSubview:viewDownDrag];
    }
    viewDownDrag.frame = CGRectMake(0, cSize.height, bounds.size.width, LY_DOWN_FLUSH_HEIGHT);
    if (cSize.height<self.frame.size.height) {
        //如果能直接显示全，没必要下拉刷新功能
        viewDownDrag.hidden = YES;
    }else{
        viewDownDrag.hidden = NO;
    }
    
}

#pragma mark -  拖动中，提示放开刷新
-(void)promptDownDragFlush{
    labelDownDrag.text = RELEASE_DRAG_TO_FLUSH;
}

#pragma mark -  拖动中，提示为正常状态
-(void)downDragToNormal{
    labelDownDrag.text = DOWN_DRAG_FLUSH_NORMAL;
}

#pragma mark -  开始进入刷新状态（转起来）
-(void)downToStartFlush{
    NSLog(@"downToStartFlush");
    isFlush = YES;
    acDownDrag.hidden = NO;
    [acDownDrag startAnimating];
    labelDownDrag.text = DOWN_DRAG_FLUSH_DOING;
    self.contentInset = UIEdgeInsetsMake(0, 0, LY_DOWN_FLUSH_HEIGHT, 0);
    [self changeToFlushStatus];
    flushDirType = FlushDirDown;
    if (self.lyDelegate && [self.lyDelegate respondsToSelector:@selector(startToFlushDown:)]) {
        [self.lyDelegate startToFlushDown:self];
    }
}

#pragma mark -  由刷新状态进入正常状态
-(void)downFlushToNormal{
    isDraging = NO;
    isFlush = NO;
    acDownDrag.hidden = YES;
    [acDownDrag stopAnimating];
    labelDownDrag.text = DOWN_DRAG_FLUSH_NORMAL;
}


@end
