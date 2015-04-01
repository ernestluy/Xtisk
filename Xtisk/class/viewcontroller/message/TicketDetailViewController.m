//
//  TicketDetailViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/21.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketDetailViewController.h"
#import "MyTicketOrderItemStatis.h"
#import "PublicDefine.h"
#import "TicketDetailContentView.h"
@interface TicketDetailViewController ()
{
    NSMutableArray *dataArr;
    NSMutableArray *viewArr;
    NSMutableArray *viewSecondArr;
    NSMutableDictionary *heightDic;
    
    MyTicketOrderItemStatis *myTicketOrderStatis;
}
@end

@implementation TicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    heightDic = [NSMutableDictionary dictionary];
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
    dataArr = [NSMutableArray array];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64 - 76;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
//    tTableView.bounces = NO;
    tTableView.delegate = self;
    tTableView.dataSource = self;
    //    tTableView.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    //    tTableView.backgroundColor = [UIColor clearColor];
    [tTableView registerNib:[UINib nibWithNibName:@"MsgTicketListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tTableView];
    
    myTicketOrderStatis = [[MyTicketOrderItemStatis alloc]init];
    myTicketOrderStatis.frame = CGRectMake(0, 0, 0, 0);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [myTicketOrderStatis setData:self.mOrderDetail with:1];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 3;
    }else if (1 == section){
        return 1;
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
            if (0 == indexPath.row) {
                [cell addSubview:tv];
                TicketDetailContentView *dc = (TicketDetailContentView*)tv;
                MyTicketItem *tItem = [self.mOrderDetail.ticketList objectAtIndex:0];
                dc.labCode.text = tItem.getId;
                dc.labStatus.text = self.mOrderDetail.orderStatus;
                
                dc.labStatus.textColor = [Util getPayStatusColorWith:self.mOrderDetail.status];
                
            }else if(1 == indexPath.row){
                [cell addSubview:myTicketOrderStatis];
            }else if(2 == indexPath.row){
                [cell addSubview:tv];
                TicketDetailContentView *dc = (TicketDetailContentView*)tv;
                dc.labNme.text = self.mOrderDetail.peopleInfo.name;
                dc.labEmail.text = self.mOrderDetail.peopleInfo.email;
                dc.labTel.text = self.mOrderDetail.peopleInfo.phone;
                dc.labCode.text = self.mOrderDetail.peopleInfo.identity_card;
            }
        }else if (1 == indexPath.section){
            UIView *tv = [viewSecondArr objectAtIndex:indexPath.row];
            [cell addSubview:tv];
            TicketDetailContentView *dc = (TicketDetailContentView*)tv;
            dc.labMoney.text = [NSString stringWithFormat:@"%0.1f",self.mOrderDetail.totalPrice];
        }
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0 == indexPath.section) {
        
        if (0 == indexPath.row) {
            return 41;
        }else if(1 == indexPath.row){
            return  myTicketOrderStatis.frame.size.height;
        }else if(2 == indexPath.row){
            return 98;
        }
    }else if (1 == indexPath.section){
        return 63;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
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
