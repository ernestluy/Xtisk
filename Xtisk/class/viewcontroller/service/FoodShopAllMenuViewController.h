//
//  FoodShopAllMenuViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface FoodShopAllMenuViewController : SecondaryViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AsyncHttpRequestDelegate>
{
    
}
@property(nonatomic,strong) NSIndexPath *tIndexPath;
@property(nonatomic,strong) UICollectionView *tCollectionView;
@property(nonatomic,strong)NSString *storePhone;
@property(nonatomic) int storeId;
-(id)initWithId:(int)tid;
@end
