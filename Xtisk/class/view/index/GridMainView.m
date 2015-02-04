//
//  GridMainView.m
//  Xtisk
//
//  Created by 卢一 on 15-2-4.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "GridMainView.h"
/*
 具体用法：查看MJRefresh.h
 */
NSString *const ttCollectionViewCellIdentifier = @"Cell";

/**
 *  随机颜色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface GridMainView(){
    NSIndexPath *tIndexPath;
}
/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeColors;
@end
@implementation GridMainView
@synthesize collectionView,btn;
/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.itemSize = CGSizeMake(80, 80);
    //    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //    layout.minimumInteritemSpacing = 20;
    //    layout.minimumLineSpacing = 20;
    //
    //    layout.headerReferenceSize = CGSizeMake(320, 30);
    //    layout.footerReferenceSize = CGSizeMake(320, 50);
    CGRect rt = self.bounds;
    [self fakeColors];
    self.collectionView = [[UICollectionView alloc] initWithFrame:rt collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    self.collectionView.collectionViewLayout = layout;
    
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    // 1.初始化collectionView
    [self setupCollectionView];
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    
    // 2.集成刷新控件
    [self addHeader];
    [self addFooter];
    return self;
}
- (void)addHeader
{
    UIView *outHeaderView  = [[UIView alloc]initWithFrame:CGRectMake(0, -50, self.frame.size.width, 50)];
    outHeaderView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView addSubview:outHeaderView];
}

- (void)addFooter
{
    
}
/**
 *  初始化collectionView
 */
- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ttCollectionViewCellIdentifier];
}
-(void)deleteItem{
    NSLog(@"delete");
    
    [self.fakeColors removeObjectAtIndex:tIndexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[tIndexPath]];
    
    
    
    //    [self.collectionView performBatchUpdates:^{
    //        [self.fakeColors removeObjectAtIndex:tIndexPath.row];
    //        [self.collectionView deleteItemsAtIndexPaths:@[tIndexPath]];
    //    } completion:nil];
}
/**
 *  数据的懒加载
 */
- (NSMutableArray *)fakeColors
{
    if (!_fakeColors) {
        self.fakeColors = [NSMutableArray array];
        
        for (int i = 0; i<10; i++) {
            // 添加随机色
            [self.fakeColors addObject:MJRandomColor];
        }
    }
    return _fakeColors;
}
-(IBAction)btnAction:(id)sender{
    NSLog(@"asddf");
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int a = self.fakeColors.count;
    NSLog(@"all:%d",a);
    return a;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int ddd = 0;
    ddd = 2;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ttCollectionViewCellIdentifier forIndexPath:indexPath];
//    NSLog(@"row:%d",indexPath.row);
    cell.backgroundColor = self.fakeColors[indexPath.row];
    cell.selectedBackgroundView.backgroundColor = [UIColor yellowColor];
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
    //    MJTestViewController *test = [[MJTestViewController alloc] init];
    //    [self.navigationController pushViewController:test animated:YES];
    
    //    [self.collectionView performBatchUpdates:^{
    //        NSLog(@"delete");
    //        [self.fakeColors removeObjectAtIndex:indexPath.row];
    //        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    //    } completion:nil];
    
    //    NSLog(@"delete");
    //    [self.fakeColors removeObjectAtIndex:indexPath.row];
    //    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    tIndexPath = indexPath;
    //    [self performSelector:@selector(deleteItem) withObject:nil afterDelay:1];
    [self.fakeColors addObject:MJRandomColor];
    [self.collectionView reloadData];
//    [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
}

//collectionView:layout:referenceSizeForHeaderInSection:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * v = nil;
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        v.backgroundColor = [UIColor redColor];
    }else{
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        v.backgroundColor = [UIColor blackColor];
    }
    
    
    return v;
}
#pragma  mark -  UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%5 == 0) {
        return CGSizeMake(160, 100);
    }
    return CGSizeMake(80, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(320, 30);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(320, 50);
}

@end
