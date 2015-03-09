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
#define kTicketVoyageTableViewCell @"kTicketVoyageTableViewCell"
@interface TicketVoyageEditViewController ()
{
    UITableView *tTableView;
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
    
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTicketVoyageTableViewCell];
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
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 3;
    }else if(1 == section){
        return 2;
    }
    return 2;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell];
    
    cell.textLabel.text = [NSString stringWithFormat:@"index:%d%d",(int)indexPath.section,(int)indexPath.row];
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
