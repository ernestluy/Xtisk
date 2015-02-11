

#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "PublicDefine.h"
#import "RegViewController.h"
#import "HttpService.h"
#import "LostPsdViewController.h"
#import "GDataXMLNode.h"
#import "MainTabBarViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "SVProgressHUD.h"
#import "SettingService.h"
#import "HisAccSelectView.h"
#import "HisLoginAcc.h"
#define EXTENDS_HEIGHT  70
#define LOGIN_CELL_HEIGHT 50

typedef enum  {
    CELL_LOGIN_NAME = 0,
    CELL_LOGIN_HIS_ACC,
    CELL_LOGIN_PSD,
    CELL_LOGIN_RMB,
    CELL_LOGIN_SUBMIT,

}LoginCellTag;


@interface LoginViewController ()
{
    CGPoint touchBeganPoint;
    UITextField *nowTextField;
    UISwitch *rmbSwith;
    int fontSize;
    UIFont *nFont;
    UIButton *btnExtend;
    BOOL isRemPsd;
    BOOL isExtend;
    
    UIImageView *headerImgView;
}


@end
@interface LoginViewController (haha)

-(void)fuck;
@end

@implementation LoginViewController
//@synthesize lTableView;
@synthesize tType,delegate;
-(id)initWithType:(IntoLoginType)type{
    self = [super init];
    if (self) {
        tType = type;
        isExtends = NO;
        rows = 2;
        person = [[Person alloc] init];
        person.name = @"61";
        person.add = @"douan";
        person.age = 27;
        nowTextField = nil;
        fontSize = 14;
        nFont = [UIFont systemFontOfSize:15];
        isRemPsd = YES;
    }
    return self;
}
-(id)init{
    self = [super init];
    if (self) {
        tType = INTO_TAB_OTHER;
        isExtends = NO;
        rows = 2;
        person = [[Person alloc] init];
        person.name = @"61";
        person.add = @"douan";
        person.age = 27;
        nowTextField = nil;
        fontSize = 14;
        nFont = [UIFont systemFontOfSize:15];
        isRemPsd = YES;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"login dealloc");
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.title = @"登录";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    tTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    tTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    HisLoginAcc *la = [HisLoginAcc getLastAccLoginInfo];
    if (la) {
        tf_name.text = la.account;
        rmbSwith.on = la.isRmbPsd;
        if (la.isRmbPsd) {
            tf_password.text = la.psd;
        }else{
            
        }
    }
    tTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    NSLog(@"asdasdf");
    #endif
    isExtend = NO;
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        bounds = [[UIScreen mainScreen] bounds];
        bounds.size.height = bounds.size.height -20;
        
    }
    
    tTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tTableView];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tTableView.bounces = NO;
    tTableView.backgroundColor = [UIColor clearColor];
    tTableView.frame = self.view.frame;
    self.view.backgroundColor = _rgb2uic(0xeff9fb, 1);
    tTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 150)];
    tView.backgroundColor = [UIColor clearColor];
    
    UIImageView *loginBg = [[UIImageView alloc] initWithFrame:tView.bounds];
    loginBg.image = [UIImage imageNamed:@"login_header_bg"];
    [tView addSubview:loginBg];
    
    headerImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default_header"]];
    [tView addSubview:headerImgView];
    headerImgView.center = CGPointMake(tView.bounds.size.width/2, tView.bounds.size.height/2);
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(5, 20, 40, 44);
    [btnBack setImage:[UIImage imageNamed:@"base_white_back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [tView addSubview:btnBack];
    
    UILabel *tLab = [[UILabel alloc]init];
    tLab.textColor = [UIColor whiteColor];
    [tView addSubview:tLab];
    tLab.text = @"欢迎来到爱蛇口";
    tLab.textAlignment = NSTextAlignmentCenter;
    tLab.font = [UIFont systemFontOfSize:16];
    tLab.frame = CGRectMake(0, tView.bounds.size.height/2 +35, bounds.size.width, 24);
    
    
    tTableView.tableHeaderView = tView;
    
    
    
    
    
//    UIButton *ddd = [UIButton buttonWithType:UIButtonTypeCustom];
//    ddd.frame = CGRectMake(100, 100, 100, 100);
//    ddd.backgroundColor = [UIColor lightGrayColor];
//    [ddd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [ddd setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [ddd setTitle:@"OK" forState:UIControlStateNormal];
//    [ddd addTarget:self action:@selector(setData) forControlEvents:UIControlEventTouchUpInside];
//    [tView addSubview:ddd];
//    
//    UIView *tView2 = [[UIView alloc]initWithFrame:tView.bounds];
//    tView2.backgroundColor = [UIColor blueColor];
//    tView2.alpha = 0.4;
//    tView2.userInteractionEnabled = NO;//NO可以穿透过去
//    [tView addSubview:tView2];
    
    int btnWidth = 90;
    int btnHeight = 30;
    UIButton *btnReg = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReg setTitle:@"快速注册" forState:UIControlStateNormal];
    [btnReg setImage:[UIImage imageNamed:@"login_reg"] forState:UIControlStateNormal];
    btnReg.titleLabel.font = nFont;
    btnReg.titleLabel.textAlignment = NSTextAlignmentRight;
    btnReg.backgroundColor = [UIColor clearColor];
    [btnReg setTitleColor:_rgb2uic(0x5b5b5d, 1) forState:UIControlStateNormal];
    [btnReg addTarget:self action:@selector(reg:) forControlEvents:UIControlEventTouchUpInside];
    btnReg.frame = CGRectMake(self.view.frame.size.width - btnWidth - 15,self.view.frame.size.height - btnHeight - 20, btnWidth, btnHeight);
    [self.view addSubview:btnReg];
    
    
    
    self.view.tag = 100;
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [tTableView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *pan2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
    
    [self.view addGestureRecognizer:pan2];
    
//    [self performSelector:@selector(setData) withObject:nil afterDelay:1];
}

-(void)setData{
    NSLog(@"setData");
    tf_name.text = @"test1";
    tf_password.text = @"888888";
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)btnRmbAction:(id)sender{
    UIButton*btn = (UIButton*)sender;
    isRemPsd = !isRemPsd;
    btn.selected = isRemPsd;
}
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    NSLog(@"lTableView UITapGestureRecognizer");
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
}
- (void) handlePan2: (UIPanGestureRecognizer *)rec{
    NSLog(@"self.view UITapGestureRecognizer");
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
}
-(void)login:(id)sender{
    NSLog(@"login");
//    [SVProgressHUD showWithStatus:@"请等待" maskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD showWithStatus:@"请等待" ];
//    [[[HttpService sharedInstance] getRequestLogin:self name:tf_name.text psd:tf_password.text]startAsynchronous];
    [self loginSucInto];
}
-(void)loginSucInto{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginSucBack:)]) {
        [self.delegate loginSucBack:self];
    }
    
    HisLoginAcc *la = [[HisLoginAcc alloc]init];
    la.account = tf_name.text;
    la.psd = tf_password.text;
    la.isRmbPsd = isRemPsd;
    [HisLoginAcc saveLastAccLoginInfo:la];
    [SettingService sharedInstance].account = la.account;
    [self.navigationController popViewControllerAnimated:YES];
    
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    MainTabBarViewController *mTabBar = [[MainTabBarViewController alloc]init];
//    CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:mTabBar];
//    nav.interactivePopGestureRecognizer.enabled = NO;
//    
//    appDelegate.window.rootViewController = nav;
    
}


-(void)reg:(id)sender{
    NSLog(@"reg");
    RegViewController *rvc = [[RegViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}

-(void)forgotAction:(id)sender{
    NSLog(@"forgotAction");
    LostPsdViewController *lp = [[LostPsdViewController alloc]init];
    [self.navigationController pushViewController:lp animated:YES];
}
-(void)rememberSwitchAction:(id)sender{
    NSLog(@"rememberSwitchAction");
    UISwitch *sw = (UISwitch *)sender;
    isRemPsd = sw.on;
    NSLog(@"on:%d",isRemPsd);
}

-(void)extendAction:(id)sender{
    NSLog(@"extendAction");
    isExtend = !isExtend;
    NSIndexPath *indexPath= [NSIndexPath indexPathForRow:CELL_LOGIN_HIS_ACC inSection:0];
    UIImageView *accessoryView=(UIImageView*)[tTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:CELL_LOGIN_NAME inSection:0]].accessoryView;
    if (isExtend) {
        
        [UIView animateWithDuration:0.25 animations:^{
            //第一帧要执行的动画
            accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
        }completion:^(BOOL finished){
            //动画结束后执行的代码块
            [tTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }else{

        [UIView animateWithDuration:0.25 animations:^{
            //第一帧要执行的动画
            accessoryView.transform = CGAffineTransformMakeRotation(0);
        }completion:^(BOOL finished){
            //动画结束后执行的代码块
            [tTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (CELL_LOGIN_HIS_ACC == indexPath.row) {
        if (isExtend) {
            return EXTENDS_HEIGHT;
        }else{
            return 0.0;
        }
    }
	if (CELL_LOGIN_RMB == indexPath.row) {
        return  1.5*LOGIN_CELL_HEIGHT;
    }
	return LOGIN_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
	return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIndentifier = [NSString stringWithFormat:@"%d_%d",(int)indexPath.section,(int)indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        int row = (int)indexPath.row;
        if (row == CELL_LOGIN_NAME) {
            tf_name = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, LOGIN_CELL_HEIGHT)];
            tf_name.placeholder = @"账号/邮箱/手机号码";
            UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, LOGIN_CELL_HEIGHT)];
            UIImageView * tIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_tf_acc_head"]];
            [tView addSubview:tIv];
            tIv.center = CGPointMake(tView.frame.size.width/2, tView.frame.size.height/2);
//            [cell addSubview:tView];
            tf_name.leftView = tView;
            tf_name.leftViewMode = UITextFieldViewModeAlways;
            tf_name.returnKeyType = UIReturnKeyNext;
            tf_name.clearButtonMode = YES;
            tf_name.delegate = self;
            tf_name.backgroundColor = [UIColor clearColor];
            [cell addSubview:tf_name];
            
//            去掉可选历史登录账户
//            btnExtend = [UIButton buttonWithType:UIButtonTypeCustom];
//            btnExtend.frame = CGRectMake(self.tableView.frame.size.width - 40, 0, 40, LOGIN_CELL_HEIGHT);
//            [btnExtend setBackgroundImage:[UIImage imageNamed:@"login_expend.png"] forState:UIControlStateNormal];
//            [btnExtend addTarget:self action:@selector(extendAction:) forControlEvents:UIControlEventTouchUpInside];
//            cell.accessoryView = btnExtend;
            UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, LOGIN_CELL_HEIGHT-0.7, cell.frame.size.width, 0.7)];
            separatorLine.backgroundColor = _rgb2uic(0xd8d8d8, 1);
            [cell addSubview:separatorLine];
        }
        else if(row == CELL_LOGIN_HIS_ACC){
            
//            UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 2, self.tableView.frame.size.width, EXTENDS_HEIGHT -2)];
//            tView.backgroundColor = [UIColor redColor];
//            [cell addSubview:tView];
            
            cell.backgroundColor = [UIColor lightGrayColor];
            HisAccSelectView *as = [[HisAccSelectView alloc]initWithFrame:CGRectMake(0, 0,tTableView.frame.size.width, EXTENDS_HEIGHT )];
            [cell addSubview:as];
            NSMutableArray *ma = [NSMutableArray array];
            for (int i = 0; i<5; i++) {
                HisLoginAcc *ha = [[HisLoginAcc alloc]init];
                ha.account = @"luyi";
                ha.headerIcon = [UIImage imageNamed:@"1-1.jpg"];
                [ma addObject:ha];
            }
            [as setHisArr:ma];
        }
        else if (row == CELL_LOGIN_PSD) {
 
            tf_password = [[UITextField alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, LOGIN_CELL_HEIGHT)];
            tf_password.secureTextEntry = YES;
            tf_password.returnKeyType=UIReturnKeyGo;
            tf_password.placeholder = @"密码";
            UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, LOGIN_CELL_HEIGHT)];
            UIImageView * tIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_tf_psd_head"]];
            [tView addSubview:tIv];
            tIv.center = CGPointMake(tView.frame.size.width/2, tView.frame.size.height/2);
            
            tf_password.leftView = tView;
            tf_password.leftViewMode = UITextFieldViewModeAlways;
            tf_password.clearButtonMode = YES;
            tf_password.delegate = self;
            tf_password.backgroundColor = [UIColor clearColor];
            [cell addSubview:tf_password];
            UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, LOGIN_CELL_HEIGHT-0.7,cell.frame.size.width, 0.7)];
            separatorLine.backgroundColor = _rgb2uic(0xd8d8d8, 1);
            [cell addSubview:separatorLine];
            
        }else if (row == CELL_LOGIN_RMB) {
            cell.backgroundColor = [UIColor clearColor];
            int cHeight = 1.5 *LOGIN_CELL_HEIGHT;
            int btnHeight = 30;
            int btnWidth = 90;
            UIButton *btnRmb = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnRmb setTitle:@"记住密码" forState:UIControlStateNormal];
            [btnRmb setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateNormal];
            [btnRmb setImage:[UIImage imageNamed:@"login_rmb_selected"] forState:UIControlStateSelected];
            [btnRmb setImage:[UIImage imageNamed:@"login_rmb_no_selected"] forState:UIControlStateNormal];
            [btnRmb addTarget:self action:@selector(btnRmbAction:) forControlEvents:UIControlEventTouchUpInside];
            btnRmb.titleLabel.textAlignment = NSTextAlignmentRight;
            btnRmb.titleLabel.font = nFont;
            btnRmb.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -3);
            btnRmb.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
            btnRmb.backgroundColor = [UIColor clearColor];
            [cell addSubview:btnRmb];
            btnRmb.frame = CGRectMake(15, (cHeight - btnHeight)/2, btnWidth+10, btnHeight);
            btnRmb.selected = isRemPsd;

            UIButton *btnForgon = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnForgon setTitle:@"忘记密码>>" forState:UIControlStateNormal];
            btnForgon.titleLabel.font = nFont;
            btnForgon.backgroundColor = [UIColor clearColor];
            [btnForgon setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateNormal];
            [btnForgon addTarget:self action:@selector(forgotAction:) forControlEvents:UIControlEventTouchUpInside];
            btnForgon.frame = CGRectMake(cell.frame.size.width - btnWidth - 15, (cHeight - btnHeight)/2, btnWidth, btnHeight);
            [cell addSubview:btnForgon];
            
//            cell.backgroundColor = [UIColor redColor];
            
        }else if (row == CELL_LOGIN_SUBMIT) {
            cell.backgroundColor = [UIColor clearColor];
            
            UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
            int startX = 15;
            CGRect bounds = [[UIScreen mainScreen] applicationFrame];
            btnOrder.frame = CGRectMake(startX, 5, bounds.size.width - 15*2, LOGIN_CELL_HEIGHT-10);
            [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnOrder setTitle:@"登录" forState:UIControlStateNormal];
            [btnOrder setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
            btnOrder.backgroundColor = [UIColor clearColor];
            [btnOrder addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnOrder];

            
        }
        
        
    }else{
        if (indexPath.row == CELL_LOGIN_HIS_ACC) {
            
        }
    }
    return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"didSelectRowAtIndexPath:%d",(int)indexPath.row);
    
}

#pragma mark -
#pragma mark textfieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    if (tf_name == textField) {
        [tf_password becomeFirstResponder];
    }
    if (tf_password == textField) {
        [self login:nil];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [lTableView scrollRectToVisible:self.view.frame animated:YES];//只对UITableViewController起作用
    nowTextField = textField;
    return YES;
}

#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        case HttpRequestType_XT_LOGIN:{
            if (HttpResponseTypeFinished ==  responseCode) {
                //成功
                NSString *xmlStr = [request getResponseStr];
                //NSLog(@"xmlStr-->%@",xmlStr);
                //解析xml
                NSError *error;

                GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:xmlStr options:0 error:&error];
                if (xmlDoc == nil) return;
                NSLog(@"LOG=%@",[[NSString alloc] initWithData:xmlDoc.XMLData encoding:NSUTF8StringEncoding]);
                NSArray *returnMembers = [xmlDoc.rootElement nodesForXPath:@"/result" error:nil];
                //遍历节点
                if (returnMembers.count>0)
                {
                    GDataXMLElement *returnMember = (GDataXMLElement *)[returnMembers objectAtIndex:0];
                    //取ErrorCode值`
                    NSArray *arrayValues = [returnMember elementsForName:@"ErrorCode"];
                    GDataXMLElement *returnCode = (GDataXMLElement *) [arrayValues objectAtIndex:0];
                    NSString *errorCode = returnCode.stringValue;
                    NSLog(@"errorCode-->%@",errorCode);
                    if (![errorCode isEqualToString:@"0"]) {
                        //登录失败，显示失败原因
                        NSString *strError = @"系统异常";
                        int tTag = [errorCode intValue];
                        switch (tTag) {
                            case 0:{
                                //成功
                                break;
                            }
                            case 1:{
                                strError = @"系统账号数量超出许可，无法使用";
                                break;
                            }
                            case 2:{
                                strError = @"账号与密码不符";
                                break;
                            }
                            case 3:
                            case 6:{
                                NSLog(@"不存在该账户");
                                strError = @"不存在该账户";
                                break;
                            }
                            case 4:{
                                strError = @"发送令牌失败";
                                break;
                            }
                            case 5:{
                                strError = @"获取系统参数异常";
                                break;
                            }
                            case 7:{
                                strError = @"账号未开通";
                                break;
                            }
                            case 8:{
                                strError = @"账号暂停使用";
                                break;
                            }
                            case 9:{
                                strError = @"获取用户登录参数异常";
                                break;
                            }
                            case 10:{
                                strError = @"账号没有业务权限";
                                break;
                            }
                            case 11:{
                                strError = @"许可期限已到，无法使用";
                                break;
                            }
                            default:
                                break;
                        }
                        [SVProgressHUD showErrorWithStatus:strError duration:2];
                        return;
                    }
                    
                    //登录成功，读取信息
                    
                    //account
                    NSArray *keyArr = [returnMember elementsForName:@"Key"];
                    GDataXMLElement *keyElement = (GDataXMLElement *) [keyArr objectAtIndex:0];
                    [SettingService sharedInstance].key = keyElement.stringValue;
                    
                    NSArray *orgArr = [returnMember elementsForName:@"OrgId"];
                    GDataXMLElement *orgElement = (GDataXMLElement *) [orgArr objectAtIndex:0];
                    [SettingService sharedInstance].orgId = orgElement.stringValue;
                    
                    NSArray *accountArr = [returnMember elementsForName:@"Account"];
                    GDataXMLElement *accElement = (GDataXMLElement *) [accountArr objectAtIndex:0];
                    [SettingService sharedInstance].account = accElement.stringValue;
                    
                    NSArray *userArr = [returnMember elementsForName:@"User"];
                    GDataXMLElement *userElement = (GDataXMLElement *) [userArr objectAtIndex:0];
                    [SettingService sharedInstance].user = userElement.stringValue;
                    
                    NSArray *tokenArr = [returnMember elementsForName:@"Token"];
                    GDataXMLElement *tokenElement = (GDataXMLElement *) [tokenArr objectAtIndex:0];
                    [SettingService sharedInstance].token = tokenElement.stringValue;
                    
                    [SVProgressHUD showSuccessWithStatus:@"登录成功" duration:1];
                    [self loginSucInto];
                }

            }else{
                //失败
                [SVProgressHUD showErrorWithStatus:@"请求失败" duration:2];
            }
            break;
        }
        default:
            break;
    }
    
}
#pragma mark -
#pragma mark view touches

#pragma mark -
#pragma mark extendsDelegate
-(void)closeExtendsView{
    NSLog(@"close");
}

-(void)accTapped:(id)sender{
    NSLog(@"accTapped");
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    isExtends = !isExtends;

}


@end
