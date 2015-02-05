//
//  ServiceMainView.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ServiceMainView.h"
#import "ServiceItemCell.h"
NSString *const ServiceMainViewCellIdentifier = @"Cell";
@interface ServiceMainView(){
    
    int cInset ;
    UIView *cHeader;
}

@end
@implementation ServiceMainView
@synthesize tCollectionView,tIndexPath,delegate;
/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    cInset = 8;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGRect rt = self.bounds;
    self.tCollectionView = [[UICollectionView alloc] initWithFrame:rt collectionViewLayout:layout];
    
    self.tCollectionView.bounces = NO;
    [self addSubview:self.tCollectionView];
    self.tCollectionView.delegate = self;
    self.tCollectionView.dataSource = self;
    //    self.collectionView.collectionViewLayout = layout;
    
    
    [self.tCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.tCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    // 1.初始化collectionView
    [self setupCollectionView];
    self.backgroundColor = [UIColor whiteColor];
    self.tCollectionView.backgroundColor = [UIColor clearColor];
    
    
    // 2.集成刷新控件
    [self addHeader];
    [self addFooter];
    return self;
}

- (void)addHeader
{
    //    UIView *outHeaderView  = [[UIView alloc]initWithFrame:CGRectMake(0, -50, self.frame.size.width, 50)];
    //    outHeaderView.backgroundColor = [UIColor lightGrayColor];
    //    [self.collectionView addSubview:outHeaderView];
}

- (void)addFooter
{
    
}
-(void)setHeaderView:(UIView *)headerView{
    cHeader = headerView;
    [self.tCollectionView reloadData];
}
/**
 *  初始化collectionView
 */
- (void)setupCollectionView
{
    self.tCollectionView.backgroundColor = [UIColor whiteColor];
    self.tCollectionView.alwaysBounceVertical = YES;
    [self.tCollectionView registerNib:[UINib nibWithNibName:@"ServiceItemCell" bundle:nil] forCellWithReuseIdentifier:ServiceMainViewCellIdentifier];
}
-(void)deleteItem{
    NSLog(@"delete");
    
    [self.tCollectionView deleteItemsAtIndexPaths:@[tIndexPath]];
    
    
}

-(IBAction)btnAction:(id)sender{
    NSLog(@"asddf");
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 6;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ServiceMainViewCellIdentifier forIndexPath:indexPath];
    //    NSLog(@"row:%d",indexPath.row);
    return cell;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    tIndexPath = indexPath;
    if (self.delegate && [self.delegate respondsToSelector:@selector(serviceMainView:)]) {
        [self.delegate serviceMainView:self];
    }
    NSLog(@"didSelect");
}

//collectionView:layout:referenceSizeForHeaderInSection:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * v = nil;
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        for (UIView *view in v.subviews) {
            [view removeFromSuperview];
        }
        if (cHeader) {
            [v addSubview:cHeader];
        }
        
    }else{
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    }
    
    
    return v;
}
#pragma  mark -  UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row%5 == 0) {
    //        return CGSizeMake(160, 100);
    //    }
    return CGSizeMake(70, 70);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(cInset, cInset, cInset, cInset);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return cInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return cInset;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (cHeader) {
//        return cHeader.frame.size;
//    }
//    return CGSizeMake(320, 30);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(320, 50);
//}


@end
