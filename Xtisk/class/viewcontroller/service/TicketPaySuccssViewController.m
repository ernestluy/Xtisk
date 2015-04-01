//
//  TicketPaySuccssViewController.m
//  Xtisk
//
//  Created by zzt on 15/3/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketPaySuccssViewController.h"
#import "UPayResultView.h"
#import "PublicDefine.h"
@interface TicketPaySuccssViewController ()
{
    UPayResultView *resultView;
    UITableView *tTableView;
}
@end

@implementation TicketPaySuccssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"支付成功";
    resultView = [UPayResultView UPayResultViewWithXib];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64) ;

    tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    [self.view addSubview:tTableView];
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 140)];
//    footView.backgroundColor = [UIColor yellowColor];
    tTableView.tableFooterView = footView;
    
    UILabel *labNote = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, bounds.size.width - 15*2, 60)];
    labNote.font = [UIFont systemFontOfSize:13];
    labNote.textColor = _rgb2uic(0xef5e56, 1);
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    labNote.numberOfLines = 0;
    labNote.text = @"温馨提示：凡通过i蛇口购买船票（含返程）均须在蛇口码头售票窗口取票，暂不支持异地取票！蛇口码头客户服务热线：0755-26695601";
    [footView addSubview:labNote];
//    labNote.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    int startX = 15;
    btnOrder.frame = CGRectMake(startX,80, bounds.size.width - 15*2, 44);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"返回" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"login_submit"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(toBack) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    tTableView.tableFooterView = footView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.mOrderDetail) {
        MyTicketItem *seat = [self.mOrderDetail.ticketList objectAtIndex:0];
        [resultView setCode:seat.getId res:YES];
    }
}

-(void)toBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:resultView];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return resultView.frame.size.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    
    
}


@end
