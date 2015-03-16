//
//  MyTicketDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyTicketDetailViewController.h"
#import "PublicDefine.h"
@interface MyTicketDetailViewController ()
{
    UITableView *tTableView;
    
    UILabel *labName;
    UILabel *labEmal;
    UILabel *labCard;
    UILabel *labPhone;
    NSArray *titleArr;
    UIFont *tFont;
    
    UIButton *btnOrder;
}
@end

@implementation MyTicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"船票详情";
    titleArr = @[@"姓名:",@"手机号码:",@"身份证后三位:",@"邮箱:"];
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
        }
    }
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 70)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    int startX = 15;
    btnOrder.frame = CGRectMake(startX, 20, bounds.size.width - 15*2, 44);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"去支付" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"radiu_done"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    tTableView.tableFooterView = footView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestQueryTicketOrderDetail:self orderId:int2str(self.mOrderDetail.orderId)]startAsynchronous];
}


-(void)payAction:(id)sender{
    NSLog(@"payAction  去支付");

    
    //[SVProgressHUD showWithStatus:DefaultRequestPrompt];
    
    
    NSLog(@"submit");
}

-(void)flushUI{
    labName.text = self.mOrderDetail.peopleInfo.name;
    labPhone.text = self.mOrderDetail.peopleInfo.phone;
    labEmal.text = self.mOrderDetail.peopleInfo.email;
    labCard.text = self.mOrderDetail.peopleInfo.identity_card;
    [tTableView reloadData];
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
    }else if (1 == section){
        return 4;
    }
    return 4;
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
    
    switch (indexPath.section) {
        case 0:{
            cell.textLabel.text = @"";
//            [cell addSubview:statisView];
            break;
        }
        case 1:{
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
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 100 ;
    }else if (1 == indexPath.section){
        return 44.0;
    }
    return 100.0;
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
                        //                        int tTotal = [[dic objectForKey:@"total"] intValue];
                        //orderList
                        MyTicketOrderDetail *mDetail = [MyTicketOrderDetail getMyTicketOrderDetailWithDic:dic];
                        self.mOrderDetail = mDetail;
                        
                        
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
