//
//  MessageTabViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MessageTabViewController.h"
#import "LYTableView.h"
#import "MsgTicketListViewController.h"
#import "PublicDefine.h"
#import "ActivityViewController.h"
#import "MessageListViewController.h"
#import "BadgeView.h"
#import "MessageListTableViewCell.h"
#import "MessageDBManager.h"
#import "TicketQueryViewController.h"
#define MSG_TAB_HEIGHT 50.0
#define kCell @"kCell"
@interface MessageTabViewController ()
{
    BOOL isCanFlushCtl;
    int tCount;
}

@end


@implementation MessageTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tCount= 5;
    
//    [self.tTableView registerClass:[MessageListTableViewCell class] forCellReuseIdentifier:kCell];
    [self.tTableView registerNib:[UINib nibWithNibName:@"MessageListTableViewCell" bundle:nil] forCellReuseIdentifier:kCell];
    
    self.tTableView.separatorInset = UIEdgeInsetsMake(0, 48, 0, 0);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flushMsgStatus) name:kPushMessageFlush object:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"消息";
//    [self.tTableView reloadData];
}
- (void)flushMsgStatus {
    NSLog(@"flushMsgStatus");
    [self.tTableView reloadData];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if (1 == section){
        return 2;
    }
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSString *identifier = [NSString stringWithFormat:@"cell%d_%d",(int)indexPath.section,(int)indexPath.row];
    MessageListTableViewCell * cell = (MessageListTableViewCell*)[tv dequeueReusableCellWithIdentifier:kCell];

    
    if (0 == indexPath.section) {

        cell.imgViewHeader.image = [UIImage imageNamed:@"msg_ishekou_cell_icon"];
        cell.labTitle.text = @"i蛇口";
        int unReadMsg = [DBManager queryCountUnReadMsgWithAccount:[SettingService sharedInstance].iUser.phone];
        [cell.badgeView setTnum:unReadMsg];
        PushMessageItem *item = [DBManager queryPushMessageItemLastOneWithAccount:[SettingService sharedInstance].iUser.phone];
        if (item) {
            cell.labMsg.text = item.content;
            cell.labTime.text = item.dateCreate;
        }else{
            cell.labTime.text = @"";
            cell.labMsg.text = @"hi，亲爱的小伙伴，欢迎使用i蛇口！";
        }
    }else if(1 == indexPath.section){
        NSArray *titleArr2 = @[@"船票",@"园区活动"];
        NSArray *imgArr2 =  @[@"msg_ticket_cell_icon",@"msg_activity_cell_icon"];
        cell.imgViewHeader.image = [UIImage imageNamed:[imgArr2 objectAtIndex:indexPath.row]];
        cell.labTitle.text = [titleArr2 objectAtIndex:indexPath.row];
        [cell.badgeView setTnum:0];
        cell.labTime.text = @"";
        cell.labMsg.text = @"";
        if (0 == indexPath.row) {
            [cell.badgeView setTnum:[SettingService sharedInstance].badgeTicket];//[SettingService sharedInstance].badgeTicket
            if ([TicketSerivice sharedInstance].arrOrderSuc.count > 0) {
                MyTicketOrderDetail *od = [[TicketSerivice sharedInstance].arrOrderSuc lastObject];
                if (od.orderTime && od.orderTime.length>10) {
                    cell.labTime.text = [od.orderTime substringToIndex:10];
                }else{
                    cell.labTime.text = od.orderTime;
                }
                if (od.ticketList.count > 0) {
                    MyTicketItem *item = [od.ticketList objectAtIndex:0];
                    cell.labMsg.text = item.ticketInfo;
                }
                
            }else{
                //您还没有买过船票呢，现在就去买？
                cell.labMsg.text = @"您还没有买过船票呢，现在就去买？";
            }
            
            
        }else if(1 == indexPath.row){
            cell.labMsg.text = @"点击查看更多精彩活动！";
        }
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MSG_TAB_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section && 0 == indexPath.row) {
        MessageListViewController *mc = [[MessageListViewController alloc] init];
        [DBManager updateMsgIsReadWithAccount:[SettingService sharedInstance].iUser.phone];
        [self.navigationController pushViewController:mc animated:YES];
    }
    if (1 == indexPath.section &&  0 == indexPath.row) {
        if (!authorityTicket) {
            [SVProgressHUD showSuccessWithStatus:@"即将上线，敬请期待！" duration:2];
            return;
        }
        if ([TicketSerivice sharedInstance].arrOrderSuc.count > 0) {
            [SettingService sharedInstance].badgeTicket = 0;
            MsgTicketListViewController *mt = [[MsgTicketListViewController alloc]init];
            [self.navigationController pushViewController:mt animated:YES];
        }else{
            //您还没有买过船票呢，现在就去买？
            TicketQueryViewController *mc = [[TicketQueryViewController alloc] init];
            [self.navigationController pushViewController:mc animated:YES];
        }
    }else if(1 == indexPath.section &&  1 == indexPath.row){
        ActivityViewController *ac = [[ActivityViewController alloc]init];
        [self.navigationController pushViewController:ac animated:YES];
    }
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    LYTableView *lyt = (LYTableView *)self.tTableView;
    [lyt setIsDraging:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    LYTableView *lyt = (LYTableView *)self.tTableView;
    [lyt judgeDragIng];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"drag end");
    LYTableView *lyt = (LYTableView *)self.tTableView;
    [lyt judgeDragEnd];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
@end
