//
//  EditTextViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "EditTextViewController.h"
#import "PublicDefine.h"
@interface EditTextViewController ()
{
    int limitNum;
}
@end

@implementation EditTextViewController


-(id)initWithType:(int)type delegate:(id<EditTextViewDelegate>) delegate{
    self = [super init];
    self.tDelegate = delegate;
    tType = type;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.labXhb.hidden = YES;
    if (tType == PrivateEditTextNick) {
        self.title = @"昵称";
        self.tTextView.text = [SettingService sharedInstance].iUser.nickName;
        limitNum = 10;
    }
    else if (tType == PrivateEditTextSign) {
        self.title = @"修改签名";
        self.labXhb.hidden = NO;
        self.tTextView.text = [SettingService sharedInstance].iUser.signature;
        limitNum = 32;
    }else if (tType == PrivateEditTextCom){
        self.title = @"企业";
        self.tTextView.text = [SettingService sharedInstance].iUser.enterprise;
        limitNum = 26;
    }else if (tType == PrivateEditTextFoodCommend){
        self.title = @"评价";
        limitNum = 160;
    }else if (tType == PrivateEditTextAdvise){
        self.title = @"建议反馈";
        limitNum = 160;
    }else if (tType == PrivateEditTextActivity){
        self.title = @"活动评价";
        limitNum = 160;
    }
    self.labWarnning.text  = [NSString stringWithFormat:@"%d",limitNum];
    self.tTextView.layer.borderWidth = 1;
    self.tTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tTextView.layer.cornerRadius = 5;
    self.tTextView.backgroundColor = [UIColor whiteColor];
    self.tTextView.delegate = self;
    
    
    [self.tTextView becomeFirstResponder];
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 40, 25);
    okBtn.layer.borderWidth = 1;
    okBtn.layer.borderColor = headerColor.CGColor;
    okBtn.layer.cornerRadius = 5;
    okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:headerColor forState:UIControlStateNormal];
    
    
    [okBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * ritem = [[UIBarButtonItem alloc] initWithCustomView:okBtn] ;
    [self.navigationItem setRightBarButtonItem:ritem];
    
    [self textViewDidChange:self.tTextView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)submit:(id)sender{
    NSLog(@"submit");
    [self.tTextView resignFirstResponder];
    
    if (PrivateEditTextFoodCommend == tType || PrivateEditTextActivity == tType || PrivateEditTextAdvise == tType) {
        if (self.tTextView.text.length == 0) {
            NSString *strNote = [NSString stringWithFormat:@"长度格式必须为1-%d",limitNum];
            [SVProgressHUD showErrorWithStatus:strNote duration:2];
            return;
        }
        
        
    }
    if (self.tTextView.text.length >limitNum) {
        [SVProgressHUD showErrorWithStatus:@"太多啦，删几个字吧！" duration:2];
        return;
    }
    if (self.tDelegate &&  [self.tDelegate respondsToSelector:@selector(editTextDone:type:)]) {
        [self.tDelegate editTextDone:self.tTextView.text type:tType];
    }
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    if (PrivateEditTextFoodCommend == tType) {//店铺评论
        [[[HttpService sharedInstance] getRequestStoreComments:self storeId:int2str(self.storeId) content:self.tTextView.text]startAsynchronous];
    }else if (PrivateEditTextActivity == tType){//活动评论
        [[[HttpService sharedInstance] getRequestActivityComments:self activityId:int2str(self.activityId) content:self.tTextView.text]startAsynchronous];
    }else if (PrivateEditTextAdvise == tType){//建议反馈
        /*
         {"id":905,"dateUpdate":"2015-03-06 17:43:28","dateCreate":"2015-03-06 17:43:28","status":"Y","content":"建议反馈","reply":null,"user":null}
         */
        [[[HttpService sharedInstance]getRequestSuggestion:self content:self.tTextView.text]startAsynchronous];
    }else if (tType == PrivateEditTextCom || tType == PrivateEditTextNick || tType == PrivateEditTextSign){
        
        IUser *tUser = [SettingService sharedInstance].iUser;
        if (tType == PrivateEditTextCom) {
            tUser.enterprise = self.tTextView.text;
        }else if (tType == PrivateEditTextNick) {
            tUser.nickName = self.tTextView.text;
        }else if (tType == PrivateEditTextSign) {
            tUser.signature = self.tTextView.text;
        }
        
        [[[HttpService sharedInstance]getRequestUpdatePerson:self user:tUser]startAsynchronous];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length >= limitNum){
        textView.text = [textView.text substringToIndex:limitNum];
    }
    
    int dd = limitNum - (int)textView.text.length;
    self.labWarnning.text = [NSString stringWithFormat:@"%d",dd];
    if (dd<0) {
        self.labWarnning.textColor = [UIColor redColor];
    }else{
        self.labWarnning.textColor = defaultTextColor;
    }
    
}

/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *gStr = text;
    if ([gStr isEqualToString:@""]) {//删除
        
    }else if ([gStr isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else if (textView.text.length >= limitNum){
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    int dd = limitNum - (int)textView.text.length;
    self.labWarnning.text = [NSString stringWithFormat:@"%d",dd];
    if (dd<0) {
        self.labWarnning.textColor = [UIColor redColor];
    }else{
        self.labWarnning.textColor = defaultTextColor;
    }
}
 */


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
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
                    if (self.comDelegate && [self.comDelegate respondsToSelector:@selector(commentDelegate:)]) {
                        [self.comDelegate commentDelegate:YES];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
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
        case HttpRequestType_XT_SUGGESTION:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    [SVProgressHUD showSuccessWithStatus:@"反馈建议提交成功" duration:DefaultRequestDonePromptTime];
                    [self.navigationController popViewControllerAnimated:YES];
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
        case HttpRequestType_XT_UPDATEPERSON:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSString *tStr = @"修改企业信息成功";
                    if (tType == PrivateEditTextCom){
                        tStr = @"修改企业信息成功";
                    }else if (tType == PrivateEditTextNick){
                        tStr = @"修改昵称成功";
                    }else if (tType == PrivateEditTextSign){
                        tStr = @"修改签名成功";
                    }
                    [SVProgressHUD showSuccessWithStatus:tStr duration:DefaultRequestDonePromptTime];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                [SVProgressHUD showSuccessWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
        }
        default:
            break;
    }
}

@end
