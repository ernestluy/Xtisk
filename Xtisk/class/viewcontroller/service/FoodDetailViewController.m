//
//  FoodDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailHeader.h"
#import "PublicDefine.h"
#import "DetailFoodTableViewCell.h"
#import "BaiduMapViewController.h"
#import "SettingService.h"
#import "DetailFoodCommendTableViewCell.h"
#import "ComCommendViewController.h"
#import "EditTextViewController.h"
#import "FoodShopAllMenuViewController.h"
#import "LoginViewController.h"
#define SECTION_SENCOND_HEIGHT   56.0
#define SECTION_THIRD_HEIGHT     120.0
@interface FoodDetailViewController ()
{
    FoodDetailHeader *foodDetailHeader;
    UIButton *btnCall;
}
@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds = [UIScreen mainScreen].bounds;
//    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - DEFAULT_CELL_HEIGHT - 64);
    self.tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:self.tTableView];
    self.tTableView.dataSource = self;
    self.tTableView.delegate = self;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FoodDetailHeader" owner:self options:nil];
    foodDetailHeader = [nib objectAtIndex:0];
    [foodDetailHeader setUIInit];
//    foodDetailHeader.backgroundColor = [UIColor redColor];
    self.tTableView.tableHeaderView = foodDetailHeader;
    [foodDetailHeader.btnCommend addTarget:self action:@selector(toCommend:) forControlEvents:UIControlEventTouchUpInside];
    [foodDetailHeader.btnGood addTarget:self action:@selector(toPraise:) forControlEvents:UIControlEventTouchUpInside];
    
    self.title = @"商家详情";
    
    [self.tTableView registerNib:[UINib nibWithNibName:@"DetailFoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    //DetailFoodCommendTableViewCell
    [self.tTableView registerNib:[UINib nibWithNibName:@"DetailFoodCommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    UIView *callView = [[UIView alloc]initWithFrame:CGRectMake(0, bounds.size.height - DEFAULT_CELL_HEIGHT - 64, bounds.size.width, DEFAULT_CELL_HEIGHT)];
    callView.backgroundColor = _rgb2uic(0x0095f1, 1);
    [self.view addSubview:callView];
    UILabel *labCall = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, callView.frame.size.height)];
    labCall.font = [UIFont boldSystemFontOfSize:16];
    labCall.textAlignment = NSTextAlignmentCenter;
    labCall.textColor = [UIColor whiteColor];
    labCall.text = @"我要叫餐";
    [callView addSubview:labCall];
    btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCall.frame = CGRectMake(130, 5, 180, 33);
    [btnCall addTarget:self action:@selector(toCall:) forControlEvents:UIControlEventTouchUpInside];
    [btnCall setTitle:@"0755-23656666" forState:UIControlStateNormal];
    [btnCall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"food_call_normal"] forState:UIControlStateNormal];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"food_call_normal"] forState:UIControlStateHighlighted];
    [btnCall setImage:[UIImage imageNamed:@"tel_symbol"] forState:UIControlStateNormal];
    [btnCall setImage:[UIImage imageNamed:@"tel_symbol"] forState:UIControlStateHighlighted];
    btnCall.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btnCall.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [callView addSubview:btnCall];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)toCall:(id)sender{
    NSLog(@"toCall");
    NSString *telNum = [NSString stringWithFormat:@"tel://%@",btnCall.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
}
-(void)toCommend:(id)sender{
    NSLog(@"toCommend");
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextFoodCommend delegate:self];
    [self.navigationController pushViewController:et animated:YES];
}
-(void)toPraise:(id)sender{
    if (![[SettingService sharedInstance] isLogin]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
        return;
    }
    NSLog(@"toPraise");
}

#pragma mark - EditTextViewDelegate
- (void)editTextDone:(NSString *)str type:(int)ty{
    NSLog(@"editTextDone");
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if (1 == section){
        return 3 + 1;
    }else if(2 == section){
        return 5 + 1;
    }
    return 4;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.section) {
        NSString *identifier = @"cell1";
        UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
        if (cell ==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.imageView.image  = [UIImage imageNamed:@"address_cion"];
        cell.textLabel.text = @"地址:南山区工业五路万维大厦一楼";
        cell.clipsToBounds = YES;
        
//        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow_gray"]];
//        cell.accessoryView = iv;
        return cell;
    }else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            NSString *identifier = @"cell_normal";
            UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14]; //[UIFont systemFontOfSize:14];
            }
            cell.textLabel.text = @"全部菜单(24)";
            
            return cell;
        }else{
            NSString *identifier = @"cell2";
            DetailFoodTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[DetailFoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (2 == indexPath.section) {
        if (0 == indexPath.row) {
            NSString *identifier = @"cell_normal";
            UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"网友评价(36)";
            
            return cell;
        }else{
            NSString *identifier = @"cell3";
            DetailFoodCommendTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
            
            if (cell ==nil) {
                cell = [[DetailFoodCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0.1;
    }
    return 9.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((1 == indexPath.section || 2 == indexPath.section) && 0 == indexPath.row) {
        return 38 ;
    }
    
    if (1 == indexPath.section) {
        return SECTION_SENCOND_HEIGHT;
    }else if (2 == indexPath.section) {
        return SECTION_THIRD_HEIGHT;
    }
    return DEFAULT_CELL_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row && 0 == indexPath.section) {
        [[SettingService sharedInstance] PermissionBaiduMap];
        BaiduMapViewController *bv = [[BaiduMapViewController alloc] initWithLong:113.922 lat:22.497];
        [self.navigationController pushViewController:bv animated:YES];

    }else if (0 == indexPath.row && 1 == indexPath.section) {
        NSLog(@"全部菜单");
        FoodShopAllMenuViewController *sc = [[FoodShopAllMenuViewController alloc]initWithId:10];
        [self.navigationController pushViewController:sc animated:YES];
    }else if (0 == indexPath.row && 2 == indexPath.section) {
        NSLog(@"网友评价");
        ComCommendViewController *ccc = [[ComCommendViewController alloc]init];
        [self.navigationController pushViewController:ccc animated:YES];
    }
    
}


#pragma ,mark -
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
