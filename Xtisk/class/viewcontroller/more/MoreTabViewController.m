//
//  MoreTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MoreTabViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
#import "MoreTableViewHeaderView.h"
#import "CTLCustom.h"
#import "SettingService.h"
#import "QRCodeScanViewController.h"
#import "PrivateViewController.h"
#define MORE_HEIGHT 44.0
@interface MoreTabViewController ()
{
    NSArray *titleArr;
    NSArray *imgArr;
    MoreTableViewHeaderView *headerView;
}
@end

@implementation MoreTabViewController
@synthesize tTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tTableView.bounces = NO;
    titleArr = @[@"船票订单",@"推荐给好友",@"扫一扫",@"设置"];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MoreTableViewHeaderView" owner:self options:nil];
    
    UIView *tmpCustomView = [nib objectAtIndex:0];
    self.tTableView.tableHeaderView = tmpCustomView;
    if (tmpCustomView && [tmpCustomView isKindOfClass:[MoreTableViewHeaderView class]]) {
        headerView = (MoreTableViewHeaderView*)tmpCustomView;
        [CTLCustom setButtonRadius:headerView.btnLogin];
        [headerView.btnLogin addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)toLogin:(id)sender{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:lv animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"更多";
    
    if ([[SettingService sharedInstance] isLogin]) {
        headerView.btnLogin.hidden = YES;
    }else{
        headerView.btnLogin.hidden = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)logout:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CustomNavigationController *nav = [[CustomNavigationController alloc]init];
    nav.interactivePopGestureRecognizer.enabled = NO;
    [nav pushViewController:[[LoginViewController alloc]init] animated:NO];
    appDelegate.window.rootViewController = nav;
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArr.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"cell";
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    cell.textLabel.text = [titleArr objectAtIndex:(int)indexPath.section];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, MORE_HEIGHT)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MORE_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            
            break;
        }
        case 1:{
            
            break;
        }
        case 2:{
            QRCodeScanViewController *qsc = [[QRCodeScanViewController alloc] init];
            [self.navigationController pushViewController:qsc animated:YES];
            break;
        }
        case 3:{
            PrivateViewController *pv = [[PrivateViewController alloc]init];
            [self.navigationController pushViewController:pv animated:YES];
            break;
        }
        default:
            break;
    }
   
}

@end
