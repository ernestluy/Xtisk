//
//  ServiceMenuComViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@interface ServiceMenuComViewController : SecondaryViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString*tTitle;
}
@property(nonatomic,strong) NSIndexPath *tIndexPath;
@property(nonatomic,strong) UICollectionView *tCollectionView;
@property(nonatomic)ServiceMenuLevel menuLevel;

-(id)initWithLevel:(int)level title:(NSString *)tl;
@end
