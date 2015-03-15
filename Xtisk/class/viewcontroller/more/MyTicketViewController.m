//
//  MyTicketViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketViewController.h"
#import "MyTicketsListTableViewCell.h"
#import "PublicDefine.h"
#import "MyTicketDetailViewController.h"
#define kMyTicketsCellId @"kMyTicketsCellId"
@interface MyTicketViewController ()
{
    UITableView *tTableView;
    NSMutableArray *allMyTicketArr;
    
    UILabel *labNoteNoData;
}
@end

@implementation MyTicketViewController

-(void)dealloc{
    NSLog(@"MyTicketViewController dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"船票订单";
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    
    [tTableView registerNib:[UINib nibWithNibName:@"MyTicketsListTableViewCell" bundle:nil] forCellReuseIdentifier:kMyTicketsCellId];
    
    [self.view addSubview:tTableView];
    
    labNoteNoData = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    labNoteNoData.text = @"暂无数据";
    labNoteNoData.font = [UIFont systemFontOfSize:14];
    labNoteNoData.textColor = defaultTextColor;
    labNoteNoData.textAlignment = NSTextAlignmentCenter;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestQueryMyTicketOrder:self]startAsynchronous];
}


-(void)flushUI{
    if (allMyTicketArr.count == 0) {
        tTableView.tableFooterView = labNoteNoData;
    }else{
         tTableView.tableFooterView = nil;
    }
    [tTableView reloadData];
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;//allMyTicketArr.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
    //    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"commitEditing");
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
        NSLog(@"sec:%d,row:%d",(int)indexPath.section,(int)indexPath.row);
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        TicketOrderListItem *item = [allMyTicketArr objectAtIndex:indexPath.row];
        [allMyTicketArr removeObjectAtIndex:indexPath.row];
        [[[HttpService sharedInstance] getRequestDelMyTicketOrder:self orderIds:@[item.orderId]]startAsynchronous];
        
    }
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyTicketsListTableViewCell * cell = (MyTicketsListTableViewCell*)[tv dequeueReusableCellWithIdentifier:kMyTicketsCellId];
//    TicketOrderListItem *item = [allMyTicketArr objectAtIndex:indexPath.row];
//    [cell setData:item];
    cell.detailTextLabel.text = @"状态";
    return cell;
}

#pragma mark - UITableViewDelegate
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return NO;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 7;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEFAULT_CELL_HEIGHT;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.5;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyTicketDetailViewController *tv = [[MyTicketDetailViewController alloc]init];
//    TicketOrderListItem *item = [allMyTicketArr objectAtIndex:indexPath.row];
//    tv.mOrderDetail = [MyTicketOrderDetail createMyTicketOrderDetailWithPerant:item];
    [self.navigationController pushViewController:tv animated:YES];
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
            
        case HttpRequestType_XT_QUERY_MY_TICKETS:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
//                        int tTotal = [[dic objectForKey:@"total"] intValue];
                        //orderList
                        NSArray *tmpArr = [dic objectForKey:@"items"];
                        tmpArr = [TicketOrderListItem getTicketOrderListItemsWithArr:tmpArr];
                        if(tmpArr){
                            [allMyTicketArr addObjectsFromArray:tmpArr];
                        }
                        
                        [self flushUI];
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                NSLog(@"请求失败");
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
            }
            break;
        }
        case HttpRequestType_XT_DEL_MY_TICKETS:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    
                    [SVProgressHUD showSuccessWithStatus:@"成功删除" duration:DefaultRequestDonePromptTime];
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
