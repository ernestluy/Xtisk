//
//  ModifyPsdViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/12.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ModifyPsdViewController.h"
#import "PublicDefine.h"
@interface ModifyPsdViewController ()
{
    UITextField *tfOldPsd;
}
@end

@implementation ModifyPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title =@"修改密码";
    
    int tfHeight = 47;
    CGRect tRect = CGRectMake(21, 165, 276, tfHeight);
    
    tfOldPsd = [[UITextField alloc] initWithFrame:CGRectMake(tRect.origin.x, tRect.origin.y, tRect.size.width, tfHeight)];
    tfOldPsd.placeholder = @"请输入旧密码";
    UIView *tmpInsetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, tfHeight)];
    tfOldPsd.leftView = tmpInsetView;
    tfOldPsd.leftViewMode = UITextFieldViewModeAlways;
    tfOldPsd.returnKeyType = UIReturnKeyNext;
    tfOldPsd.clearButtonMode = UITextFieldViewModeAlways;
    tfOldPsd.delegate = self;
    tfOldPsd.secureTextEntry = YES;
    tfOldPsd.layer.cornerRadius = 10;
    tfOldPsd.layer.borderWidth = 1;
    tfOldPsd.layer.borderColor = _rgb2uic(0x8da3ae, 1).CGColor;
    tfOldPsd.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tfOldPsd];
    
    textFieldPsd.frame = CGRectMake(tRect.origin.x, CGRectGetMaxY(tfOldPsd.frame)+10, tRect.size.width, tfHeight);
    textFieldComfirm.frame = CGRectMake(tRect.origin.x, CGRectGetMaxY(textFieldPsd.frame)+10, tRect.size.width, tfHeight);
    
    textFieldPsd.placeholder = @"请输入新密码";
    textFieldComfirm.placeholder = @"再次输入新密码";
    
    
    UILabel *labNote = [[UILabel alloc]initWithFrame:CGRectMake(tRect.origin.x, CGRectGetMaxY(textFieldComfirm.frame)+10, tRect.size.width, 50)];
    labNote.textColor = _rgb2uic(0x8da3ae, 1);
    labNote.numberOfLines  = 0;
    labNote.text = @"密码设置长度为6~20个字符，包含数字、字母、下划线等字符，字母区分大小写";
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    labNote.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:labNote];
    
    UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];

    btnOrder.frame = CGRectMake(tRect.origin.x, CGRectGetMaxY(labNote.frame)+10, tRect.size.width, tfHeight);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"确定" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(modifyPsd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOrder];
    
}


-(void)modifyPsd{
    NSLog(@"确定");
    if (tfOldPsd.text.length == 0) {
        XT_SHOWALERT(@"旧密码不能为空");
        return;
    }
    if (textFieldPsd.text.length == 0 || textFieldComfirm.text.length<6) {
        XT_SHOWALERT(@"新密码长度为6-20位");
        return;
    }
    if (textFieldComfirm.text.length == 0) {
        XT_SHOWALERT(@"确认密码不能为空");
        return;
    }
    if (textFieldPsd.text.length > 20) {
        XT_SHOWALERT(@"密码太长");
        return;
    }
    if ([textFieldPsd.text isEqualToString:textFieldComfirm.text] == NO) {
        XT_SHOWALERT(@"设置的新密码和确认密码不一致");
        return;
    }
    
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    
    [[[HttpService sharedInstance] getRequestUpdateMyPassword:self oldPassword:tfOldPsd.text newPassword:textFieldPsd.text checkPassword:textFieldComfirm.text]startAsynchronous];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textFieldPsd == textField) {
        [textFieldComfirm becomeFirstResponder];
    }else if (textFieldComfirm == textField){
        [textField resignFirstResponder];
    }else if (tfOldPsd == textField){
        [textFieldPsd becomeFirstResponder];
    }
    return YES;
}
#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_XT_UPDATEMYPASSWORD:{
            if (HttpResponseTypeFinished ==  responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"修改密码请求成功");
                    HisLoginAcc *la = [HisLoginAcc getLastAccLoginInfo];
                    la.psd = textFieldComfirm.text;
//                    [HisLoginAcc saveAccLoginInfo:la];
                    [HisLoginAcc saveLastAccLoginInfo:la];
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD showSuccessWithStatus:@"修改成功" duration:1.5];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else if (HttpResponseTypeFailed == responseCode){
                NSLog(@"请求失败");
                
            }
            break;
        }
        default:{
            
            break;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
