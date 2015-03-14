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
}
-(void)tapped:(UITapGestureRecognizer *)tap;
@end

@implementation TicketOrderEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单填写";
    titleArr = @[@"姓名:",@"手机号码:",@"身份证后三位:",@"邮箱:"];
    tFont = [UIFont systemFontOfSize:15];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64) ;
    statisView = [[StatisTicketView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
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
            tfPhone.keyboardType = UIKeyboardTypePhonePad;
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
    [btnOrder setTitle:@"提 交" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"radiu_done"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    tTableView.tableFooterView = footView;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
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
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
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
                        
                        NSString *strNote = [NSString stringWithFormat:@"订单提交成功\n交易流水号:%@\n订单号:%@",tn,orderId];
                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"订单" message:strNote delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [alertView show];
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
