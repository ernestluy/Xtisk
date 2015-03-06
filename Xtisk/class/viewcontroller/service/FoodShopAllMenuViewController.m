//
//  FoodShopAllMenuViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodShopAllMenuViewController.h"
#import "PublicDefine.h"
#import "ShopMenuCollectionViewCell.h"
#define ShopMenuId @"ShopMenuId"
@interface FoodShopAllMenuViewController ()
{
    int sid ;
    int cInset ;
    NSArray *mDataArr;
    
    UIButton *btnCall;
}
@end

@implementation FoodShopAllMenuViewController


-(id)initWithId:(int)tid{
    self = [super init];
    sid = tid;
    self.storeId = tid;
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
    self.tCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64 - DEFAULT_CELL_HEIGHT)  collectionViewLayout:layout];
    
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
    
    
    UIView *callView = [[UIView alloc]initWithFrame:CGRectMake(0, bounds.size.height - DEFAULT_CELL_HEIGHT - 64, bounds.size.width, DEFAULT_CELL_HEIGHT)];
    callView.backgroundColor = _rgb2uic(0x0095f1, 1);
    [self.view addSubview:callView];
    UILabel *labCall = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, callView.frame.size.height)];
    labCall.font = [UIFont boldSystemFontOfSize:16];
    labCall.textAlignment = NSTextAlignmentCenter;
    labCall.textColor = [UIColor whiteColor];
    labCall.text = @"我要叫餐";
    [callView addSubview:labCall];
    btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCall.frame = CGRectMake(130, 5, 180, 33);
    [btnCall addTarget:self action:@selector(toCall:) forControlEvents:UIControlEventTouchUpInside];
    [btnCall setTitle:@"" forState:UIControlStateNormal];//0755-23656666
    [btnCall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"food_call_normal"] forState:UIControlStateNormal];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"food_call_normal"] forState:UIControlStateHighlighted];
    [btnCall setImage:[UIImage imageNamed:@"tel_symbol"] forState:UIControlStateNormal];
    [btnCall setImage:[UIImage imageNamed:@"tel_symbol"] forState:UIControlStateHighlighted];
    btnCall.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btnCall.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [callView addSubview:btnCall];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [btnCall setTitle:self.storePhone forState:UIControlStateNormal];
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestQueryStoreMenu:self storeId:int2str(self.storeId)]startAsynchronous];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toCall:(id)sender{
    NSLog(@"toCall");
    NSString *telNum = [NSString stringWithFormat:@"tel://%@",btnCall.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return mDataArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopMenuId forIndexPath:indexPath];
    ShopMenuCollectionViewCell *tcell = (ShopMenuCollectionViewCell*)cell;
    MenuItem *item = [mDataArr objectAtIndex:indexPath.row];
    [tcell setData:item];
    UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:item.menuUrl];
    if (!tImg) {
        //down_img_small.png
        tcell.imgShow.contentMode = DefaultImageViewInitMode;
        tcell.imgShow.image = [UIImage imageNamed:@"down_img_small"];
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:item.menuUrl
                                                                                       target:self
                                                                                         type:HttpRequestType_Img_LoadDown];
        request.tTag = (int)indexPath.row;
        request.indexPath = indexPath;
        [request startAsynchronous];
    }else{
        tcell.imgShow.contentMode =  DefaultImageViewContentMode;
        tcell.imgShow.image = tImg;
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
    return CGSizeMake(145, 116);
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


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <DefaultImageMinSize) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                MenuItem *item = [mDataArr objectAtIndex:ir.tTag];
                [XTFileManager saveTmpFolderFileWithUrlPath:item.menuUrl with:rImage];
                ShopMenuCollectionViewCell * pc = (ShopMenuCollectionViewCell * )[self.tCollectionView cellForItemAtIndexPath:ir.indexPath];
                if (pc) {
                    pc.imgShow.contentMode = DefaultImageViewContentMode;
                    pc.imgShow.image = rImage;
                }
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERYSTOREMENU:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                if (ResponseCodeSuccess == br.code) {
//                    [SVProgressHUD showErrorWithStatus:@"请求成功" duration:DefaultRequestDonePromptTime];
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        NSArray *tmpArr = [dic objectForKey:@"menuList"];
                        mDataArr = [MenuItem getMenuItemsWithArr:tmpArr];
                        [self.tCollectionView reloadData];
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
            
            
            
        default:
            break;
    }
}

@end
