//
//  RegSecondStepViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "RegSecondStepViewController.h"
#import "PublicDefine.h"
#import "LoginViewController.h"
#import "HisLoginAcc.h"
#import "SettingService.h"
#import "PrivateViewController.h"
#import "LoginViewController.h"
@interface RegSecondStepViewController ()
{
    UITextField *nowTextField;
    UITextField *textFieldPsd;
    UITextField *textFieldComfirm;
    
    NSString *tTitle;
    int tType;
    
}
@end

@implementation RegSecondStepViewController

-(id)initWithTitle:(NSString *)tl type:(int)t{
    self = [super init];
    tTitle = tl;
    tType = t;
    return self;
}
-(id)init{
    self = [super init];
    
    tTitle = @"设置密码";
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    self.view.backgroundColor = _rgb2uic(0xeff9fb, 1);
    UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 150)];
    tView.backgroundColor = [UIColor clearColor];
    
    UIImageView *loginBg = [[UIImageView alloc] initWithFrame:tView.bounds];
    loginBg.image = [UIImage imageNamed:@"login_header_bg"];
    [tView addSubview:loginBg];
    
    UIImageView *headerImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default_header"]];
    [tView addSubview:headerImgView];
    headerImgView.center = CGPointMake(tView.bounds.size.width/2, tView.bounds.size.height/2);
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(5, 20, 40, 44);
    [btnBack setImage:[UIImage imageNamed:@"base_white_back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [tView addSubview:btnBack];
    [self.view addSubview:tView];
    
    UILabel *tLab = [[UILabel alloc]init];
    tLab.textColor = [UIColor whiteColor];
    [tView addSubview:tLab];
    tLab.text = tTitle;
    tLab.textAlignment = NSTextAlignmentCenter;
    tLab.font = [UIFont systemFontOfSize:16];
    tLab.frame = CGRectMake(0, tView.bounds.size.height/2 +35, bounds.size.width, 24);
    
    //xib 8da3ae
    int tfHeight = 47;
    CGRect tRect = CGRectMake(21, 165, 276, tfHeight);
    
    textFieldPsd = [[UITextField alloc] initWithFrame:CGRectMake(tRect.origin.x, tRect.origin.y, tRect.size.width, tfHeight)];
    textFieldPsd.placeholder = @"请设置密码";
    UIView *tmpInsetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, tfHeight)];
    textFieldPsd.leftView = tmpInsetView;
    textFieldPsd.leftViewMode = UITextFieldViewModeAlways;
    textFieldPsd.returnKeyType = UIReturnKeyNext;
    textFieldPsd.clearButtonMode = UITextFieldViewModeAlways;
    textFieldPsd.delegate = self;
    textFieldPsd.secureTextEntry = YES;
    textFieldPsd.layer.cornerRadius = 10;
    textFieldPsd.layer.borderWidth = 1;
    textFieldPsd.layer.borderColor = _rgb2uic(0x8da3ae, 1).CGColor;
    textFieldPsd.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldPsd];
    
    tRect = CGRectMake(21, 227, 276, tfHeight);
    
    textFieldComfirm = [[UITextField alloc] initWithFrame:CGRectMake(tRect.origin.x, tRect.origin.y, tRect.size.width, tfHeight)];
    textFieldComfirm.placeholder = @"确认密码";
    tmpInsetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, tfHeight)];
    textFieldComfirm.leftView = tmpInsetView;
    textFieldComfirm.leftViewMode = UITextFieldViewModeAlways;
    textFieldComfirm.returnKeyType = UIReturnKeyDone;
    textFieldComfirm.clearButtonMode = UITextFieldViewModeAlways;
    textFieldComfirm.delegate = self;
    textFieldComfirm.secureTextEntry = YES;
    textFieldComfirm.layer.cornerRadius = 10;
    textFieldComfirm.layer.borderWidth = 1;
    textFieldComfirm.layer.borderColor = _rgb2uic(0x8da3ae, 1).CGColor;
    textFieldComfirm.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldComfirm];

    
    
    
    UITapGestureRecognizer *pan2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
    
    [self.view addGestureRecognizer:pan2];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


- (void) handlePan2: (UIPanGestureRecognizer *)rec{
    NSLog(@"self.view UITapGestureRecognizer");
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
}
-(IBAction)doneAction:(id)sender{
    NSLog(@"doneAction");
    if (textFieldPsd.text.length == 0) {
        XT_SHOWALERT(@"密码不能为空");
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
        XT_SHOWALERT(@"设置密码和确认密码不一致");
    }
    
    if (PsdSettingReg == tType) {
        //注册的时候设置密码
//        [self regSuc];
        [SVProgressHUD showWithStatus:DefaultRequestPrompt];
        [[[HttpService sharedInstance] getRequestReg:self account:self.phoneNum psd:textFieldPsd.text authCode:self.smsCode]startAsynchronous];
        NSLog(@"注册的时候设置密码");
    }else if (PsdSettingModify == tType){
        //重置密码
        NSLog(@"重置密码");
    }
}

-(void)regSuc{
    NSLog(@"regSuc");
    HisLoginAcc *la = [[HisLoginAcc alloc]init];
    la.account = self.phoneNum;
    la.psd = textFieldPsd.text;
    la.isRmbPsd = YES;
    [HisLoginAcc saveLastAccLoginInfo:la];
//    [SettingService sharedInstance].account = la.account;
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜您，注册成功！现在去完善资料？" delegate:self cancelButtonTitle:@"马上就去" otherButtonTitles:@"以后再说", nil];
    av.delegate = self;
    [av show];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"index:%d",(int)buttonIndex);
    if (0 == buttonIndex) {
        PrivateViewController *pv = [[PrivateViewController alloc]init];
        UINavigationController *nav = self.navigationController;
//        [nav popToRootViewControllerAnimated:NO];
        UIViewController *vc = [self vcPopToLoginLastLevel];
        [nav popToViewController:vc animated:NO];
        [nav pushViewController:pv animated:YES];
    }else if (1 == buttonIndex){
//        [self.navigationController popToRootViewControllerAnimated:YES];
        UIViewController *vc = [self vcPopToLoginLastLevel];
        [self.navigationController popToViewController:vc animated:YES];
    }
}

-(UIViewController *)vcPopToLoginLastLevel{
    UINavigationController *nav = self.navigationController;
    NSArray *vcArr = nav.viewControllers;
    UIViewController *theVc = nil;
    int count = (int)vcArr.count;
    for (int i = count-1;i>=0;i--) {
        UIViewController *tmpVc = [vcArr objectAtIndex:i];
        if ([tmpVc isKindOfClass:[LoginViewController class]]) {
            theVc = [vcArr objectAtIndex:(i-1)];
        }
    }
    return theVc;
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    nowTextField = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textFieldPsd == textField) {
        [textFieldComfirm becomeFirstResponder];
    }else if (textFieldComfirm == textField){
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_XT_REG:{
            if (HttpResponseTypeFinished ==  responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
//                    IUser *iuser = [[IUser alloc]init];
//                    iuser.phone  = self.phoneNum;
//                    [SettingService sharedInstance].iUser = iuser;
                    NSDictionary *tDic = (NSDictionary *)br.data;
                    if (tDic == nil) {
                        [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                    }else{
                        IUser *user = [IUser getIUserWithDic:tDic];
                        if (user.phone == nil || user.phone.length <1) {
                            [SVProgressHUD showErrorWithStatus:@"注册失败" duration:1.5];
                            return;
                        }
                        [SettingService sharedInstance].iUser = user;
                        [self regSuc];
                    }
                    
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
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
