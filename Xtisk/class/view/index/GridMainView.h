//
//  GridMainView.h
//  Xtisk
//
//  Created by 卢一 on 15-2-4.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridMainView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *tCollectionView;
    __weak UIButton *btn;
}
@property(nonatomic,strong) UICollectionView *tCollectionView;
@property(nonatomic,weak)UIButton *btn;

-(void)setHeaderView:(UIView *)headerView;
@end
