//
//  FoodShopAllMenuViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodShopAllMenuViewController.h"
#import "PublicDefine.h"
#define ShopMenuId @"ShopMenuId"
@interface FoodShopAllMenuViewController ()
{
    int sid ;
    int cInset ;
    NSMutableArray *mArr;
}
@end

@implementation FoodShopAllMenuViewController


-(id)initWithId:(int)tid{
    self = [super init];
    sid = tid;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    cInset = 10;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.tCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64)  collectionViewLayout:layout];
    
    //    self.tCollectionView.bounces = NO;
    [self.view addSubview:self.tCollectionView];
    self.tCollectionView.delegate = self;
    self.tCollectionView.dataSource = self;
    //    self.collectionView.collectionViewLayout = layout;
    
    // 1.初始化collectionView
    self.tCollectionView.backgroundColor = [UIColor whiteColor];
    self.tCollectionView.alwaysBounceVertical = YES;
    //    [self.tCollectionView registerClass:[PosterCollectionViewCell class] forCellWithReuseIdentifier:ttCollectionViewCellIdentifier];
    [self.tCollectionView registerNib:[UINib nibWithNibName:@"ShopMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ShopMenuId];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tCollectionView.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 10;//mArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopMenuId forIndexPath:indexPath];
    
    
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
    
    self.tIndexPath = indexPath;
    NSLog(@"didSelect");
}

//collectionView:layout:referenceSizeForHeaderInSection:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * v = nil;
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        v.backgroundColor = LyRandomColor;
    }else{
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        v.backgroundColor = LyRandomColor;
    }
    
    
    return v;
}
#pragma  mark -  UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row%5 == 0) {
    //        return CGSizeMake(160, 100);
    //    }
    return CGSizeMake(145, 110);
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

@end
