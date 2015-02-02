

#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "PublicDefine.h"
//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define EXTENDS_HEIGHT  100
#define LOGIN_CELL_HEIGHT 50
@interface LoginViewController ()
{
    CGPoint touchBeganPoint;
    UITextField *nowTextField;
    int fontSize;
    UIFont *nFont;
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
    }
    return self;
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
    
//    lTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 340) style:UITableViewStyleGrouped];
//    lTableView.delegate = self;
//    lTableView.dataSource = self;
//    lTableView.scrollEnabled = NO;
//    lTableView.backgroundView=nil;
//    lTableView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:lTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
    UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 200)];
    tView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = tView;
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.tableView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *pan2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
    [self.view addGestureRecognizer:pan2];
    
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
}

-(void)reg:(id)sender{
    NSLog(@"reg");
}

-(void)forgotAction:(id)sender{
    NSLog(@"forgotAction");
}
-(void)rememberSwitchAction:(id)sender{
    NSLog(@"rememberSwitchAction");
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
            cell.textLabel.textColor=UIColorFromRGB(0x767676);
            tf_name = [[UITextField alloc] initWithFrame:CGRectMake(65, 0, 200, LOGIN_CELL_HEIGHT)];
            tf_name.returnKeyType=UIReturnKeyNext;
            tf_name.placeholder = @"请输入账号";
            tf_name.delegate = self;
            [cell addSubview:tf_name];
        }
        else if (row == 1) {
 
            cell.textLabel.text = @"密码:";
            cell.textLabel.textColor=UIColorFromRGB(0x767676);
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
            btnForgon.font = nFont;
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
    //becomeFirstResponder
    /*
    if(textField==tf_name){
        [tf_password becomeFirstResponder];
    }else if(textField==tf_password){
        [textField resignFirstResponder];
        CGRect frame=notificationView.frame;
        frame.origin.y=0;
        notificationView.frame=frame;
        
        [self login];
        
    }
     */
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [lTableView scrollRectToVisible:self.view.frame animated:YES];//只对UITableViewController起作用
    nowTextField = textField;
    return YES;
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
