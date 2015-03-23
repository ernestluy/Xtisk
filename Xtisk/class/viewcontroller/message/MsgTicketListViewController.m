//
//  MsgTicketListViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MsgTicketListViewController.h"
#import "PublicDefine.h"
#import "MsgTicketListTableViewCell.h"
#import "TicketDetailViewController.h"
#import "TicketSerivice.h"
#import "MyTicketOrderDetail.h"
@interface MsgTicketListViewController ()
{
    NSMutableArray *dataArr;
    UILabel *labNoteNoData;
}
@end

@implementation MsgTicketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"船票";
    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    dataArr = [TicketSerivice sharedInstance].arrOrderSuc;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, bounds.size.width-20, tableHeight) style:UITableViewStylePlain];
    tTableView.delegate = self;
    tTableView.dataSource = self;
//    tTableView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
//    tTableView.backgroundColor = [UIColor clearColor];
    [tTableView registerNib:[UINib nibWithNibName:@"MsgTicketListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tTableView];
    
    labNoteNoData = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    labNoteNoData.text = @"暂无购买船票信息";
    labNoteNoData.font = [UIFont systemFontOfSize:14];
    labNoteNoData.textColor = defaultTextColor;
    labNoteNoData.textAlignment = NSTextAlignmentCenter;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (dataArr.count == 0) {
        tTableView.tableFooterView = labNoteNoData;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:kPushMessageFlush object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArr.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"cell";
    MsgTicketListTableViewCell * cell = (MsgTicketListTableViewCell*)[tv dequeueReusableCellWithIdentifier:identifier];
//    cell.backgroundColor = [UIColor clearColor];
    MyTicketOrderDetail *order = [dataArr objectAtIndex:indexPath.section];
    [cell setData:order];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == (dataArr.count - 1)) {
        return 10;
    }
    return 1.0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    CGRect bounds = [UIScreen mainScreen].bounds;
//    UIView *tt = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 10)];
//    tt.backgroundColor = [UIColor redColor];
//    return tt;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyTicketOrderDetail *od = [dataArr objectAtIndex:indexPath.section];
    TicketDetailViewController *tdc = [[TicketDetailViewController alloc]init];
    tdc.mOrderDetail = od;
    [self.navigationController pushViewController:tdc animated:YES];
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
