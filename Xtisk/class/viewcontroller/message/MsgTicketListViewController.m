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
@interface MsgTicketListViewController ()

@end

@implementation MsgTicketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"船票";
    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
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
    return 140;
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
    if (1 == indexPath.section &&  0 == indexPath.row) {
        MsgTicketListViewController *mt = [[MsgTicketListViewController alloc]init];
        [self.navigationController pushViewController:mt animated:YES];
    }
    
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
