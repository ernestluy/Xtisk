//
//  SettingViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SettingViewController.h"
#import "PublicDefine.h"
#import "SettingService.h"
#import "AboutIshekouViewController.h"
#import "ModifyPsdViewController.h"
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
    titleArr1 = @[@"关于i蛇口"];
    titleArr2 = @[@"建议反馈",@"修改密码",@"退出"];
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return titleArr1.count;
    }else if (1 == section) {
        return titleArr2.count;
    }
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
    
    if (0 == indexPath.section) {
        cell.textLabel.text = [titleArr1 objectAtIndex:(int)indexPath.row];
    }else if (1 == indexPath.section) {
        cell.textLabel.text = [titleArr2 objectAtIndex:(int)indexPath.row];
    }
    
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
    if (0 == indexPath.section && 0 == indexPath.row) {
        AboutIshekouViewController *ai = [[AboutIshekouViewController alloc]init];
        [self.navigationController pushViewController:ai animated:YES];
    }else if (1 == indexPath.section){
        switch (indexPath.row) {
            case 0:{
                
                break;
            }
            case 1:{
                ModifyPsdViewController *ai = [[ModifyPsdViewController alloc]init];
                [self.navigationController pushViewController:ai animated:YES];
                break;
            }
            
            case 2:{
                [[SettingService sharedInstance] logout];
                [self.navigationController popViewControllerAnimated:YES];
                break;
            }
                
            default:
                break;
        }
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
