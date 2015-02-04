

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

#define EXTENDS_HEIGHT  100
#define LOGIN_CELL_HEIGHT 50
@interface LoginViewController ()
{
    CGPoint touchBeganPoint;
    UITextField *nowTextField;
    int fontSize;
    UIFont *nFont;
    
    BOOL isRemPsd;
}


@end
@interface LoginViewController (haha)

-(void)fuck;
@end

@implementation LoginViewController
//@synthesize lTableView;
-(id)init{
    self = [super init];
    if (self) {
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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    NSLog(@"asdasdf");
    #endif
	
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        bounds = [[UIScreen mainScreen] bounds];
        bounds.size.height = bounds.size.height -20;
        
    }
    

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
    
    
    UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 200)];
    tView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = tView;
    
    UIButton *ddd = [UIButton buttonWithType:UIButtonTypeCustom];
    ddd.frame = CGRectMake(100, 100, 100, 100);
    ddd.backgroundColor = [UIColor lightGrayColor];
    [ddd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ddd setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [ddd setTitle:@"OK" forState:UIControlStateNormal];
    [ddd addTarget:self action:@selector(setData) forControlEvents:UIControlEventTouchUpInside];
    [tView addSubview:ddd];
    
    UIView *tView2 = [[UIView alloc]initWithFrame:tView.bounds];
    tView2.backgroundColor = [UIColor blueColor];
    tView2.alpha = 0.4;
    tView2.userInteractionEnabled = NO;//NO可以穿透过去
    [tView addSubview:tView2];
    
    
    
    
//    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [self.tableView addGestureRecognizer:pan];
//    
//    UITapGestureRecognizer *pan2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
//    [self.view addGestureRecognizer:pan2];
    
    [self performSelector:@selector(setData) withObject:nil afterDelay:1];
}

-(void)setData{
    NSLog(@"setData");
    tf_name.text = @"test1";
    tf_password.text = @"888888";
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
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
    [SVProgressHUD showWithStatus:@"请等待" maskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD showWithStatus:@"请等待" ];
    [[[HttpService sharedInstance] getRequestLogin:self name:tf_name.text psd:tf_password.text]startAsynchronous];

}
-(void)loginSucInto{
    [self.navigationController popViewControllerAnimated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MainTabBarViewController *mTabBar = [[MainTabBarViewController alloc]init];
    CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:mTabBar];
    nav.interactivePopGestureRecognizer.enabled = NO;
    
    appDelegate.window.rootViewController = nav;

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark UITableViewDataSource



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (2 == indexPath.row) {
        return  40.0;
    }else if(4 ==indexPath.row){
        return 30;
    }
	return LOGIN_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
	return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIndentifier = [NSString stringWithFormat:@"%d_%d",(int)indexPath.section,(int)indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        int row = (int)indexPath.row;
        if (row == 0) {
            cell.textLabel.text = @"账号:";
            cell.textLabel.textColor=_rgb2uic(0x767676, 1);
            tf_name = [[UITextField alloc] initWithFrame:CGRectMake(65, 0, 200, LOGIN_CELL_HEIGHT)];
            tf_name.returnKeyType=UIReturnKeyNext;
            tf_name.placeholder = @"请输入账号";
            tf_name.delegate = self;
            [cell addSubview:tf_name];
        }
        else if (row == 1) {
 
            cell.textLabel.text = @"密码:";
            cell.textLabel.textColor= _rgb2uic(0x767676, 1);
            tf_password = [[UITextField alloc] initWithFrame:CGRectMake(65,0, 200, LOGIN_CELL_HEIGHT)];
            tf_password.secureTextEntry = YES;
            tf_password.returnKeyType=UIReturnKeyGo;
            tf_password.placeholder = @"请输入密码";
            tf_password.delegate = self;
            [cell addSubview:tf_password];
            
        }else if (row == 2) {
            cell.backgroundColor = [UIColor clearColor];
            // frame = (15 10; 51 31)
            UISwitch *rememberSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(15, 5, 50, 31)];
            rememberSwitch.on = YES;
            [cell addSubview:rememberSwitch];
            [rememberSwitch addTarget:self action:@selector(rememberSwitchAction:) forControlEvents:UIControlEventValueChanged];
            
            UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rememberSwitch.frame)+4, 0, 90, 40)];
            tLabel.font = nFont;
            tLabel.textColor = [UIColor darkGrayColor];
            [cell addSubview:tLabel];
            tLabel.textAlignment = NSTextAlignmentLeft;
            tLabel.text = @"记住密码?";
            

            UIButton *btnForgon = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnForgon setTitle:@"忘记密码?" forState:UIControlStateNormal];
            btnForgon.titleLabel.font = nFont;
            [btnForgon sizeToFit];
            [btnForgon setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btnForgon addTarget:self action:@selector(forgotAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = btnForgon;
            
        }else if (row == 3) {
            cell.backgroundColor = [UIColor clearColor];
            
            UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
            int startX = 15;
            CGRect bounds = [[UIScreen mainScreen] applicationFrame];
            btnOrder.frame = CGRectMake(startX, 5, bounds.size.width - 15*2, LOGIN_CELL_HEIGHT-10);
            [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnOrder setTitle:@"登录" forState:UIControlStateNormal];
            btnOrder.layer.cornerRadius = 4;
            btnOrder.backgroundColor = _rgb2uic(0x1bbbfe, 1);
            [btnOrder addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnOrder];

            
        }
        else if (row == 4) {
            cell.backgroundColor = [UIColor clearColor];
            
            UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 30)];
            tLabel.font = nFont;
            tLabel.textColor = [UIColor darkGrayColor];
            [cell addSubview:tLabel];
            tLabel.textAlignment = NSTextAlignmentLeft;
            tLabel.text = @"还没账号?";
            
            
        }
        else if (row == 5) {
            cell.backgroundColor = [UIColor clearColor];
            
            UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
            int startX = 15;
            CGRect bounds = [[UIScreen mainScreen] applicationFrame];
            btnOrder.frame = CGRectMake(startX, 5, bounds.size.width - 15*2, LOGIN_CELL_HEIGHT-10);
            [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnOrder setTitle:@"现在去注册" forState:UIControlStateNormal];
            btnOrder.layer.cornerRadius = 4;
            btnOrder.backgroundColor = _rgb2uic(0x1bbbfe, 1);
            [btnOrder addTarget:self action:@selector(reg:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnOrder];
            
            btnOrder.userInteractionEnabled = NO;
            
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
