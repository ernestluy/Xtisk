//
//  ServiceMenuComViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ServiceMenuComViewController.h"
#import "PublicDefine.h"
#import "NearMenuItem.h"
#import "NearMenuCollectionViewCell.h"
#import "FoodListViewController.h"
#define ServiceCollectionViewCellIdentifier  @"ServiceCollectionViewCellIdentifier"
@interface ServiceMenuComViewController ()
{
    int cInset ;
    NSMutableArray *mArr;
    NSMutableArray *mFoodArr;
    
    BOOL isRequestSuc;
}
@end

@implementation ServiceMenuComViewController
@synthesize tCollectionView,menuLevel,categoryItem;

-(id)initWithLevel:(int)level title:(NSString *)tl{
    self = [super init];
    tTitle = tl;
    self.menuLevel = level;
    mArr = [[NSMutableArray alloc]init];
    
    mFoodArr = [[NSMutableArray alloc]init];
    
    
    if (ServiceFirst == level) {
        self.categoryItem = [[CategoryItem alloc]init];
        self.categoryItem.childList = @[];
        self.categoryItem.categoryName = @"周 边";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = tTitle;
    cInset = 10;
    isRequestSuc = NO;
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
  @[@"商超便利",@"便利24小时不打烊",@"near_super_shop",[NSNumber numberWithBool:YES],_rgb2uic(0x35baff, 1)],
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

-(void)requestData{
    if (ServiceFirst == menuLevel && !isRequestSuc) {
        [[[HttpService sharedInstance] getRequestCategoryTypeList:self parentCategoryId:nil]startAsynchronous];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
    if (ServiceFirst == menuLevel ){
        self.title = @"周 边";
    }else{
        self.title = self.categoryItem.categoryName;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.categoryItem) {
        return self.categoryItem.childList.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ServiceCollectionViewCellIdentifier forIndexPath:indexPath];

    NearMenuCollectionViewCell *cc = (NearMenuCollectionViewCell *)cell;

    CategoryItem *tCategoryItem = [self.categoryItem.childList objectAtIndex:indexPath.row];
    UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:tCategoryItem.categoryImageUrl];
    if (!tImg) {
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:tCategoryItem.categoryImageUrl
                                                                                       target:self
                                                                                         type:HttpRequestType_Img_LoadDown];
        request.tTag = (int)indexPath.row;
        request.indexPath = indexPath;
        [request startAsynchronous];
    }else{
        cc.imageBg.contentMode = DefaultImageViewContentMode;
        cc.imageBg.image = tImg;
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

    CategoryItem *tCategoryItem = [self.categoryItem.childList objectAtIndex:indexPath.row];
    if (tCategoryItem.childList) {
        ServiceMenuComViewController *smc = [[ServiceMenuComViewController alloc] initWithLevel:ServiceNode title:tCategoryItem.categoryName];
        smc.categoryItem = tCategoryItem;
        [self.navigationController pushViewController:smc animated:YES];
    }else if (!tCategoryItem.childList) {
        FoodListViewController *fvc = [[FoodListViewController alloc] init];
        fvc.categoryItem = tCategoryItem;
        [self.navigationController pushViewController:fvc animated:YES];
        return;
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
    return CGSizeMake(145, 72);
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
#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <2000) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                CategoryItem *tCategoryItem = [self.categoryItem.childList objectAtIndex:ir.indexPath.row];
                [XTFileManager saveTmpFolderFileWithUrlPath:tCategoryItem.categoryImageUrl with:rImage];
                NearMenuCollectionViewCell * pc = (NearMenuCollectionViewCell * )[self.tCollectionView cellForItemAtIndexPath:ir.indexPath];
                if (pc) {
                    UIImageView *iv = pc.imageBg;
                    iv.contentMode = DefaultImageViewContentMode;
                    iv.image = rImage;
                }
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERYCATEGORY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
//                NSString *tmpStr = [request getResponseStr];
//                NSLog(@"result:%@",tmpStr);
                if (ResponseCodeSuccess == br.code) {
                    isRequestSuc = YES;
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    NSArray *tmpArr = [dic objectForKey:@"categoryList"];
                    if (dic) {
                        self.categoryItem.childList = [CategoryItem getCategoryItemsWithArr:tmpArr];
                        [self.tCollectionView reloadData];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        default:
            break;
    }
}

@end
