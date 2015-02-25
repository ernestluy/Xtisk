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
#define LpcHeight 44.0

@interface LostPsdViewController ()
{
    int firstStep;
    int secondeStep;
    
    int nowStep;
    int insetW;
    
    UITextField *tfTel;
    UITextField *tfVerifyCode;
    UIButton *btnAcquireCode;
    UITextField *tfPsd;
    UITextField *tfComfirmCode;
}

@property(nonatomic,weak)IBOutlet UIButton *btnTest;
@end

@implementation LostPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    nowStep = 1;
    firstStep = 2;
    secondeStep = 5;
    insetW = 15;
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, bounds.size.width-20, tableHeight) style:UITableViewStylePlain];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    tTableView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    //    tTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tTableView];
    
    self.view.backgroundColor = _rgb2uic(0xeff9fb, 1);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self performSelector:@selector(showUI) withObject:nil afterDelay:1];
}

-(void)showUI{
    
    NSLog(@"showUI");
}

-(void)acquireCode{
    
    NSLog(@"acquireCode");
}

-(void)submitAction{
    
    NSLog(@"submitAction");
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (1 == nowStep) {
        return firstStep;
    }else if (2 == nowStep) {
        return secondeStep;
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
        CGRect bounds = [UIScreen mainScreen].bounds;
        int tWidth = bounds.size.width - insetW*2;
        if (0 == indexPath.row) {
            CGRect tr = CGRectMake(0, 0, tWidth,LpcHeight);
            tfTel = [CTLCustom getRegTextFieldWith:tr];
            tfTel.placeholder = @"请输入手机号码";
            [cell addSubview:tfTel];
            
        }else if(1 == indexPath.row){
            int vw = tWidth /2;
            CGRect tr = CGRectMake(0, 0, vw,LpcHeight);
            tfVerifyCode = [CTLCustom getRegTextFieldWith:tr];
            tfVerifyCode.placeholder = @"请输入验证码";
            [cell addSubview:tfVerifyCode];
            
            tr = CGRectMake(0, 0, vw,LpcHeight);
            btnAcquireCode = [CTLCustom getButtonSubmitWithRect:tr];
            [btnAcquireCode addTarget:self action:@selector(acquireCode) forControlEvents:UIControlEventTouchUpInside];
            [btnAcquireCode setTitle:@"获取验证码" forState:UIControlStateNormal];
            [cell addSubview:btnAcquireCode];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LpcHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return LpcHeight;
    }
    return 1.0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    CGRect bounds = [UIScreen mainScreen].bounds;
//    UIView *tt = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 10)];
//    tt.backgroundColor = [UIColor redColor];
//    return tt;
//}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        int tWidth = bounds.size.width - insetW*2;

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tWidth, LpcHeight)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"点击获取验证码，您将收到6位短信验证码，请在60秒内输入验证码";
        return lab;
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
