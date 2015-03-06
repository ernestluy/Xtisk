//
//  ActivityViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityViewController.h"
#import "PublicDefine.h"
#import "ActivityListTableViewCell.h"
#import "ActivityDetailViewController.h"
@interface ActivityViewController ()
{
    NSMutableArray *mDataArr;
}
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mDataArr = [NSMutableArray array];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64);
    self.tTableView = [[LYTableView alloc]initWithFrame:tableRect style:UITableViewStylePlain];
    [self.view addSubview:self.tTableView];
    self.tTableView.dataSource = self;
    self.tTableView.delegate = self;
    self.tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tTableView.backgroundColor = _rgb2uic(0xfbf8f2, 1);
    
    self.tTableView.lyDelegate = self;
    [self.tTableView setNeedBottomFlush];
    [self.tTableView setNeedTopFlush];
    
    [self.tTableView registerNib:[UINib nibWithNibName:@"ActivityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.title = @"园区活动";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!isRequestSucMark) {
        [self.tTableView upToStartFlush];
    }
}

#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    [[[HttpService sharedInstance] getRequestActivityList:self pageNo:1 pageSize:DefaultPageSize]startAsynchronous];
}
- (void)flushUpEnd:(NSObject *)ly{
    
}
- (void)startToFlushDown:(NSObject *)ly{
    [[[HttpService sharedInstance] getRequestActivityList:self pageNo:(curPage+1) pageSize:DefaultPageSize]startAsynchronous];
}
- (void)flushDownEnd:(NSObject *)ly{
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.tTableView setIsDraging:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [self.tTableView judgeDragIng];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    NSLog(@"drag end");
    [self.tTableView judgeDragEnd];
    
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
    NSString *identifier = @"cell";
    ActivityListTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor clearColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ActivityItem *item = [mDataArr objectAtIndex:indexPath.row];
    UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:item.activityPic];
    if (!tImg) {
        //down_img
        cell.imgHeader.contentMode = DefaultImageViewInitMode;
        cell.imgHeader.image = [UIImage imageNamed:@"down_img"];
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:item.activityPic
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
    
    return 130.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityItem *item = [mDataArr objectAtIndex:indexPath.row];
    ActivityDetailViewController *ac = [[ActivityDetailViewController alloc]init];
    ac.mActivityItem = item;
    [self.navigationController pushViewController:ac animated:YES];
    
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
                ActivityItem *item = [mDataArr objectAtIndex:ir.indexPath.row];
                [XTFileManager saveTmpFolderFileWithUrlPath:item.activityPic with:rImage];
                ActivityListTableViewCell  * pc = (ActivityListTableViewCell * )[self.tTableView cellForRowAtIndexPath:ir.indexPath];
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
        case HttpRequestType_XT_ACTIVITYLIST:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    isRequestSucMark = YES;
                    NSLog(@"请求成功");
                    [mDataArr removeAllObjects];
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        NSArray *tmpArr = [dic objectForKey:@"items"];
                        
                        
                        tCount = [[dic objectForKey:@"total"] intValue];
                        if (tmpArr) {
                            tmpArr = [ActivityItem getActivityItemsWithArr:tmpArr];
                            if (tmpArr) {
                                if (self.tTableView.flushDirType == FlushDirDown) {
                                    [mDataArr addObjectsFromArray:tmpArr];
                                }else{
                                    [mDataArr removeAllObjects];
                                    [mDataArr addObjectsFromArray:tmpArr];
                                }
                                [self.tTableView flushDoneStatus:YES];
                                [self.tTableView reloadData];
                                return;
                            }
                        }
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            [self.tTableView flushDoneStatus:NO];
            break;
        }
        default:
            break;
    }
}




@end
