//
//  NearFilterView.m
//  Xtisk
//
//  Created by zzt on 15/3/23.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "NearFilterView.h"
#import "PublicDefine.h"
@interface NearFilterView()
{
    UITableView *tTableView;
    NSArray *arrFilterCondition;
    
}
@end
@implementation NearFilterView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    arrFilterCondition =  @[@"评价最多",@"点赞人数"];
    
//    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect tRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    tTableView = [[LYTableView alloc]initWithFrame:tRect style:UITableViewStylePlain];
    [self addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    tTableView.backgroundColor = [UIColor clearColor];
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.backgroundColor = _rgb2uic(0xf2eeeb, 1);
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tTableView.frame.size.width, 95)];
    topView.backgroundColor = [UIColor clearColor];
    UILabel *labFilter = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, tTableView.frame.size.width, 46)];
    labFilter.text = @"筛选";
    labFilter.font = [UIFont systemFontOfSize:17];
    labFilter.textColor = defaultTextColor;
    [topView addSubview:labFilter];
    
    UIImageView *imgViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 90, 145, 5)];
    imgViewLine.image = [UIImage imageNamed:@"filter_title_line"];
    [topView addSubview:imgViewLine];
    
    
    tTableView.tableHeaderView = topView;
    return self;
}


#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrFilterCondition.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if ([SettingService sharedInstance].filterSelectedIndex == indexPath.row) {
        cell.textLabel.textColor = MainTintColor;
        UIImageView *accView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        accView.image = [UIImage imageNamed:@"login_rmb_selected.png"];
        cell.accessoryView = accView;
    }else{
        cell.textLabel.textColor = defaultTextColor;
        cell.accessoryView = nil;
    }
    cell.textLabel.text = [arrFilterCondition objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [SettingService sharedInstance].filterSelectedIndex = (int)indexPath.row;
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterDidSelected:)]) {
        [self.delegate filterDidSelected:(int)indexPath.row];
    }
}

@end
