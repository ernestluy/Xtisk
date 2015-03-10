//
//  TicketVoyageEditViewController.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketVoyageEditViewController.h"
#import "TicketSerivice.h"
#import "TicketOrderEditViewController.h"
#import "TicketQueryListViewController.h"
#import "TicketNumsEdit1TableViewCell.h"
#define kTicketVoyageTableViewCell1 @"kTicketVoyageTableViewCell1"

@interface TicketVoyageEditViewController ()
{
    UITableView *tTableView;
    UIButton *btnOrder;
}

-(void)toNextStep:(id)sender;
@end

@implementation TicketVoyageEditViewController
@synthesize tStep;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64) ;
    tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tTableView registerNib:[UINib nibWithNibName:@"TicketNumsEdit1TableViewCell" bundle:nil] forCellReuseIdentifier:kTicketVoyageTableViewCell1];
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellDefault];
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 300)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    
    
    int startX = 15;
    CGRect ttr = CGRectMake(startX, 20 , bounds.size.width - 15*2, 44);
    btnOrder = [CTLCustom getTableViewLastButton:ttr];
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"确定" forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(toNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    UILabel *labNote = [[UILabel alloc]initWithFrame:CGRectMake(startX, 70 , ttr.size.width, 145)];
    labNote.textColor = defaultTextGrayColor;
//    labNote.backgroundColor = [UIColor yellowColor];
    labNote.font = [UIFont systemFontOfSize:13];
    labNote.text = @"温馨提示:\n1.儿童过1.2米但不超过1.5米，需购买小童票；超过1.5米者，应购买全票。每位成人旅客可免费携身高不超过1.2米的儿童一人，超过一人时应按照超过人数购买小童票。\n2.长者（65岁或以上），需购买长者票，取票时必须出示本人身份证。";
    labNote.numberOfLines = 0 ;
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    [footView addSubview:labNote];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"选择航班";
    if (TICKET_QUERY_RETURN == [TicketSerivice sharedInstance].ticketQueryType) {
        if (TicketVoyageStepFirst == tStep) {
            self.title = @"选择航班-起航";
        }else if(TicketVoyageStepSecond == tStep){
            self.title = @"选择航班-返航";
        }
        
    }else if (TICKET_QUERY_ONE == [TicketSerivice sharedInstance].ticketQueryType){
        self.title = @"选择航班";
    }
}


-(void)toNextStep:(id)sender{
    if (TICKET_QUERY_RETURN == [TicketSerivice sharedInstance].ticketQueryType) {
        if (TicketVoyageStepFirst == tStep) {
//            TicketVoyageEditViewController *tvv = [[TicketVoyageEditViewController alloc] init];
//            tvv.tStep = TicketVoyageStepSecond;
            TicketQueryListViewController *tvv = [[TicketQueryListViewController alloc] init];
            tvv.tStep = TicketVoyageStepSecond;
            [self.navigationController pushViewController:tvv animated:YES];
        }else if(TicketVoyageStepSecond == tStep){
            NSLog(@"进入订单详情，准备付费");
            TicketOrderEditViewController *to = [[TicketOrderEditViewController alloc] init];
            [self.navigationController pushViewController:to animated:YES];
        }
        
    }else if (TICKET_QUERY_ONE == [TicketSerivice sharedInstance].ticketQueryType){
        NSLog(@"进入订单详情，准备付费");
        TicketOrderEditViewController *to = [[TicketOrderEditViewController alloc] init];
        [self.navigationController pushViewController:to animated:YES];
    }
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
    }else if(1 == section){
        return 3;
    }else if(2 == section){
        return 2;
    }
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell1];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"index:%d%d",(int)indexPath.section,(int)indexPath.row];
    NSString*strIdentifier = [NSString stringWithFormat:@"cell_%d_%d",(int)indexPath.section,(int)indexPath.row];
    switch (indexPath.section) {
        case 0:{
            if (0 == indexPath.row) {
                
                UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:strIdentifier];
                if (cell ==nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
                    cell.textLabel.textColor = defaultTextColor;
                }

                return cell;
            }
            break;
        }
        case 1:{
            TicketNumsEdit1TableViewCell * cell = (TicketNumsEdit1TableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell1];
            
            return cell;
            break;
        }
        case 2:{
            UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:strIdentifier];
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
                cell.textLabel.textColor = defaultTextColor;
            }
            if (0 == indexPath.row) {
                
            }else if(1 == indexPath.row){
                
            }
            return cell;
            break;
        }
        default:
            break;
    }
    return [tv dequeueReusableCellWithIdentifier:kCellDefault];;
    
    
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 30)];
        for (int i = 0; i<3; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100*i, 0, 100, 30)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = [@[@"票类",@"价格",@"数量"] objectAtIndex:i];
            lab.textAlignment = NSTextAlignmentCenter;
            [tView addSubview:lab];
        }
        return tView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0.2;
    }else if(1 == section){
        return 30;
    }else if(2 == section){
        return 8;
    }
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DEFAULT_CELL_HEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [self toNextStep:nil];
    
}

@end
