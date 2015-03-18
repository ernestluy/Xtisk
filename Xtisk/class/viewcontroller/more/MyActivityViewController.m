//
//  MyActivityViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyActivityViewController.h"
#import "PublicDefine.h"
#import "MyActivityTableViewCell.h"
#import "ActivityDetailViewController.h"

//活动状态，返回中文“进行中”、“已结束”、“未开始”


#define TheCellId  @"cell"
@interface MyActivityViewController ()
{
    NSMutableArray *btnArr;
    int selectedIndex;
    
    int tAcount;
    
    UIBarButtonItem * doneItem;
    UIBarButtonItem * delItem;
    
    NSMutableArray *allMyActivityArr;
    UILabel *labNoteNoData;
    
    NSIndexSet *tIndexSet;
    NSIndexPath *tIndexPath;
    
    BOOL isEdit;
    
    NSMutableDictionary *mutableDic;
    
    UIButton *btnDel;
}
@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tAcount = 5;
    allMyActivityArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.title = @"我的活动";
    self.view.backgroundColor = [UIColor whiteColor];
    btnArr = [[NSMutableArray alloc]init];
    mutableDic = [NSMutableDictionary dictionary];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    NSArray *btnTitleArr = @[@"全部",@"未开始",@"进行中",@"已结束"];
    int btnW = bounds.size.width / btnTitleArr.count;
    int btnH = 40;
    int lineHeight = 20;
    isEdit = NO;
    for (int i = 0; i<btnTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateSelected];
        btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(actListAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.selected = YES;
        }
        if (i !=0) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*btnW, (btnH - lineHeight)/2, 1, lineHeight)];
            iv.image = [UIImage imageNamed:@"line_gray"];
            [self.view addSubview:iv];
        }
        [btnArr addObject:btn];
    }
    selectedIndex = 0;
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, btnH - 1, bounds.size.width, 1)];
    iv.image = [UIImage imageNamed:@"line_gray"];
    [self.view addSubview:iv];
    
    int tableHeight = bounds.size.height - 64 - btnH;
    tTableView = [[LYTableView alloc]initWithFrame:CGRectMake(0, 40, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    
    tTableView.lyDelegate = self;
    [tTableView setNeedBottomFlush];
    [tTableView setNeedTopFlush];
    
    [tTableView registerNib:[UINib nibWithNibName:@"MyActivityTableViewCell" bundle:nil] forCellReuseIdentifier:TheCellId];
    [self.view addSubview:tTableView];
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 20, 20);
    [okBtn setBackgroundImage:[UIImage imageNamed:@"ac_delete"] forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(toDelete:) forControlEvents:UIControlEventTouchUpInside];
    delItem = [[UIBarButtonItem alloc] initWithCustomView:okBtn] ;
    
    
    //暂时没有删除接口，不提供该功能
    [self.navigationItem setRightBarButtonItem:delItem];
    
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(0, 0, 30, 20);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:headerColor forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [doneBtn addTarget:self action:@selector(doneDelete:) forControlEvents:UIControlEventTouchUpInside];
    doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn] ;
//    [self.navigationItem setRightBarButtonItem:doneItem];
    
//    进行中 f75218
//    已结束 bcbcbc
//    未开始 4ad02a
    
    btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDel addTarget:self action:@selector(deleteActivity:) forControlEvents:UIControlEventTouchUpInside];
    [btnDel setTitle:@"删   除" forState:UIControlStateNormal];
    btnDel.titleLabel.textColor = [UIColor whiteColor];
    btnDel.frame = CGRectMake(0, btnH + tableHeight - 50, bounds.size.width, 50);
    btnDel.backgroundColor = _rgb2uic(0xda3908, 1);
    [self.view addSubview:btnDel];
    btnDel.hidden = YES;
    
    
    labNoteNoData = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    labNoteNoData.text = @"暂无数据";
    labNoteNoData.font = [UIFont systemFontOfSize:14];
    labNoteNoData.textColor = defaultTextColor;
    labNoteNoData.textAlignment = NSTextAlignmentCenter;
    
    self.view.backgroundColor = tTableView.backgroundColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self requestData];
}

-(void)requestData{
    tTableView.tableFooterView = nil;
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    curPage = 1;
    [allMyActivityArr removeAllObjects];
//    [[[HttpService sharedInstance] getRequestQueryMyActivity:self activityStatus:selectedIndex pageNo:1 pageSize:DefaultPageSize]startAsynchronous];
    [tTableView upToStartFlush];
}

-(void)deleteActivity:(id)sender{
    NSLog(@"deleteActivity");
    NSArray *ids = mutableDic.allValues;
    if (ids.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"未选择要删除的活动" duration:DefaultRequestDonePromptTime];
        return;
    }
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestDelMyActivitys:self activityIds:ids]startAsynchronous];
}

-(void)doneDelete:(id)sender{
    NSLog(@"doneDelete");
    [self.navigationItem setRightBarButtonItem:delItem];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    tTableView.frame = CGRectMake(0, 40, bounds.size.width, bounds.size.height - 64 - 40);
    btnDel.hidden = YES;
    
    isEdit = NO;
    [mutableDic removeAllObjects];
    [tTableView reloadData];
    
}
-(void)toDelete:(id)sender{
    NSLog(@"toDelete");
    [self.navigationItem setRightBarButtonItem:doneItem];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    tTableView.frame = CGRectMake(0, 40, bounds.size.width, bounds.size.height - 64 - 40 - 50);
    btnDel.hidden = NO;
    CGRect tmpRect = btnDel.frame;
    btnDel.frame = CGRectMake(tmpRect.origin.x, tmpRect.origin.y + tmpRect.size.height, tmpRect.size.width, tmpRect.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        btnDel.frame = tmpRect;
        NSLog(@"");
    }];
    isEdit = YES;
    [tTableView reloadData];
//    [tTableView setEditing:YES];
}
-(void)actListAction:(id)sender{
    NSLog(@"actListAction");
    UIButton *btn = (UIButton *)sender;
    if (selectedIndex == btn.tag) {
        return;
    }
    selectedIndex = (int)btn.tag;
    for (UIButton *tBtn in btnArr) {
        tBtn.selected = NO;
    }
    
    btn.selected = YES;
    selectedIndex = (int)btn.tag;
    switch (btn.tag) {
        case 0:
            
            break;
            
        default:
            break;
    }
    [self.navigationItem setRightBarButtonItem:delItem];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    tTableView.frame = CGRectMake(0, 40, bounds.size.width, bounds.size.height - 64 - 40);
    btnDel.hidden = YES;
    
    [mutableDic removeAllObjects];
    isEdit = NO;
    curPage = 1;
    [allMyActivityArr removeAllObjects];
    [self flushUI];
    [self requestData];
}

-(void)delSelectAction:(UIButton *)btn{
    NSLog(@"delSelectAction");
    MyActivity *ma = [allMyActivityArr objectAtIndex:btn.tag];
    MyActivityTableViewCell * cell = (MyActivityTableViewCell*)[tTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:btn.tag]];
    NSObject *tmpo = [mutableDic objectForKey:int2str(ma.activityId)];
    if (tmpo) {
        cell.btnSelect.selected = NO;
        [mutableDic removeObjectForKey:int2str(ma.activityId)];
    }else{
        cell.btnSelect.selected = YES;
        [mutableDic setObject:int2str(ma.activityId) forKey:int2str(ma.activityId)];
    }
}

-(void)flushUI{
    if (allMyActivityArr.count == 0) {
        tTableView.tableFooterView = labNoteNoData;
    }else{
        tTableView.tableFooterView = nil;
    }
    [tTableView reloadData];
}
//活动状态，返回中文“进行中”、“已结束”、“未开始”
#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    [[[HttpService sharedInstance] getRequestQueryMyActivity:self activityStatus:selectedIndex pageNo:1 pageSize:DefaultPageSize]startAsynchronous];
}
- (void)flushUpEnd:(NSObject *)ly{
    
}
- (void)startToFlushDown:(NSObject *)ly{
    [[[HttpService sharedInstance] getRequestQueryMyActivity:self activityStatus:selectedIndex pageNo:(curPage+1) pageSize:DefaultPageSize]startAsynchronous];
}
- (void)flushDownEnd:(NSObject *)ly{
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tTableView setIsDraging:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [tTableView judgeDragIng];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    NSLog(@"drag end");
    [tTableView judgeDragEnd];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return allMyActivityArr.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == selectedIndex) {
        
        MyActivity *ma = [allMyActivityArr objectAtIndex:indexPath.section];
        if ([ma.status isEqualToString:AcStatusEnd]) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
//    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"commitEditing");
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
        NSLog(@"sec:%d,row:%d",(int)indexPath.section,(int)indexPath.row);
        tIndexPath = indexPath;
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        tAcount --;
        MyActivity *ma = [allMyActivityArr objectAtIndex:indexPath.section];
//        [allMyActivityArr removeObjectAtIndex:indexPath.section];
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
//        [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [[[HttpService sharedInstance] getRequestDelMyActivity:self activityId:int2str(ma.activityId)]startAsynchronous];
        
    }
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyActivityTableViewCell * cell = (MyActivityTableViewCell*)[tv dequeueReusableCellWithIdentifier:TheCellId];

    MyActivity *ma = [allMyActivityArr objectAtIndex:indexPath.section];
    cell.btnSelect.tag = indexPath.section;
    [cell.btnSelect addTarget:self action:@selector(delSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell setData:ma];
    
    [cell setIsDeleting:isEdit];
    NSObject *tmpo = [mutableDic objectForKey:int2str(ma.activityId)];
    if (tmpo) {
        cell.btnSelect.selected = YES;
    }else{
        cell.btnSelect.selected = NO;
    }
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return NO;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityDetailViewController *ac = [[ActivityDetailViewController alloc] init];
    MyActivity *ma = [allMyActivityArr objectAtIndex:indexPath.section];
    
    ac.mActivityItem = [ma aClone];
    [self.navigationController pushViewController:ac animated:YES];
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
          
        case HttpRequestType_XT_QUERYMYACTIVITY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        int tTotal = [[dic objectForKey:@"total"] intValue];
                        //改为items
//                        [allMyActivityArr removeAllObjects];
                        
                        NSArray *tmpArr = [dic objectForKey:@"items"];
                        tmpArr = [MyActivity getMyActivitysWithArr:tmpArr];
                        if (tTableView.flushDirType == FlushDirDown) {
                            curPage ++;
                            [allMyActivityArr addObjectsFromArray:tmpArr];
                        }else if (tTableView.flushDirType == FlushDirUp){
                            curPage = 1;
                            [allMyActivityArr removeAllObjects];
                            [allMyActivityArr addObjectsFromArray:tmpArr];
                        }
                        [tTableView flushDoneStatus:YES];
                        [self flushUI];
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                    [tTableView flushDoneStatus:NO];
                }
            }else{
                NSLog(@"请求失败");
                [tTableView flushDoneStatus:NO];
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
            }
            break;
        }
        case HttpRequestType_XT_DEL_MYACTIVITY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    
                    [allMyActivityArr removeObjectAtIndex:tIndexPath.section];
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:tIndexPath.section];
                    [tTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                NSLog(@"请求失败");
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
            }
            break;
        }
        default:
            break;
    }
}



@end
