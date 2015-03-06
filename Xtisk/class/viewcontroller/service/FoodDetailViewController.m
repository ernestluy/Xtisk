//
//  FoodDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailHeader.h"
#import "PublicDefine.h"
#import "DetailFoodTableViewCell.h"
#import "BaiduMapViewController.h"
#import "SettingService.h"
#import "DetailFoodCommendTableViewCell.h"
#import "ComCommendViewController.h"
#import "EditTextViewController.h"
#import "FoodShopAllMenuViewController.h"
#import "LoginViewController.h"
#define SECTION_SENCOND_HEIGHT   56.0
#define SECTION_THIRD_HEIGHT     120.0
@interface FoodDetailViewController ()
{
    FoodDetailHeader *foodDetailHeader;
    UIButton *btnCall;
    BOOL isRequestSuc;
    UILabel *labTaddress;
    
    NSArray *comArr;
    
    int totalCom;
}
@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds = [UIScreen mainScreen].bounds;
//    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    totalCom = 0;
    
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - DEFAULT_CELL_HEIGHT - 64);
    self.tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:self.tTableView];
    self.tTableView.dataSource = self;
    self.tTableView.delegate = self;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FoodDetailHeader" owner:self options:nil];
    foodDetailHeader = [nib objectAtIndex:0];
    [foodDetailHeader setUIInit];
//    [foodDetailHeader setStoreDetailData:self.mStoreItem];
//    foodDetailHeader.backgroundColor = [UIColor redColor];
    self.tTableView.tableHeaderView = foodDetailHeader;
    [foodDetailHeader.btnCommend addTarget:self action:@selector(toCommend:) forControlEvents:UIControlEventTouchUpInside];
    [foodDetailHeader.btnGood addTarget:self action:@selector(toPraise:) forControlEvents:UIControlEventTouchUpInside];
    
    self.title = @"商家详情";
    
    [self.tTableView registerNib:[UINib nibWithNibName:@"DetailFoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    //DetailFoodCommendTableViewCell
    [self.tTableView registerNib:[UINib nibWithNibName:@"DetailFoodCommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
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
    isRequestSuc = NO;
    
    [self flushUI];
}

-(void)flushUI{
    [self setDataWithStoreInfo:self.mStoreItem];

    UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:self.mStoreItem.storeMiniPic];
    if (!tImg) {
        foodDetailHeader.imgHeader.contentMode = DefaultImageViewInitMode;
        foodDetailHeader.imgHeader.image = [UIImage imageNamed:@"down_img_small"];
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:self.mStoreItem.storeMiniPic
                                                                                       target:self
                                                                                         type:HttpRequestType_Img_LoadDown];
        request.tTag = -1;
        [request startAsynchronous];
    }else{
        foodDetailHeader.imgHeader.contentMode = DefaultImageViewContentMode;
        foodDetailHeader.imgHeader.image = tImg;
    }
    
    [self.tTableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self requestListData];
}
-(void)setDataWithStoreInfo:(StoreItem*)store{
    [foodDetailHeader setStoreDetailData:store];
    [foodDetailHeader setLabPjNum:totalCom];
    [btnCall setTitle:store.storePhone forState:UIControlStateNormal];
    if (labTaddress) {
        labTaddress.text = [NSString stringWithFormat:@"地址:%@",self.mStoreItem.storeAddress];
    }
}
-(void)requestListData{
    if (!isRequestSuc) {
        [[[HttpService sharedInstance] getRequestQueryStoreDetail:self storeId:int2str(self.mStoreItem.storeId)]startAsynchronous];
        [[[HttpService sharedInstance] getRequestStoreCommentsList:self storeId:int2str(self.mStoreItem.storeId) pageNo:1 pageSize:5]startAsynchronous];
    }
    
}

-(void)toCall:(id)sender{
    NSLog(@"toCall");
    NSString *telNum = [NSString stringWithFormat:@"tel://%@",btnCall.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
}
-(void)toCommend:(id)sender{
    NSLog(@"toCommend");//评价
    EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextFoodCommend delegate:self];
    et.storeId = self.mStoreItem.storeId;
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]initWithVc:et];
        lv.delegate = self;
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    
    [self.navigationController pushViewController:et animated:YES];
}
-(void)toPraise:(id)sender{
    //点赞
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        lv.delegate = self;
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    [[[HttpService sharedInstance] getRequestFavoriteStore:self storeId:int2str(self.mStoreItem.storeId)]startAsynchronous];
    
    NSLog(@"toPraise");
}
#pragma mark - LoginViewControllerDelegate
- (void)loginSucBack:(LoginViewController *)loginVc{
    [[[HttpService sharedInstance] getRequestQueryStoreDetail:self storeId:int2str(self.mStoreItem.storeId)]startAsynchronous];
}

#pragma mark - EditTextViewDelegate
- (void)editTextDone:(NSString *)str type:(int)ty{
    NSLog(@"editTextDone");
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if (1 == section){
        return self.mStoreItem.recomDishes.count + 1;
    }else if(2 == section){
        return comArr.count + 1;
    }
    return 4;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.section) {
        NSString *identifier = @"cell1";
        UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
        if (cell ==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.imageView.image  = [UIImage imageNamed:@"address_cion"];
        if (self.mStoreItem.storeAddress) {
            cell.textLabel.text = [NSString stringWithFormat:@"地址:%@",self.mStoreItem.storeAddress];
        }else{
            cell.textLabel.text = @"地址:";
        }
        labTaddress = cell.textLabel;
//        cell.textLabel.text = @"地址:南山区工业五路万维大厦一楼";
        cell.clipsToBounds = YES;
        
//        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow_gray"]];
//        cell.accessoryView = iv;
        return cell;
    }else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            NSString *identifier = @"cell_normal";
            UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14]; //[UIFont systemFontOfSize:14];
            }
            cell.textLabel.text = @"全部菜单";
            
            return cell;
        }else{
            NSString *identifier = @"cell2";
            DetailFoodTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MenuItem *mi = [self.mStoreItem.recomDishes objectAtIndex:(indexPath.row-1)];
            [cell setData:mi];
            UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:mi.menuUrl];
            if (!tImg) {
                cell.imgHeader.contentMode = DefaultImageViewInitMode;
                cell.imgHeader.image = [UIImage imageNamed:@"down_img_small"];
                AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:mi.menuUrl
                                                                                               target:self
                                                                                                 type:HttpRequestType_Img_LoadDown];
                request.tTag = 1;
                request.indexPath = indexPath;
                [request startAsynchronous];
            }else{
                cell.imgHeader.contentMode = DefaultImageViewContentMode;
                cell.imgHeader.image = tImg;
            }
            
            
            return cell;
        }
    }else if (2 == indexPath.section) {
        if (0 == indexPath.row) {
            NSString *identifier = @"cell_normal";
            UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"网友评价(36)";
            if (totalCom == 0) {
                cell.textLabel.text = @"网友评价";
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"网友评价(%d)",totalCom];
            }
            return cell;
        }else{
            NSString *identifier = @"cell3";
            DetailFoodCommendTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[DetailFoodCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CommentsItem *ci = [comArr objectAtIndex:(indexPath.row - 1)];
            [cell setDataWith:ci];
            return cell;
        }
        
    }
    
    
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0.1;
    }
    return 6.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((1 == indexPath.section || 2 == indexPath.section) && 0 == indexPath.row) {
        return 38 ;
    }
    
    if (1 == indexPath.section) {
        return SECTION_SENCOND_HEIGHT;
    }else if (2 == indexPath.section) {
        return SECTION_THIRD_HEIGHT;
    }
    return DEFAULT_CELL_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row && 0 == indexPath.section) {
        [[SettingService sharedInstance] PermissionBaiduMap];
        BaiduMapViewController *bv = [[BaiduMapViewController alloc] initWithLong:self.mStoreItem.longitude lat:self.mStoreItem.latitude];//113.922  22.497
        [self.navigationController pushViewController:bv animated:YES];

    }else if (0 == indexPath.row && 1 == indexPath.section) {
        NSLog(@"全部菜单");
        FoodShopAllMenuViewController *sc = [[FoodShopAllMenuViewController alloc]initWithId:self.mStoreItem.storeId];
        sc.storeId = self.mStoreItem.storeId;
        sc.storePhone = self.mStoreItem.storePhone;
        [self.navigationController pushViewController:sc animated:YES];
    }else if (0 == indexPath.row && 2 == indexPath.section) {
        NSLog(@"网友评价");
        ComCommendViewController *ccc = [[ComCommendViewController alloc]init];
        ccc.storeId = self.mStoreItem.storeId;
        ccc.vcType = CommendVcStore;
        [self.navigationController pushViewController:ccc animated:YES];
    }
    
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
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
                if (-1 == ir.tTag) {
                    [XTFileManager saveTmpFolderFileWithUrlPath:self.mStoreItem.storeMiniPic with:rImage];
                    foodDetailHeader.imgHeader.contentMode = DefaultImageViewContentMode;
                    foodDetailHeader.imgHeader.image = rImage;
                }else if (1 == ir.tTag){
                    MenuItem *tmpMenuItem  = [self.mStoreItem.recomDishes objectAtIndex:(ir.indexPath.row-1)];
                    [XTFileManager saveTmpFolderFileWithUrlPath:tmpMenuItem.menuUrl with:rImage];
                    DetailFoodTableViewCell *cell = (DetailFoodTableViewCell * )[self.tTableView cellForRowAtIndexPath:ir.indexPath];
                    if (cell) {
                        cell.imgHeader.image = rImage;
                        cell.imgHeader.contentMode = DefaultImageViewContentMode;
                    }
                }else if (2 == ir.tTag){
                    
                }
                
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERYSTOREDETAIL:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    isRequestSuc = YES;
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        StoreItem *tmpStoreItem = [StoreItem getStoreItemWith:dic];
                        if (tmpStoreItem) {
                            self.mStoreItem = tmpStoreItem;
                            [self flushUI];
                            
                        }
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_FAVORITESTORE:{
            
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"点赞请求成功");
//                    [[[HttpService sharedInstance] getRequestQueryStoreDetail:self storeId:int2str(self.mStoreItem.storeId)]startAsynchronous];
                    //{"favoritePeople":2,"isFavorite":true}
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        self.mStoreItem.favoritePeople = [[dic objectForKey:@"favoritePeople"] intValue];
                        self.mStoreItem.isFavorite = [[dic objectForKey:@"isFavorite"] boolValue];
                    }
                    [self setDataWithStoreInfo:self.mStoreItem];
                    NSString *strNote = @"点赞成功";
                    if (!self.mStoreItem.isFavorite) {
                        strNote = @"已经取消点赞";
                    }
                    [SVProgressHUD showSuccessWithStatus:strNote duration:DefaultRequestDonePromptTime];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_STORECOMMENTSLIST:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    totalCom = [[dic objectForKey:@"total"] intValue];
                    NSArray *tmpComArr = [dic objectForKey:@"items"];
                    comArr = [CommentsItem getCommentsItemsWithArr:tmpComArr];
//                    [self.tTableView reloadData];
                    [self flushUI];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
