//
//  TicketOrderEditViewController.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketOrderEditViewController.h"
#import "StatisTicketView.h"
#import "PublicDefine.h"
#import "LoginViewController.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"
#import "MyTicketDetailViewController.h"
@interface TicketOrderEditViewController ()
{
    UITableView *tTableView;
    
    UITextField *tfName;
    UITextField *tfEmal;
    UITextField *tfCard;
    UITextField *tfPhone;
    
    UITextField *nowTextField;
    
    NSArray *titleArr;
    
    UIFont *tFont;
    UIButton *btnOrder;
    
    StatisTicketView *statisView;
    
    BOOL isInput;
    
    TicketTradeInfo *tradeInfo;
}

-(void)tapped:(UITapGestureRecognizer *)tap;

-(void)toPay;

- (void)showAlertMessage:(NSString*)msg;


@end

@implementation TicketOrderEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单填写";
    titleArr = @[@"姓名:",@"手机号码:",@"身份证后三位:",@"邮箱:"];
    tFont = [UIFont systemFontOfSize:15];
    isInput = NO;
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64) ;
    statisView = [[StatisTicketView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    statisView.backgroundColor = [UIColor clearColor];
    [statisView layoutUI];
    
    
    tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    [self.view addSubview:tTableView];
//    tTableView.tableHeaderView = st;
    
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    for (int i = 0; i<titleArr.count; i++) {
        int startX = 15 + [[titleArr objectAtIndex:i] sizeWithFont:tFont].width + 5 ;
        CGRect textFieldRect = CGRectMake(startX, 0.0f, [UIScreen mainScreen].bounds.size.width - startX - 1, 44.0);
        UITextField *tmpTf = [CTLCustom textFieldNormalWith:textFieldRect];
        tmpTf.delegate = self;
        
        if (i == 0) {
            tfName = tmpTf;
            tfName.text = @"卢一";
        }else if (i == 1) {
            tfPhone = tmpTf;
            tfPhone.text = @"13418884362";
        }else if (i == 2) {
            tfCard = tmpTf;
            tfCard.text = @"234";
        }else if (i == 3) {
            tfEmal = tmpTf;
            tfEmal.text = @"175640827@163.com";
            tfEmal.keyboardType = UIKeyboardTypeEmailAddress;
            tfEmal.returnKeyType = UIReturnKeyDone;
        }
    }
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 70)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    int startX = 15;
    btnOrder.frame = CGRectMake(startX, 20, bounds.size.width - 15*2, 44);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"提交订单" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    tTableView.tableFooterView = footView;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)tapped:(UITapGestureRecognizer *)tap
{
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
}

-(void)orderAction:(id)sender{
    NSLog(@"orderAction");
    if (tfName.text.length == 0  ) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空" duration:DefaultRequestDonePromptTime];
        return;
    }
    if ( tfPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"电话不能为空" duration:DefaultRequestDonePromptTime];
        return;
    }
    if (tfCard.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"身份证后三位不能为空" duration:DefaultRequestDonePromptTime];
        return;
    }
    if (tfEmal.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"email不能为空" duration:DefaultRequestDonePromptTime];
        return;
    }
    
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    
    TicketOrder *order = [[TicketSerivice sharedInstance] createTicketOrder];
    order.name = tfName.text;
    order.email = tfEmal.text;
    order.phone = tfPhone.text;
    order.cardNum = tfCard.text;
    
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestSubmitBooking:self info:order]startAsynchronous];
    //{"code":110401,"msg":"取票验证码不能为空","data":{}}
    NSLog(@"submit");
}


-(void)toPay{
//    if (tradeInfo.tn != nil && tradeInfo.tn.length > 0)
//    {
//        NSLog(@"tn=%@",tradeInfo.tn);
//        [UPPayPlugin startPay:tradeInfo.tn mode:kMode_Development viewController:self delegate:self];
//    }else{
//        NSString *strNote = [NSString stringWithFormat:@"交易流水号错误:%@",tradeInfo.tn];
//        [self showAlertMessage:strNote];
//    }
    
    
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    //银联手机支付控件有三个支付状态返回值:success、fail、cancel,分别代表:支 付成功、支付失败、用户取消支付
    NSString* msg = [NSString stringWithFormat:kResult, result];
    [self showAlertMessage:msg];
}

- (void)showAlertMessage:(NSString*)msg
{
    UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:self cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [_alertView show];
}
#pragma mark textfieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    if (tfName == textField) {
        [tfPhone becomeFirstResponder];
    }else if (tfPhone == textField) {
        [tfCard becomeFirstResponder];
    }else if (tfCard == textField) {
        [tfEmal becomeFirstResponder];
    }else if (tfEmal == textField){
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (tfEmal == textField) {
        if (range.location >= 100)
        {
            return NO;
        }
    }else if (tfName == textField){
        if (range.location >= 40)
        {
            return NO;
        }
    }else if (tfPhone == textField){
        if (range.location >= 20)
        {
            return NO;
        }
    }else if (tfCard == textField){
        if (range.location >= 6)
        {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    nowTextField = textField;
    isInput = YES;
    [UIView animateWithDuration:0.25 animations:^{
        tTableView.contentOffset = CGPointMake(0, 120);
    }];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (nowTextField == textField) {
        [UIView animateWithDuration:0.25 animations:^{
            tTableView.contentOffset = CGPointMake(0, 0);
        }];
    }
    return YES;
}



#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if(1 == section){
        return 4;
    }
    return 4;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell1];
    
//    NSString *tId = [NSString stringWithFormat:@"index:%d%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
    cell.textLabel.font = tFont;
    
    switch (indexPath.section) {
        case 0:{
            [cell addSubview:statisView];
            break;
        }
        case 1:{
            if (indexPath.row == 0) {
                [cell addSubview:tfName];
            }else if (indexPath.row == 1) {
                [cell addSubview:tfPhone];
            }else if (indexPath.row == 2) {
                [cell addSubview:tfCard];
            }else if (indexPath.row == 3) {
                [cell addSubview:tfEmal];
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
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return statisView.frame.size.height;
    }
    return DEFAULT_CELL_HEIGHT;
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
            
        case HttpRequestType_XT_QUERY_VOYAGE:{
            
            break;
        }
        case HttpRequestType_XT_SUBMIT_BOOKING:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *tmpDic = (NSDictionary *)br.data;
                    if (tmpDic) {
                        NSString *tn = [tmpDic objectForKey:@"tn"];
                        NSString *orderId = [tmpDic objectForKey:@"orderId"];
//                        [SVProgressHUD showSuccessWithStatus:@"订单提交成功\n" duration:2];
                        tradeInfo = [TicketTradeInfo getTicketTradeInfoWithDic:tmpDic];
                        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
                        [[[HttpService sharedInstance] getRequestQueryTicketOrderDetail:self orderId:tradeInfo.orderId]startAsynchronous];
//                        [self toPay];
//                        NSString *strNote = [NSString stringWithFormat:@"订单提交成功\n交易流水号:%@\n订单号:%@",tradeInfo.tn,tradeInfo.orderId];
//                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"订单" message:strNote delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                        [alertView show];
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
        case HttpRequestType_XT_QUERY_MY_TICKET_ORDER_DETAIL:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        //                        int tTotal = [[dic objectForKey:@"total"] intValue];
                        //orderList
                        MyTicketOrderDetail *mDetail = [MyTicketOrderDetail getMyTicketOrderDetailWithDic:dic];
                        MyTicketDetailViewController *tv = [[MyTicketDetailViewController alloc]init];
                        tv.payAction = TicketOrderDetailSeq;
                        tv.mOrderDetail = mDetail;
                        [self.navigationController pushViewController:tv animated:YES];
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
