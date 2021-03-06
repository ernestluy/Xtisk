//
//  AboutIshekouViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/12.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "AboutIshekouViewController.h"
#import "PublicDefine.h"
#import "CTLCustom.h"
#import "AboutIshekouHeaderView.h"
#define ishekouCellId @"ishekouCellId"
@interface AboutIshekouViewController ()
{
    NSArray *titleArr;
    NSArray *detailArr;
    NSArray *iconArr;
}
@end

@implementation AboutIshekouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"关于i蛇口";
    CGRect bounds = [UIScreen mainScreen].bounds;
    /*
     联系电话：4009301979
     微信公众号：iShekouABA
     Email：skiz.service@cmhk.com
     内容合作：maijiaming@cmhk.com
     */
    titleArr = @[@"微信公众号",@"联系电话",@"内容合作",@"Email"];
    iconArr  = @[@"about_wechat",@"about_tel",@"about_coo",@"about_email"];
    detailArr = @[@"iShekouABA",@"4009301979",@"maijiaming@cmhk.com",@"skiz.service@cmhk.com"];
    
    int tableHeight = bounds.size.height - 64 - 70;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    [self.view addSubview:tTableView];
    self.view.backgroundColor  = _rgb2uic(0xf7f7f7, 1);
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AboutIshekouHeaderView" owner:self options:nil];
    UIView *tmpView = [nib objectAtIndex:0];
    tmpView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    AboutIshekouHeaderView *ais = (AboutIshekouHeaderView *)tmpView;
    ais.labVersion.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    //获取系统info.plist文件中的键值对
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取软件的版本号
    NSString * version = [infoDict objectForKey:@"CFBundleVersion"];
    ais.labVersion.text = @"1.1.0";
    ais.labVersion.textColor = defaultTextGrayColor;
    tTableView.tableHeaderView = tmpView;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return titleArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell_%d",(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        CGRect cRect = CGRectMake(tv.frame.size.width - 15 - 190, 0, 190.0, DEFAULT_CELL_HEIGHT);
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:[iconArr objectAtIndex:indexPath.row]];
        UILabel *tmpLabel = [CTLCustom getCusRightLabel:cRect];
        [cell addSubview:tmpLabel];
        tmpLabel.text = [detailArr objectAtIndex:indexPath.row];
        tmpLabel.textColor = defaultTextColor;
        if (0 == indexPath.row || 3 == indexPath.row) {
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        }
        if (1 == indexPath.row || 2 == indexPath.row) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (2 == indexPath.row) {
            //获取系统info.plist文件中的键值对
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            //获取软件的版本号
            NSString * version = [infoDict objectForKey:@"CFBundleVersion"];

//            cell.detailTextLabel.text = version;
        }
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEFAULT_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (1 == indexPath.row) {
//        NSString *telNum = [NSString stringWithFormat:@"tel://%@",[detailArr objectAtIndex:1]];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
//    }
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
