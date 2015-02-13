//
//  RegSecondStepViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "RegSecondStepViewController.h"
#import "PublicDefine.h"
@interface RegSecondStepViewController ()
{
    UITextField *nowTextField;
    UITextField *textFieldPsd;
    UITextField *textFieldComfirm;
}
@end

@implementation RegSecondStepViewController

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
    tLab.text = @"设置密码";
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
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
