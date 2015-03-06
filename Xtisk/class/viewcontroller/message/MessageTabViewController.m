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
#define MSG_TAB_HEIGHT 50.0
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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"消息";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *identifier = @"cell";
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    
    if (0 == indexPath.section) {
        cell.imageView.image = [UIImage imageNamed:@"msg_ishekou_cell_icon"];
        cell.textLabel.text = @"i蛇口";
    }else if(1 == indexPath.section){
        NSArray *titleArr2 = @[@"船票",@"园区活动"];
        NSArray *imgArr2 =  @[@"msg_ticket_cell_icon",@"msg_activity_cell_icon"];
        cell.imageView.image = [UIImage imageNamed:[imgArr2 objectAtIndex:indexPath.row]];
        cell.textLabel.text = [titleArr2 objectAtIndex:indexPath.row];
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
        [self.navigationController pushViewController:mc animated:YES];
    }
    if (1 == indexPath.section &&  0 == indexPath.row) {
        MsgTicketListViewController *mt = [[MsgTicketListViewController alloc]init];
        [self.navigationController pushViewController:mt animated:YES];
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
