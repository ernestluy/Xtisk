//
//  ComCommendViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ComCommendViewController.h"
#import "PublicDefine.h"
#import "DetailFoodCommendTableViewCell.h"
@interface ComCommendViewController ()
{
    NSMutableArray *mComArr;
    
    UILabel *labNote;
}
@end

@implementation ComCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mComArr = [NSMutableArray array];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64);
    self.tTableView = [[LYTableView alloc]initWithFrame:tableRect style:UITableViewStylePlain];
//    self.tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tTableView];
    self.tTableView.dataSource = self;
    self.tTableView.delegate = self;
    
    self.tTableView.lyDelegate = self;
    [self.tTableView setNeedBottomFlush];
    [self.tTableView setNeedTopFlush];
    
    [self.tTableView registerNib:[UINib nibWithNibName:@"DetailFoodCommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.title = @"网友评价";
    
    
    labNote = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, bounds.size.width, 100)];
    labNote.text = @"暂时没有评价\n下拉可以刷新"  ;
    labNote.font = DefaultCellFont;
    labNote.numberOfLines = 0;
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    labNote.textAlignment = NSTextAlignmentCenter;
    labNote.textColor = defaultTextColor;
    [self.view addSubview:labNote];
    labNote.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    
    if (!isRequestSucMark) {
        [self.tTableView upToStartFlush];
    }
}

#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    if (self.vcType == CommendVcStore) {
        [[[HttpService sharedInstance] getRequestStoreCommentsList:self storeId:int2str(self.storeId) pageNo:1 pageSize:DefaultPageSize]startAsynchronous];
    }else if (CommendVcActivity == self.vcType){
        [[[HttpService sharedInstance] getRequestactivityCommentsList:self activityId:int2str(self.activityId) pageNo:1 pageSize:DefaultPageSize]startAsynchronous];
    }
    
}
- (void)flushUpEnd:(NSObject *)ly{
    
}
- (void)startToFlushDown:(NSObject *)ly{
    if (self.vcType == CommendVcStore) {
        [[[HttpService sharedInstance] getRequestStoreCommentsList:self storeId:int2str(self.storeId) pageNo:(curPage+1) pageSize:DefaultPageSize]startAsynchronous];
    }else if (CommendVcActivity == self.vcType){
        [[[HttpService sharedInstance] getRequestactivityCommentsList:self activityId:int2str(self.activityId) pageNo:(curPage+1) pageSize:DefaultPageSize]startAsynchronous];
    }
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
    
    return mComArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    DetailFoodCommendTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil) {
        cell = [[DetailFoodCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CommentsItem *ci = [mComArr objectAtIndex:indexPath.row];
    [cell setDataWith:ci];
    return cell;
    
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return COMMEND_CELL_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
                
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_ACTIVITYCOMMENTSLIST:
        case HttpRequestType_XT_STORECOMMENTSLIST:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    isRequestSucMark = YES;
                    NSDictionary *dic = (NSDictionary *)br.data;
                    NSArray *tmpComArr = [dic objectForKey:@"items"];
                    tmpComArr = [CommentsItem getCommentsItemsWithArr:tmpComArr];
                    if (self.tTableView.flushDirType == FlushDirDown) {
                        [mComArr addObjectsFromArray:tmpComArr];
                    }else{
                        [mComArr removeAllObjects];
                        [mComArr addObjectsFromArray:tmpComArr];
                    }
                    
                    if (mComArr.count == 0) {
                        labNote.hidden = NO;
                        self.tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    }else{
                        labNote.hidden = YES;
                        self.tTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                    }
                    
                    [self.tTableView flushDoneStatus:YES];
                    [self.tTableView reloadData];
                    return;
                    
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
