//
//  ServiceMenuComViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ServiceMenuComViewController.h"
#import "NearMenuItem.h"
#import "NearMenuCollectionViewCell.h"
#import "FoodListViewController.h"
#define ServiceCollectionViewCellIdentifier  @"ServiceCollectionViewCellIdentifier"
@interface ServiceMenuComViewController ()
{
    int cInset ;
    NSMutableArray *mArr;
    NSMutableArray *mFoodArr;
}
@end

@implementation ServiceMenuComViewController
@synthesize tCollectionView,menuLevel;

-(id)initWithLevel:(int)level title:(NSString *)tl{
    self = [super init];
    tTitle = tl;
    self.menuLevel = level;
    mArr = [[NSMutableArray alloc]init];
    
    mFoodArr = [[NSMutableArray alloc]init];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = tTitle;
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
    [self.tCollectionView registerNib:[UINib nibWithNibName:@"NearMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ServiceCollectionViewCellIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tCollectionView.backgroundColor = [UIColor clearColor];
    

    NSArray*tmp2Arr = @[@[@"餐饮美食",@"外卖菜单一览无余",@"near_food",[NSNumber numberWithBool:YES],_rgb2uic(0xfd8c46, 1)],
  @[@"餐饮美食",@"便利24小时不打烊",@"near_super_shop",[NSNumber numberWithBool:YES],_rgb2uic(0x35baff, 1)],
//  @[@"餐饮美食",@"外卖菜单一览无余",@"near_food",[NSNumber numberWithBool:NO],_rgb2uic(0xc6c6c6, 1)],
//  @[@"餐饮美食",@"外卖菜单一览无余",@"near_food",[NSNumber numberWithBool:NO],_rgb2uic(0xc6c6c6, 1)]
                        ];
    
    [mArr removeAllObjects];
    for(int i = 0;i<tmp2Arr.count;i++){
        NSArray *tmpCArr = [tmp2Arr objectAtIndex:i];
        NearMenuItem *nmi = [[NearMenuItem alloc]init];
        nmi.tTitle = [tmpCArr objectAtIndex:0];
        nmi.tContent = [tmpCArr objectAtIndex:1];
        nmi.imgNme = [tmpCArr objectAtIndex:2];
        nmi.isValide = [[tmpCArr objectAtIndex:3] boolValue];
        nmi.tintColor = [tmpCArr objectAtIndex:4];
        [mArr addObject:nmi];
    }
    
    tmp2Arr = @[@"near_food_0",@"near_food_1",@"near_food_2",@"near_food_3",@"near_food_4"];
    [mFoodArr removeAllObjects];
    [mFoodArr addObjectsFromArray:tmp2Arr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.menuLevel == ServiceThird) {
        return mFoodArr.count;
    }
    return mArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ServiceCollectionViewCellIdentifier forIndexPath:indexPath];
    //    NSLog(@"row:%d",indexPath.row);
//    if (indexPath.row%3 == 0) {
//        PosterCollectionViewCell *pcc =  (PosterCollectionViewCell*)cell;
//        pcc.imageBg.image = nil;
//    }
//    cell.backgroundColor = LyRandomColor;
    NearMenuCollectionViewCell *cc = (NearMenuCollectionViewCell *)cell;
    if (self.menuLevel == ServiceThird) {
        [cc setFoodData:[mFoodArr objectAtIndex:indexPath.row]];
    }else if (self.menuLevel == ServiceSecond){
        NearMenuItem *nmi = [mArr objectAtIndex:indexPath.row];
        [cc setItemData:nmi];
    }
    
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
    if (self.menuLevel == ServiceSecond) {
        ServiceMenuComViewController *smc = [[ServiceMenuComViewController alloc] initWithLevel:ServiceThird title:@"餐饮美食"];
        [self.navigationController pushViewController:smc animated:YES];
    }else if (self.menuLevel == ServiceThird) {
        FoodListViewController *fvc = [[FoodListViewController alloc] init];
        fvc.title = @"粉面";
        [self.navigationController pushViewController:fvc animated:YES];
    }
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
    return CGSizeMake(145, 80);
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
//    return CGSizeMake(320, 30);
//}


@end
