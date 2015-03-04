//
//  ServiceMainView.h
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ServiceMainView;
@protocol ServiceMainViewDelegate <NSObject>
- (void)serviceMainView:(ServiceMainView *)mainView;
@end
@interface ServiceMainView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
}
@property(nonatomic,strong) UICollectionView *tCollectionView;
@property(nonatomic,strong) NSIndexPath *tIndexPath;
@property(nonatomic,weak)id<ServiceMainViewDelegate> delegate;
@property(nonatomic,strong) NSArray *mData;
-(void)setData:(NSArray *)arr;
@end
