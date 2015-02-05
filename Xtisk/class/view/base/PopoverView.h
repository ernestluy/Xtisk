//
//  PopoverView.h
//  StockMobile
//
//  Created by 信息技术部中投证券 on 14-7-1.
//  Copyright (c) 2014年 信息技术部中投证券. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopoverView;
@protocol PopoverViewDelegate <NSObject>
- (void)popoverView:(PopoverView *)popView;
@end
@interface PopoverView : UIView
{
    id<PopoverViewDelegate> delegate;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGRect boxFrame;
@property (nonatomic, assign) id<PopoverViewDelegate> delegate;

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView;
- (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView;
- (void)dismiss;

@end
