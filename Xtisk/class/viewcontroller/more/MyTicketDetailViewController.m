//
//  MyTicketDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketDetailViewController.h"
#import "PublicDefine.h"
#import "MyTicketOrderItemStatis.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"
#import "UPayResultView.h"
#import "TicketQueryViewController.h"
@interface MyTicketDetailViewController ()
{
    UITableView *tTableView;
    
    UILabel *labName;
    UILabel *labEmal;
    UILabel *labCard;
    UILabel *labPhone;
    
    UILabel *labStatus;
    NSArray *titleArr;
    UIFont *tFont;
    
    UIButton *btnOrder;
    UIView *footView;
    
    MyTicketOrderItemStatis *myTicketOrderStatis;
    
    UIImageView *imgViewUpay;
    
    UPayResultView *resultView;
    UIView *footFailView;
    
    UIView *footDoneView;
    
    BOOL isPaySuccss;
}

-(void)toPay;
-(void)toReOrder;
@end

@implementation MyTicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"船票详情";
    titleArr = @[@"姓名:",@"手机号码:",@"身份证后三位:",@"邮箱:",@"点单状态:"];
    imgViewUpay = [[UIImageView alloc]initWithFrame:CGRectMake(8, 1, 141, 42)];
    imgViewUpay.image = [UIImage imageNamed:@"upay_icon"];
    isPaySuccss = NO;
    
    tFont = [UIFont systemFontOfSize:15];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:tTableView];
    
    
    for (int i = 0; i<titleArr.count; i++) {
        int startX = 15 + [[titleArr objectAtIndex:i] sizeWithFont:tFont].width + 5 ;
        CGRect tRect = CGRectMake(startX, 0.0f, [UIScreen mainScreen].bounds.size.width - startX - 1, 44.0);
        UILabel *tmpLab = [CTLCustom labelNormalWith:tRect];
        tmpLab.textColor = defaultTextGrayColor;
        if (i == 0) {
            labName = tmpLab;
            labName.text = @"卢一";
        }else if (i == 1) {
            labPhone = tmpLab;
            labPhone.text = @"13418884362";
        }else if (i == 2) {
            labCard = tmpLab;
            labCard.text = @"234";
        }else if (i == 3) {
            labEmal = tmpLab;
            labEmal.text = @"175640827@163.com";
        }else if (i == 4) {
            labStatus = tmpLab;
            labStatus.textColor = defaultTextColor;
//            labStatus.text = @"175640827@163.com";
        }
    }
    
    //------------------------------------------
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 75)];
    footView.backgroundColor = [UIColor clearColor];
    
    btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    int startX = 15;
    btnOrder.frame = CGRectMake(startX, 20, bounds.size.width - 15*2, 44);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"确认支付" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
//    tTableView.tableFooterView = footView;
    //------------------------------------------
    UIImage *tmpImg = [UIImage imageNamed:@"com_submit"];
    int tWidth = (bounds.size.width - 15*3)/2;
    footFailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 75)];
    footFailView.backgroundColor = [UIColor clearColor];
    UIButton *btnRepay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRepay.frame = CGRectMake(startX, 20, tWidth, 44);
    [btnRepay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRepay setTitle:@"重新支付" forState:UIControlStateNormal];
    btnRepay.backgroundColor = [UIColor clearColor];
    [btnRepay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [btnRepay setBackgroundImage:[tmpImg stretchableImageWithLeftCapWidth:35 topCapHeight:45] forState:UIControlStateNormal];
    [footFailView addSubview:btnRepay];
    
    UIButton *btnReOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReOrder.frame = CGRectMake(startX * 2 + tWidth, 20, tWidth, 44);
    [btnReOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnReOrder setTitle:@"重新购票" forState:UIControlStateNormal];
    btnReOrder.backgroundColor = [UIColor clearColor];
    [btnReOrder addTarget:self action:@selector(toReOrder) forControlEvents:UIControlEventTouchUpInside];
    [btnReOrder setBackgroundImage:[tmpImg stretchableImageWithLeftCapWidth:35 topCapHeight:45] forState:UIControlStateNormal];
    [footFailView addSubview:btnReOrder];
    
    //------------------------------------------
    footDoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 75)];
    footDoneView.backgroundColor = [UIColor clearColor];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(startX, 20, bounds.size.width - 15*2, 44);
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone setTitle:@"完成" forState:UIControlStateNormal];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
    btnDone.backgroundColor = [UIColor clearColor];
    [btnDone addTarget:self action:@selector(orderDone) forControlEvents:UIControlEventTouchUpInside];
    [footDoneView addSubview:btnDone];
    
    //------------------------------------------
    myTicketOrderStatis = [[MyTicketOrderItemStatis alloc]init];
    myTicketOrderStatis.frame = CGRectMake(0, 0, 0, 0);
    
    resultView = [UPayResultView UPayResultViewWithXib];
    [self flushUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if(TicketOrderDetailHis == self.payAction  && !isRequestSucMark){
        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [[[HttpService sharedInstance] getRequestQueryTicketOrderDetail:self orderId:int2str(self.mOrderDetail.orderId)]startAsynchronous];
    }else if (TicketOrderDetailSeq == self.payAction){
        self.title = @"确认订单";
    }
    
}


-(void)payAction:(id)sender{
    NSLog(@"payAction  去支付");

    
    //[SVProgressHUD showWithStatus:DefaultRequestPrompt];
    
    
    NSLog(@"submit");
}

-(void)flushUI{
    [myTicketOrderStatis setData:self.mOrderDetail];
    
    labName.text = self.mOrderDetail.peopleInfo.name;
    labPhone.text = self.mOrderDetail.peopleInfo.phone;
    labEmal.text = self.mOrderDetail.peopleInfo.email;
    labCard.text = self.mOrderDetail.peopleInfo.identity_card;
    
    labStatus.text = self.mOrderDetail.orderStatus;
    if (TicketOrderDetailHis == self.payAction) {
        if (self.mOrderDetail.tn && self.mOrderDetail.tn.length>0 && self.mOrderDetail.status == tagWaitToPay) {
            tTableView.tableFooterView = footView;
        }else{
            tTableView.tableFooterView = nil;
        }
    }else if (TicketOrderDetailSeq == self.payAction){
        tTableView.tableFooterView = footView;
    }
    
    [tTableView reloadData];
}

-(void)toPay{
    if (self.mOrderDetail.tn != nil && self.mOrderDetail.tn.length > 0)
    {
        NSLog(@"tn=%@",self.mOrderDetail.tn);
        [UPPayPlugin startPay:self.mOrderDetail.tn mode:kMode_Development viewController:self delegate:self];
    }else{
        NSString *strNote = [NSString stringWithFormat:@"交易流水号错误:%@",self.mOrderDetail.tn];
        [self showAlertMessage:strNote];
    }
}

-(void)toReOrder{
    NSLog(@"toReOrder");
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TicketQueryViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

-(void)orderDone{
    NSLog(@"orderDone");
    if (TicketOrderDetailHis == self.payAction) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(TicketOrderDetailSeq == self.payAction){
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[TicketQueryViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
    
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    //银联手机支付控件有三个支付状态返回值:success、fail、cancel,分别代表:支 付成功、支付失败、用户取消支付
//    NSString* msg = [NSString stringWithFormat:kResult, result];
    if ([PaySuccess isEqualToString:result]) {
        isPaySuccss = YES;
        tTableView.tableHeaderView = resultView;
        tTableView.tableFooterView = footDoneView;
        tTableView.contentOffset = CGPointMake(0, 0);
        [resultView setCode:int2str(self.mOrderDetail.orderId) res:YES];
    }else if ([PayFail isEqualToString:result]) {
        tTableView.tableHeaderView = resultView;
        if (TicketOrderDetailHis == self.payAction) {
            tTableView.tableFooterView = footView;
        }else if(TicketOrderDetailSeq == self.payAction){//footFailView只能适用于正常顺序购票
            tTableView.tableFooterView = footFailView;
            tTableView.contentOffset = CGPointMake(0, 0);
        }
        [resultView setCode:int2str(self.mOrderDetail.orderId) res:NO];
    }else if ([PayCancel isEqualToString:result]) {
        tTableView.tableHeaderView = nil;
        if (TicketOrderDetailHis == self.payAction) {
            tTableView.tableFooterView = footView;
        }else if(TicketOrderDetailSeq == self.payAction){
            tTableView.tableFooterView = footFailView;
        }
        [self showAlertMessage:@"您取消了支付"];
    }
    [tTableView reloadData];
}

- (void)showAlertMessage:(NSString*)msg
{
    UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:self cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [_alertView show];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if (1 == section) {
        return 1;
    }else if (2 == section){
        return 4;
    }
    return 1;
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
        
        
        
    }
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = (UITableViewCell*)[tv dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = tFont;
    cell.hidden = NO;
    
    switch (indexPath.section) {
        case 0:{
            cell.textLabel.font = tFont;
            cell.textLabel.text = @"订单状态:";
            [cell addSubview:labStatus];
            if (TicketOrderDetailHis == self.payAction) {
                if (isPaySuccss) {
                    cell.hidden = YES;
                }
            }else if (TicketOrderDetailSeq == self.payAction){
                cell.hidden = YES;
            }
            break;
        }
        case 1:{
            cell.textLabel.text = @"";
            [cell addSubview:myTicketOrderStatis];
            break;
        }
        case 2:{
            cell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [cell addSubview:labName];
            }else if (indexPath.row == 1) {
                [cell addSubview:labPhone];
            }else if (indexPath.row == 2) {
                [cell addSubview:labCard];
            }else if (indexPath.row == 3) {
                [cell addSubview:labEmal];
            }
            break;
        }
        case 3:{
            [cell addSubview:imgViewUpay];
            if (TicketOrderDetailHis == self.payAction) {
                if (self.mOrderDetail.tn && self.mOrderDetail.tn.length>0 && self.mOrderDetail.status == tagWaitToPay) {
                    cell.hidden = NO;
                }else{
                    cell.hidden = YES;
                }
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section){
        if (self.payAction == TicketOrderDetailSeq) {
            return 0.0;
        }
        if (isPaySuccss) {
            return 0.0;
        }
    }else if (1 == indexPath.section) {
        return myTicketOrderStatis.frame.size.height ;
    }else if (2 == indexPath.section){
        return 44.0;
    }else if(3 == indexPath.section){
        if (TicketOrderDetailHis == self.payAction) {
            if (self.mOrderDetail.tn && self.mOrderDetail.tn.length>0 && self.mOrderDetail.status == tagWaitToPay) {
                return 44.0;
            }else{
                return 0;
            }
        }
    }
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
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
        case HttpRequestType_XT_QUERY_MY_TICKET_ORDER_DETAIL:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        isRequestSucMark = YES;
                        //                        int tTotal = [[dic objectForKey:@"total"] intValue];
                        //orderList
                        MyTicketOrderDetail *mDetail = [MyTicketOrderDetail getMyTicketOrderDetailWithDic:dic];
                        self.mOrderDetail = mDetail;
                        [myTicketOrderStatis setData:self.mOrderDetail];
                        
                        [self flushUI];
                    }

                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
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
