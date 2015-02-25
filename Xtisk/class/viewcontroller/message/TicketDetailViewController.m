//
//  TicketDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/21.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketDetailViewController.h"
#import "PublicDefine.h"
@interface TicketDetailViewController ()
{
    NSMutableArray *dataArr;
    NSMutableArray *viewArr;
    NSMutableArray *viewSecondArr;
}
@end

@implementation TicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    viewArr = [NSMutableArray array];
    viewSecondArr = [NSMutableArray array];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TicketDetailContentView" owner:self options:nil];
    for (UIView *tv in nib) {
        if (tv.tag <10) {
            [viewArr addObject:tv];
        }else{
            [viewSecondArr addObject:tv];
        }
        
    }
    dataArr = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64 - 76;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    //    tTableView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    //    tTableView.backgroundColor = [UIColor clearColor];
    [tTableView registerNib:[UINib nibWithNibName:@"MsgTicketListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tTableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return viewArr.count;
    }else if (1 == section){
        return viewSecondArr.count;
    }
    return 0;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (0 == indexPath.section) {
            UIView *tv = [viewArr objectAtIndex:indexPath.row];
            [cell addSubview:tv];
        }else if (1 == indexPath.section){
            UIView *tv = [viewSecondArr objectAtIndex:indexPath.row];
            [cell addSubview:tv];
        }
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0 == indexPath.section) {
        UIView *tv = [viewArr objectAtIndex:indexPath.row];
        return tv.frame.size.height;
    }else if (1 == indexPath.section){
        UIView *tv = [viewSecondArr objectAtIndex:indexPath.row];
        return tv.frame.size.height;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == (dataArr.count - 1)) {
        return 10;
    }
    return 1.0;
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



@end
