//
//  ServiceMenuComViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface ServiceMenuComViewController : SecondaryViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AsyncHttpRequestDelegate,LYFlushViewDelegate>
{
    NSString*tTitle;
}
@property(nonatomic,strong) NSIndexPath *tIndexPath;
@property(nonatomic,strong) LYCollectionView *tCollectionView;
@property(nonatomic)ServiceMenuLevel menuLevel;
@property(nonatomic,strong)CategoryItem *categoryItem;

-(id)initWithLevel:(int)level title:(NSString *)tl;
@end
