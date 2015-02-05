//
//  TicketQueryViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketQueryViewController.h"
#import "PopoverView.h"
#define TQV_HEIGHT 44.0
@interface TicketQueryViewController ()
{
    NSDateFormatter *queryDateFormatter;
    
    UILabel *labelStartTime;
    UILabel *labelEndTime;
}
@end

@implementation TicketQueryViewController


-(id)init{
    self = [super init];
    queryDateFormatter = [[NSDateFormatter alloc] init];
    [queryDateFormatter setDateFormat:@"yyyy-MM-dd"];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect tRect = [UIScreen mainScreen].bounds;
    startPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, (tRect.size.height - 216)/2, tRect.size.width, 216)];
    startPicker.datePickerMode = UIDatePickerModeDate;
    [startPicker addTarget:self action:@selector(updateStart) forControlEvents:UIControlEventValueChanged];
    
    endPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, (tRect.size.height - 216)/2, 240, 216)];
    endPicker.datePickerMode = UIDatePickerModeDate;
    [endPicker addTarget:self action:@selector(updateEnd) forControlEvents:UIControlEventValueChanged];
    
}

-(void)updateStart{
    labelStartTime.text = [queryDateFormatter stringFromDate:startPicker.date];
}
-(void)updateEnd{
    [queryDateFormatter stringFromDate:startPicker.date];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"船票查询";
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
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"cell";
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    labelStartTime = cell.textLabel;
    cell.textLabel.text = [queryDateFormatter stringFromDate:[NSDate date]];;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TQV_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:startPicker];
}


@end
