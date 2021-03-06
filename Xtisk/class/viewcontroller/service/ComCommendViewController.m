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
#import "LoginViewController.h"
#import "EditTextViewController.h"

@interface ComCommendViewController ()
{
    NSMutableArray *mComArr;
    
    UILabel *labNote;
    UILabel *labNoteNoData;
    CommentPad *commentPad;
    int iLimitNum;
}
@end

@implementation ComCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mComArr = [NSMutableArray array];
    iLimitNum = 160;
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64 - 44);
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
    
    
//    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    doneBtn.frame = CGRectMake(0, 0, 30, 20);
//    [doneBtn setTitle:@"评价" forState:UIControlStateNormal];
//    [doneBtn setTitleColor:headerColor forState:UIControlStateNormal];
//    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    
//    [doneBtn addTarget:self action:@selector(toCommend:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn] ;
//    
//    
//    [self.navigationItem setRightBarButtonItems:@[doneItem]];
    
    labNoteNoData = [CTLCustom labelNoteNoData];
    
    
    //底部评价按钮
    int commendHeight = 44;
    UIView *cView = [[UIView alloc]initWithFrame:CGRectMake(0, bounds.size.height - 64 - commendHeight, bounds.size.width, commendHeight)];
    [self.view addSubview:cView];
    
    UIButton *btnCommend = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCommend setImage:[UIImage imageNamed:@"commend_bar"] forState:UIControlStateNormal];
    [btnCommend setImage:[UIImage imageNamed:@"commend_bar"] forState:UIControlStateHighlighted];
    btnCommend.frame = cView.bounds;
    [cView addSubview:btnCommend];
    [btnCommend addTarget:self action:@selector(toCommend:) forControlEvents:UIControlEventTouchUpInside];
    
    commentPad = [[CommentPad alloc]init];
    commentPad.delegate = self;
    commentPad.limitNum = iLimitNum;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    if (!isRequestSucMark) {
        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [self.tTableView upToStartFlush];
    }
}

-(void)flushUI{
    if (mComArr.count == 0) {
        self.tTableView.tableFooterView = labNoteNoData;
    }else{
        self.tTableView.tableFooterView = nil;
    }
    [self.tTableView reloadData];
}

-(void)toCommend:(id)sender{
    NSLog(@"toCommend");
    
    
    
    if (self.vcType == CommendVcActivity) {
//        EditTextViewController *ec = [[EditTextViewController alloc]initWithType:PrivateEditTextActivity delegate:nil];
//        ec.activityId = self.mActivityItem.activityId;
//        ec.mActivityItem = self.mActivityItem;
//        ec.comDelegate = self;
        if (![[SettingService sharedInstance] isLogin]) {
            LoginViewController *lv = [[LoginViewController alloc]init];
            lv.delegate  =  self;
            [self.navigationController pushViewController:lv animated:YES];
            return;
        }
//        [self.navigationController pushViewController:ec animated:YES];
        [commentPad show];
    }else if (self.vcType == CommendVcStore) {
//        EditTextViewController *ec = [[EditTextViewController alloc]initWithType:PrivateEditTextFoodCommend delegate:nil];
//        ec.storeId = self.mStoreItem.storeId;
//        ec.mStoreItem = self.mStoreItem;
//        ec.comDelegate = self;
        if (![[SettingService sharedInstance] isLogin]) {
            LoginViewController *lv = [[LoginViewController alloc]init];
            lv.delegate  =  self;
            [self.navigationController pushViewController:lv animated:YES];
            return;
        }
//        [self.navigationController pushViewController:ec animated:YES];
        [commentPad show];
    }
    
}

- (void)loginSucBack:(LoginViewController *)loginVc{
    NSLog(@"loginSucBack");
//    [commentPad performSelector:@selector(show) withObject:nil afterDelay:0.2];
    [commentPad show];
}
#pragma mark - CommentPadDelegate
- (void)commentPadHide:(CommentPad *)cPad{
    
}
-(void)commentPadShow:(CommentPad *)cPad{
    
}
-(void)commentPadSubmit:(CommentPad *)cPad{
    NSLog(@"commentPadSubmit");

    if (cPad.textView.text.length == 0) {
        NSString *strNote = [NSString stringWithFormat:@"长度格式必须为1-%d",iLimitNum];
        [SVProgressHUD showErrorWithStatus:strNote duration:2];
        return;
    }
    
    if (cPad.textView.text.length > iLimitNum) {
        [SVProgressHUD showErrorWithStatus:@"太多啦，删几个字吧！" duration:3];
        return;
    }
    [commentPad hide];
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    if (self.vcType == CommendVcStore) {//店铺评论
        [[[HttpService sharedInstance] getRequestStoreComments:self storeId:int2str(self.storeId) content:cPad.textView.text]startAsynchronous];
    }else if (self.vcType == CommendVcActivity){//活动评论
        [[[HttpService sharedInstance] getRequestActivityComments:self activityId:int2str(self.activityId) content:cPad.textView.text]startAsynchronous];
    }
}
#pragma mark - CommentViewControllerDelegate

- (void)commentDelegate:(int)result{
    NSLog(@"commentDelegate");
    [self.tTableView upToStartFlush];
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
    
//    cell.labContent.backgroundColor = [UIColor yellowColor];
//    CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath
    CGRect rect = [tv rectForRowAtIndexPath:indexPath];
    cell.labContent.frame = CGRectMake(27, 52, 274, rect.size.height - 52);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    CommentsItem *ci = [mComArr objectAtIndex:indexPath.row];
    [cell setDataWith:ci];
    
    
    UIImage *tImg = [XTFileManager getCacheFolderFileWithUrlPath:ci.userImg];
    if (!tImg) {
        //down_img_small.png
        cell.imgHeader.contentMode = DefaultImageViewInitMode;
        cell.imgHeader.image = [UIImage imageNamed:@"down_img_small.png"];
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:ci.userImg
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
    
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentsItem *ci = [mComArr objectAtIndex:indexPath.row];
    return [ci getCellHeight];
//    return COMMEND_CELL_HEIGHT;
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
                if (!data || data.length <DefaultImageMinSize) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                CommentsItem *ci = [mComArr objectAtIndex:ir.indexPath.row];
                [XTFileManager saveCacheFolderFileWithUrlPath:ci.userImg with:rImage];
                DetailFoodCommendTableViewCell  * pc = (DetailFoodCommendTableViewCell * )[self.tTableView cellForRowAtIndexPath:ir.indexPath];
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
                        curPage ++;
                    }else{
                        [mComArr removeAllObjects];
                        [mComArr addObjectsFromArray:tmpComArr];
                        curPage = 1;
                    }
                    
                    
                    if (tmpComArr.count>0) {
                        [self.tTableView flushDoneStatus:YES];
                    }else{
                        [self.tTableView flushDoneStatus:NO];
                    }
//                    [self.tTableView flushDoneStatus:YES];
                    [self flushUI];
                    [self.tTableView reloadData];
                    return;
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
            }
            [self.tTableView flushDoneStatus:NO];
            break;
        }
        case HttpRequestType_XT_ACTIVITYCOMMENTS:
        case HttpRequestType_XT_STORECOMMENTS:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    if (HttpRequestType_XT_ACTIVITYCOMMENTS == request.m_requestType) {
                        self.mActivityItem.reviews += 1;
                    }else if (HttpRequestType_XT_STORECOMMENTS == request.m_requestType) {
                        self.mStoreItem.reviews += 1;
                    }
                    [SVProgressHUD showSuccessWithStatus:@"评价成功" duration:DefaultRequestDonePromptTime];
                    [commentPad hide];
                    [commentPad clearData];
//                    commentPad.textView.text = @"";
                    [self.tTableView upToStartFlush];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                [SVProgressHUD showSuccessWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
            
            
        default:
            break;
    }
}



@end
