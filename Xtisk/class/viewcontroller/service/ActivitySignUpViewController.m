//
//  ActivitySignUpViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivitySignUpViewController.h"
#import "PublicDefine.h"
#import "CTLCustom.h"
#import "PopoverView.h"
@interface ActivitySignUpViewController ()
{
    NSMutableArray *titleArr;
    UITextField *tfNme;
    UITextField *tfTel;
    UILabel *labGender;
    UITextField *tfEmail;
    
    UITextField *nowTextField;
    
    PopoverView *tPopView;
    UIPickerView *mPickerView;
    
    NSArray *genderArr;
    UIButton *btnOrder;
    
    JoinInfo *mJoinInfo;
    
    UIView *modelView;
}
@end

@implementation ActivitySignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"填写报名信息";
    genderArr = @[@"男",@"女"];
    titleArr = [NSMutableArray arrayWithArray:@[@"姓名:",@"手机号码:",@"性别:",@"邮箱:"]];
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64);
    tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    
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
    [btnOrder addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    modelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 10 + DEFAULT_CELL_HEIGHT*4)];
    modelView.backgroundColor = [UIColor clearColor];
    [tTableView addSubview:modelView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
    
    if (ActivityVcBrow == self.signUpInfoType) {
        UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(0, 0, 30, 20);
        [doneBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [doneBtn setTitleColor:headerColor forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [doneBtn addTarget:self action:@selector(toEditStatus:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn] ;
        
//        UIButton * btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
//        btnCancel.frame = CGRectMake(0, 0, 30, 20);
//        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
//        [btnCancel setTitleColor:headerColor forState:UIControlStateNormal];
//        btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
        
//        [btnCancel addTarget:self action:@selector(toCancel:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:btnCancel] ;
        
        [self.navigationItem setRightBarButtonItems:@[doneItem]];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (ActivityVcBrow == self.signUpInfoType) {

        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [[[HttpService sharedInstance] getRequestQueryActivityJoinInfo:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];
    }
//    else if (ActivityVcEdit == self.signUpInfoType) {
//        modelView.hidden = YES;
//    }else if (ActivityVcSignUp == self.signUpInfoType) {
//        modelView.hidden = YES;
//    }
//    [self performSelector:@selector(initData) withObject:nil afterDelay:1.5];
    [self flushUI];
}
-(void)flushUI{
    if (ActivityVcBrow == self.signUpInfoType) {
        
        modelView.hidden = NO;
        [btnOrder setTitle:@"取消报名" forState:UIControlStateNormal];
    }else if (ActivityVcEdit == self.signUpInfoType) {
        modelView.hidden = YES;
        [btnOrder setTitle:@"提交修改" forState:UIControlStateNormal];
    }else if (ActivityVcSignUp == self.signUpInfoType) {
        modelView.hidden = YES;
        [btnOrder setTitle:@"提 交" forState:UIControlStateNormal];
    }
    
}
-(void)initData{
    tfNme.text = @"卢一"    ;
    tfTel.text = @"13418884362"    ;
    tfEmail.text = @"erera@df.com"    ;
}
-(void)toEditStatus:(id)sender{
    NSLog(@"toEdit");
    self.signUpInfoType = ActivityVcEdit;
    [self flushUI];
    [self.navigationItem setRightBarButtonItems:@[]];
    [tfNme becomeFirstResponder];
//    [tTableView reloadData];
}

-(void)toCancel:(id)sender{
    NSLog(@"toCancel");
    self.signUpInfoType = ActivityVcEdit;
//    [tTableView reloadData];
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestCancelActivityJoin:self activityId:int2str(self.mActivityItem.activityId)]startAsynchronous];

}

-(void)toDone:(id)sender{
    NSLog(@"toDone");
}

-(void)changeGenderDone{
    labGender.text = [genderArr objectAtIndex:[mPickerView selectedRowInComponent:0]];
    if (tPopView) {
        [tPopView dismiss];
    }
}

-(void)selectGender:(id)sender{
    [tfNme resignFirstResponder];
    [tfEmail resignFirstResponder];
    [tfTel resignFirstResponder];
    
    CGRect rt = [UIScreen mainScreen].bounds;
    UIView *tView = [[UIView alloc]init];
    
    UIView *toolbar = [[UIView alloc]initWithFrame: CGRectMake(0.0f, 0.0f,rt.size.width, 44.0f)];
    toolbar.backgroundColor = [UIColor lightGrayColor];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    doneButton.tag = 0;
    doneButton.layer.borderWidth = 1;
    doneButton.layer.borderColor = [UIColor whiteColor].CGColor;
    doneButton.layer.cornerRadius = 4;
    doneButton.frame = CGRectMake(CGRectGetMaxX(toolbar.frame) - 70.0, 4, 64.0, 44.0-8);
    [doneButton addTarget: self action: @selector(changeGenderDone) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview: doneButton];
    [tView addSubview: toolbar];
    
    UIPickerView *pv = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, rt.size.width, 216)];
    pv.delegate = self;
    pv.dataSource = self;
    [tView addSubview:pv];
    mPickerView = pv;
    
    int allH = 216 + 44;
    tView.frame = CGRectMake(0, rt.size.height - allH, rt.size.width, allH);
    
    
    tPopView = [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:tView];
}

-(void)setInfo:(JoinInfo*)jInfo{
    tfNme.text = jInfo.joinName;
    tfTel.text = jInfo.joinPhone;
    tfEmail.text = jInfo.joinEmail;
    labGender.text = jInfo.joinGender;
}
-(JoinInfo *)getJoinInfo{
    JoinInfo *jInfo = [[JoinInfo alloc]init];
    jInfo.joinName = tfNme.text;
    jInfo.joinPhone = tfTel.text;
    jInfo.joinEmail = tfEmail.text;
    jInfo.joinGender = labGender.text;
    return jInfo;
}
-(BOOL)judgeTextFieldFormat{
    
    if (tfNme.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空" duration:2];
        return NO;
    }
    
    if (tfTel.text.length == 0||tfTel.text.length>50) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式不对" duration:2];
        return NO;
    }
    
    if (tfEmail.text.length == 0 ||tfEmail.text.length>100) {
        [SVProgressHUD showErrorWithStatus:@"邮箱格式不对" duration:2];
        return NO;
    }
    
    return YES;
}

-(void)signUp:(id)sender{
    NSLog(@"signUp");
    if (ActivityVcBrow == self.signUpInfoType){
        [self toCancel:nil];
    }else if (ActivityVcEdit==self.signUpInfoType){
        
        if (![self judgeTextFieldFormat]) {
            return;
        }
        
        JoinInfo *jInfo = [self getJoinInfo];
        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [[[HttpService sharedInstance]getRequestUpdateActivityJoinInfo:self activityId:int2str(self.mActivityItem.activityId) joinInfo:jInfo]startAsynchronous];
    }else if (ActivityVcSignUp==self.signUpInfoType){
        if (![self judgeTextFieldFormat]) {
            return;
        }
        JoinInfo *jInfo = [self getJoinInfo];
        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [[[HttpService sharedInstance]getRequestJoinActivity:self activityId:int2str(self.mActivityItem.activityId) joinInfo:jInfo]startAsynchronous];
    }
    
}
-(void)editSignUpInfo:(id)sender{
    NSLog(@"editSignUpInfo");
    JoinInfo *jInfo = [self getJoinInfo];
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance]getRequestUpdateActivityJoinInfo:self activityId:int2str(self.mActivityItem.activityId) joinInfo:jInfo]startAsynchronous];

}


-(void)tapped:(UITapGestureRecognizer *)tap
{
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return genderArr.count;
}
#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [genderArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

#pragma mark textfieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    if (tfNme == textField) {
        [tfTel becomeFirstResponder];
    }else if (tfTel == textField) {
        [tfEmail becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (tfEmail == textField) {
        if (range.location >= 100)
        {
            return NO;
        }
    }else if (tfNme == textField){
        if (range.location >= 40)
        {
            return NO;
        }
    }else if (tfTel == textField){
        if (range.location >= 20)
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

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return titleArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil) {
        int textFieldWidth = 200;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        int startX = 15 + [cell.textLabel.text sizeWithFont:cell.textLabel.font].width + 5 ;
        
        CGRect textFieldRect = CGRectMake(startX, 0.0f, [UIScreen mainScreen].bounds.size.width - startX - 1, 44.0);
        
        if (2 == indexPath.row) {
            UILabel *tLab = [CTLCustom getCusRightLabel:textFieldRect];
            [cell addSubview:tLab];
            tLab.textAlignment = NSTextAlignmentLeft;
            labGender = tLab;
            tLab.text = @"男";
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 320, 44);
            [btn addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }else{
            UITextField *theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
            theTextField.textAlignment = NSTextAlignmentLeft;
            theTextField.tag = indexPath.row;
            theTextField.returnKeyType = UIReturnKeyNext;
            theTextField.delegate = self;
            theTextField.placeholder = @"请输入";
            theTextField.font = cell.textLabel.font;
//            theTextField.backgroundColor = [UIColor lightGrayColor];
            [cell addSubview:theTextField];
            //        theTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            if (0 == indexPath.row) {
                tfNme = theTextField;
            }else if (1 == indexPath.row) {
                tfTel = theTextField;
            }else if (3 == indexPath.row) {
                tfEmail = theTextField;
                theTextField.returnKeyType = UIReturnKeyDone;
            }
        }
        
    }
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        
        case HttpRequestType_XT_JOINACTIVITY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    isRequestSucMark = YES;
                    NSLog(@"请求成功");
                    //{"code":0,"msg":"成功","data":{}}
                    self.mActivityItem.isJoin = YES;
//                    NSDictionary *dic = (NSDictionary *)br.data;
//                    self.mActivityItem.isJoin = [[dic objectForKey:@"isJoin"] boolValue];
//                    int joinPeople = [[dic objectForKey:@"joinPeople"] boolValue];
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD showErrorWithStatus:@"恭喜你报名成功" duration:DefaultRequestDonePromptTime];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:3];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_CANCELACTIVITYJOIN:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                //{"code":0,"msg":"","data":{"joinPeople":1}}
                if (ResponseCodeSuccess == br.code) {
//                    isRequestSucMark = YES;
                    NSLog(@"取消成功");
                    self.mActivityItem.isJoin = NO;
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD showErrorWithStatus:@"取消报名成功" duration:DefaultRequestDonePromptTime];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:3];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERYACTIVITYJOININFO:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSDictionary *dic = (NSDictionary *)br.data;
                    JoinInfo *ji = [JoinInfo getJoinInfoWithDic:dic];
                    [self setInfo:ji];
                    [tTableView reloadData];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_UPDATEACTIVITYJOININFO:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD showErrorWithStatus:@"修改报名信息成功" duration:DefaultRequestDonePromptTime];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
        default:
            break;
    }
}

@end
