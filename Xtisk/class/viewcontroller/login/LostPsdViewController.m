//
//  LostPsdViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "LostPsdViewController.h"
#import "PublicDefine.h"
#import "CTLCustom.h"
#import "AppDelegate.h"
#define LpcHeight 44.0

@interface LostPsdViewController ()
{
    int firstStepAcount;
    int secondeStepAcount;
    
    int nowStep;
    int insetW;
    
    UITextField *tfTel;
    UITextField *tfVerifyCode;
    UIButton *btnAcquireCode;
    UITextField *tfPsd;
    UITextField *tfComfirmCode;
    UIButton *btnDone;
    
    UITextField *nowTextField;
    UIColor *tColor;
    
    NSTimer *timer;
    int limitTime;
    int leftTime;
}

@property(nonatomic,weak)IBOutlet UIButton *btnTest;
@end

@implementation LostPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    timer = nil;
    nowStep = 1;
    firstStepAcount = 2;
    secondeStepAcount = 5;
    insetW = 15;
    limitTime = 10;
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStylePlain];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    //    tTableView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    tTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tTableView];
    
//    tTableView.backgroundColor = _rgb2uic(0xeff9fb, 1);
//    self.view.backgroundColor = _rgb2uic(0xeaeaeb, 1);
    self.view.backgroundColor = _rgb2uic(0xeff9fb, 1);
    tColor = _rgb2uic(0xeff9fb, 1);
    UITapGestureRecognizer *pan2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
    
    [self.view addGestureRecognizer:pan2];
    [tTableView addGestureRecognizer:pan2];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self performSelector:@selector(showUI) withObject:nil afterDelay:1];
}

- (void) handlePan2: (UIPanGestureRecognizer *)rec{
    NSLog(@"self.view UITapGestureRecognizer");
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
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
        btnAcquireCode.alpha = 0.5;
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

-(void)showUI{
    
    NSLog(@"showUI");
}

-(void)acquireCode{
    
    NSLog(@"acquireCode");
    if (nowStep == 1) {
        nowStep = 2;
        [tTableView reloadData];
    }
    [self startCalTime];
    
    
}

-(void)submitAction{
    
    NSLog(@"submitAction");
    if (tfPsd.text.length == 0) {
        XT_SHOWALERT(@"密码不能为空");
        return;
    }
    if (tfComfirmCode.text.length == 0) {
        XT_SHOWALERT(@"确认密码不能为空");
        return;
    }
    if (tfPsd.text.length > 20) {
        XT_SHOWALERT(@"密码太长");
        return;
    }
    
    if (tfPsd.text.length < 6) {
        XT_SHOWALERT(@"密码太短");
        return;
    }
    if ([tfPsd.text isEqualToString:tfComfirmCode.text] == NO) {
        XT_SHOWALERT(@"设置密码和确认密码不一致");
    }
    
    //do
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (1 == nowStep) {
        return firstStepAcount;
    }else if (2 == nowStep) {
        return secondeStepAcount;
    }
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = [NSString stringWithFormat:@"cell%d",(int)indexPath.section];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect bounds = [UIScreen mainScreen].bounds;
        int tWidth = bounds.size.width - insetW*2;
//        int startX = insetW;
        if (0 == indexPath.section) {
            CGRect tr = CGRectMake(insetW, 0, tWidth,LpcHeight);
            tfTel = [CTLCustom getRegTextFieldWith:tr];
            tfTel.placeholder = @"请输入手机号码";
            tfTel.delegate = self;
            [cell addSubview:tfTel];
            
        }else if(1 == indexPath.section){
            int vw = tWidth /2;
            CGRect tr = CGRectMake(insetW, 0, vw,LpcHeight);
            tfVerifyCode = [CTLCustom getRegTextFieldWith:tr];
            tfVerifyCode.delegate = self;
            tfVerifyCode.placeholder = @"请输入验证码";
            [cell addSubview:tfVerifyCode];
            
            tr = CGRectMake(insetW + vw +5, 0, vw -5,LpcHeight);
            btnAcquireCode = [CTLCustom getButtonSubmitWithRect:tr];
            [btnAcquireCode addTarget:self action:@selector(acquireCode) forControlEvents:UIControlEventTouchUpInside];
            [btnAcquireCode setTitle:@"点击获取验证码" forState:UIControlStateNormal];
            btnAcquireCode.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell addSubview:btnAcquireCode];
        }else if (2 == indexPath.section) {
            CGRect tr = CGRectMake(insetW, 0, tWidth,LpcHeight);
            tfPsd = [CTLCustom getRegTextFieldWith:tr];
            tfPsd.delegate = self;
            tfPsd.placeholder = @"请设置密码";
            [cell addSubview:tfPsd];
            
        }else if (3 == indexPath.section) {
            CGRect tr = CGRectMake(insetW, 0, tWidth,LpcHeight);
            tfComfirmCode = [CTLCustom getRegTextFieldWith:tr];
            tfComfirmCode.delegate = self;
            tfComfirmCode.placeholder = @"请确认密码";
            [cell addSubview:tfComfirmCode];
            
        }else if (4 == indexPath.section) {
           
            CGRect bounds = [[UIScreen mainScreen] applicationFrame];
            CGRect tr = CGRectMake(insetW, 5, bounds.size.width - 15*2, LpcHeight);
            btnDone = [CTLCustom getTableViewLastButton:tr];
            [btnDone setTitle:@"确认" forState:UIControlStateNormal];
            [btnDone addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnDone];
        }
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}


#pragma mark textfieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 20)
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    nowTextField = textField;
//    NSArray *arr = nowTextField.gestureRecognizers;
//    CGPoint p1 = [recognizer locationInView:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
//    CGRect tr = [nowTextField convertRect:nowTextField.frame fromView:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
    return YES;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (4 == indexPath.section) {
        return LpcHeight + 10;
    }
    return LpcHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 3) {
        return LpcHeight;
    }
    return 1.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 10)];
        tmpView.backgroundColor = tColor;
        return tmpView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (section == 1) {
        int tWidth = bounds.size.width - insetW*2;

        UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, LpcHeight)];
        tmpView.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(insetW, 0, tWidth, LpcHeight)];
        lab.backgroundColor = [UIColor clearColor];
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:13];
        lab.lineBreakMode = NSLineBreakByCharWrapping;
        lab.text = @"点击获取验证码，您将收到6位短信验证码，请在60秒内输入验证码";
        [tmpView addSubview:lab];
        return tmpView;
    }else if (section == 3) {
        
        int tWidth = bounds.size.width - insetW*2;
        
        UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, LpcHeight)];
        tmpView.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(insetW, 0, tWidth, LpcHeight)];
        lab.backgroundColor = [UIColor clearColor];
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:13];
        lab.lineBreakMode = NSLineBreakByCharWrapping;
        lab.text = @"密码设置长度为6-20个字符，包含数字、字母、下划线等字符，字母区分大小写";
        [tmpView addSubview:lab];
        return tmpView;
    }else{
        UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 1)];
        tmpView.backgroundColor = tColor;
        return tmpView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

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
