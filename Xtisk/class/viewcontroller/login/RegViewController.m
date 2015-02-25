//
//  RegViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "RegViewController.h"
#import "PublicDefine.h"
#import "RegSecondStepViewController.h"
@interface RegViewController ()
{
    UITextField *nowTextField;
    UITextField *textFieldAc;
    UITextField *textFieldCode;
    UIButton *btnAcquireCode;
    
    NSTimer *timer;
    int limitTime;
    int leftTime;
}
@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册账号";
    CGRect bounds = [UIScreen mainScreen].bounds;
    limitTime = 10;
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
    tLab.text = @"注册";
    tLab.textAlignment = NSTextAlignmentCenter;
    tLab.font = [UIFont systemFontOfSize:16];
    tLab.frame = CGRectMake(0, tView.bounds.size.height/2 +35, bounds.size.width, 24);
    
    //xib 8da3ae
    //tRect = origin=(x=21, y=165) size=(width=276, height=30)
    
    int tfHeight = 47;
    CGRect tRect = CGRectMake(21, 165, 276, tfHeight);
    
    textFieldAc = [[UITextField alloc] initWithFrame:tRect];
    textFieldAc.placeholder = @"请输入手机号";
    UIView *tmpInsetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, tfHeight)];
    textFieldAc.leftView = tmpInsetView;
    textFieldAc.leftViewMode = UITextFieldViewModeAlways;
    textFieldAc.returnKeyType = UIReturnKeyNext;
    textFieldAc.clearButtonMode = YES;
    textFieldAc.delegate = self;
    textFieldAc.layer.cornerRadius = 10;
    textFieldAc.layer.borderWidth = 1;
    textFieldAc.layer.borderColor = _rgb2uic(0x8da3ae, 1).CGColor;
    textFieldAc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldAc];
    
    tRect = CGRectMake(21, 227, 276, tfHeight);
    
    textFieldCode = [[UITextField alloc] initWithFrame:CGRectMake(tRect.origin.x, tRect.origin.y, tRect.size.width, tfHeight)];
    textFieldCode.placeholder = @"请输入验证码";
    tmpInsetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, tfHeight)];
    textFieldCode.leftView = tmpInsetView;
    textFieldCode.leftViewMode = UITextFieldViewModeAlways;
    textFieldCode.returnKeyType = UIReturnKeyDone;
    textFieldCode.clearButtonMode = YES;
    textFieldCode.delegate = self;
    textFieldCode.layer.cornerRadius = 10;
    textFieldCode.layer.borderWidth = 1;
    textFieldCode.layer.borderColor = _rgb2uic(0x8da3ae, 1).CGColor;
    textFieldCode.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldCode];
    
    //tRect = origin=(x=21, y=227) size=(width=276, height=47)
    tRect = textFieldCode.frame;
    UIButton *btnGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGetCode.frame = CGRectMake(CGRectGetMaxX(tRect) - 106 -4, tRect.origin.y + 3, 106, 40);
    [btnGetCode setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [btnGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnGetCode.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnGetCode setBackgroundImage:[UIImage imageNamed:@"reg_get_ver_code"] forState:UIControlStateNormal];
    [btnGetCode addTarget:self action:@selector(getVerCodeAction:) forControlEvents:UIControlEventTouchUpInside];
//    btnGetCode.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    btnAcquireCode = btnGetCode;
    [self.view addSubview:btnGetCode];
//    textFieldCode.rightView = btnGetCode;
//    textFieldCode.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    self.labPrompt.textColor = _rgb2uic(0x8da3ae, 1);
    
    
    UITapGestureRecognizer *pan2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
    
    [self.view addGestureRecognizer:pan2];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)stopTimer{
    if (timer) {
        if ([timer isValid]) {
            [timer invalidate];
            timer = nil;
        }
    }
}
-(void)startCalTime{
    [self stopTimer];
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(judgeTimer) userInfo:nil repeats:YES];
        leftTime = limitTime;
        NSString *tTitle = [NSString stringWithFormat:@"倒计时（%d）秒",leftTime];
        [btnAcquireCode setTitle:tTitle forState:UIControlStateNormal];
        btnAcquireCode.enabled = NO;
        btnAcquireCode.alpha = 0.65;
    }
}

-(void)judgeTimer{
    NSLog(@"judgeTimer");
    leftTime --;
    NSString *tTitle = [NSString stringWithFormat:@"倒计时（%d）秒",leftTime];
    [btnAcquireCode setTitle:tTitle forState:UIControlStateNormal];
    if (leftTime == 0) {
        [self stopTimer];
        tTitle = @"点击获取验证码";
        btnAcquireCode.enabled = YES;
        btnAcquireCode.alpha = 1;
        [btnAcquireCode setTitle:tTitle forState:UIControlStateNormal];
    }
}
- (void) handlePan2: (UIPanGestureRecognizer *)rec{
    NSLog(@"self.view UITapGestureRecognizer");
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)getVerCodeAction:(id)sender{
    NSLog(@"getVerCodeAction");
    [self startCalTime];
}
-(IBAction)nextAction:(id)sender{
    NSLog(@"nextAction");
    if (textFieldAc.text.length ==0) {
        XT_SHOWALERT(@"手机号不能为空");
        return;
    }
    if (textFieldCode.text.length == 0) {
        XT_SHOWALERT(@"验证码不能为空");
        return;
    }
    
    if (textFieldCode.text.length > 20) {
        XT_SHOWALERT(@"验证码太长");
        return;
    }
    RegSecondStepViewController *rs = [[RegSecondStepViewController alloc]initWithTitle:@"设置密码" type:PsdSettingReg];
    rs.phoneNum = textFieldAc.text;
    [self.navigationController pushViewController:rs animated:YES];
}
-(IBAction)regAction:(id)sender{
    NSLog(@"regAction");
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    nowTextField = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textFieldAc == textField) {
        [textFieldCode becomeFirstResponder];
    }else if (textFieldCode == textField){
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
