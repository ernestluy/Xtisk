//
//  FoodListViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodListViewController.h"
#import "FoodDetailHeader.h"
#import "FoodDetailViewController.h"
#import "FoodListTableViewCell.h"
#define FoodListHeigt 89.0
#define FoodListCellId  @"FoodListCellId"
@interface FoodListViewController ()
{
    BOOL isRequestSuc;
    NSMutableArray *mDataArr;
    
    int tCount;
    
}
@end

@implementation FoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64);
    self.tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStylePlain];
    [self.view addSubview:self.tTableView];
    self.tTableView.dataSource = self;
    self.tTableView.delegate = self;
    
    [self.tTableView registerNib:[UINib nibWithNibName:@"FoodListTableViewCell" bundle:nil] forCellReuseIdentifier:FoodListCellId];
//    self.tTableView.separatorInset = UIEdgeInsetsMake(0,6, 0, 6);
    isRequestSuc = NO;
    mDataArr = [NSMutableArray array];
    tCount = 0;
}
-(void)requestListData{
    if (!isRequestSuc) {
        [mDataArr removeAllObjects];
        [[[HttpService sharedInstance] getRequestQueryStoreByCategory:self categoryId:self.categoryItem.categoryId]startAsynchronous];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = self.categoryItem.categoryName;
    [self requestListData];
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mDataArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    FoodListTableViewCell * cell = (FoodListTableViewCell*)[tv dequeueReusableCellWithIdentifier:FoodListCellId];

    [cell clipsToBounds];
    StoreItem *tmpStoreItem = [mDataArr objectAtIndex:indexPath.row];
    [cell setStoreDataWithStoreItem:tmpStoreItem];
    UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:tmpStoreItem.storeMiniPic];
    if (!tImg) {
        //down_img_small.png
        cell.imgHeader.contentMode = DefaultImageViewInitMode;
        cell.imgHeader.image = [UIImage imageNamed:@"down_img_small"];
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:tmpStoreItem.storeMiniPic
                                                                                       target:self
                                                                                         type:HttpRequestType_Img_LoadDown];
        request.tTag = (int)indexPath.row;
        request.indexPath = indexPath;
        [request startAsynchronous];
    }else{
        cell.imgHeader.contentMode =  DefaultImageViewContentMode;
        cell.imgHeader.image = tImg;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FoodListHeigt;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FoodDetailViewController *fdv = [[FoodDetailViewController alloc]init];
    fdv.mStoreItem = [mDataArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:fdv animated:YES];
    
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
//                if (!data || data.length <2000) {
//                    NSLog(@"请求图片失败");
//                    [request requestAgain];
//                    return;
//                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                StoreItem *tmpStroeItem = [mDataArr objectAtIndex:ir.indexPath.row];
                [XTFileManager saveTmpFolderFileWithUrlPath:tmpStroeItem.storeMiniPic with:rImage];
                FoodListTableViewCell  * pc = (FoodListTableViewCell * )[self.tTableView cellForRowAtIndexPath:ir.indexPath];
                if (pc) {
                    pc.imgHeader.contentMode = DefaultImageViewContentMode;
                    pc.imgHeader.image = rImage;
                }
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERYSTOREBYCATEGORY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    isRequestSuc = YES;
                    NSLog(@"请求成功");
                    [mDataArr removeAllObjects];
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        NSArray *tmpArr = [dic objectForKey:@"storeList"];
                        
                        
//                        [mDataArr addObjectsFromArray:[StoreItem getStoreItemsWithArr:tmpArr]];
//                        [mDataArr addObjectsFromArray:[StoreItem getStoreItemsWithArr:tmpArr]];
//                        [mDataArr addObjectsFromArray:[StoreItem getStoreItemsWithArr:tmpArr]];
                        
                        
                        tCount = [[dic objectForKey:@"total"] intValue];
                        if (tmpArr) {
                            tmpArr = [StoreItem getStoreItemsWithArr:tmpArr];
                            if (tmpArr) {
                                [mDataArr addObjectsFromArray:tmpArr];
                                [self.tTableView reloadData];
                            }
                        }
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
