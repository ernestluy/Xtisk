//
//  SettingViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SettingViewController.h"
#import "PublicDefine.h"
#import "SettingService.h"
#import "AboutIshekouViewController.h"
#import "ModifyPsdViewController.h"
#import "AboutIshekouViewController.h"
#import "RegSecondStepViewController.h"
#import "EditTextViewController.h"
@interface SettingViewController ()
{
    NSArray *titleArr1;
    NSArray *titleArr2;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    titleArr1 = @[@"关于i蛇口",@"建议反馈",@"修改密码"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (![[SettingService sharedInstance] isLogin]) {
        return 1;
    }
    return 3;
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
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
//    if (0 == indexPath.section) {
//        cell.textLabel.text = [titleArr1 objectAtIndex:(int)indexPath.row];
//    }else if (1 == indexPath.section) {
//        cell.textLabel.text = [titleArr2 objectAtIndex:(int)indexPath.row];
//    }
    cell.textLabel.text = [titleArr1 objectAtIndex:(int)indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEFAULT_CELL_HEIGHT;
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
            AboutIshekouViewController *ai = [[AboutIshekouViewController alloc]init];
            [self.navigationController pushViewController:ai animated:YES];
            break;
        }
        case 1:{
            EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextAdvise delegate:nil];
            [self.navigationController pushViewController:et animated:YES];
            break;
        }
            
        case 2:{
//            ModifyPsdViewController *ai = [[ModifyPsdViewController alloc]init];
//            [self.navigationController pushViewController:ai animated:YES];
            ModifyPsdViewController *rs = [[ModifyPsdViewController alloc]initWithTitle:@"修改密码" type:PsdSettingModify];
            [self.navigationController pushViewController:rs animated:YES];
            break;
        }
            
        default:
            break;
    }
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
