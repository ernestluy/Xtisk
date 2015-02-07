//
//  MessageTabViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MessageTabViewController.h"
#import "LYTableView.h"
#define MSG_TAB_HEIGHT 44.0
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
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tCount;
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
    
    cell.imageView.image = [UIImage imageNamed:@"1-1.jpg"];
//    CGRect tRect = cell.imageView.frame;
    cell.textLabel.text = @"cell";//[titleArr objectAtIndex:(int)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MSG_TAB_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    tCount +=2;
    [self.tTableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    NSLog(@"drag end");
    LYTableView *lyt = (LYTableView *)self.tTableView;
    [lyt judgeDragEnd];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
@end
