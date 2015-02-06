//
//  TicketQueryViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketQueryViewController.h"
#import "PopoverView.h"
#import "PublicDefine.h"
#define TQV_HEIGHT 44.0
@interface TicketQueryViewController ()
{
    NSDateFormatter *queryDateFormatter;
    UILabel *labelOrigin;
    UILabel *labelStartTime;
    UILabel *labelEndTime;
    
    UISegmentedControl *segmentedControl;
    TicketQueryDirType *ticketQdt;
    
    UIPickerView *pickerSelectDest;//destination
    
    NSArray *orginArr;
}
@end

@implementation TicketQueryViewController
@synthesize tTableView;

-(id)init{
    self = [super init];
    queryDateFormatter = [[NSDateFormatter alloc] init];
    [queryDateFormatter setDateFormat:@"yyyy-MM-dd"];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ticketQdt = TICKET_QUERY_ONE;
    CGRect tRect = [UIScreen mainScreen].bounds;
    startPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, (tRect.size.height - 216)/2, tRect.size.width, 216)];
    startPicker.datePickerMode = UIDatePickerModeDate;
    [startPicker addTarget:self action:@selector(updateStart) forControlEvents:UIControlEventValueChanged];
    
    endPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, (tRect.size.height - 216)/2, 240, 216)];
    endPicker.datePickerMode = UIDatePickerModeDate;
    [endPicker addTarget:self action:@selector(updateEnd) forControlEvents:UIControlEventValueChanged];
    
    int itemWidth = 80;
    segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"单程",@"往返"]];
    segmentedControl.frame = CGRectMake((tRect.size.width - itemWidth*3)/2, 15, itemWidth*3, 30 );
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tRect.size.width, 60)];
    [headerView addSubview:segmentedControl];
    self.tTableView.tableHeaderView = headerView;
    
    orginArr = @[@"北京",@"上海",@"广州",@"深圳"];
    
    pickerSelectDest = [[UIPickerView alloc] initWithFrame:CGRectMake((tRect.size.width - 200)/2, (tRect.size.height - 200)/2, 200, 200)];//tRect.size.width
    pickerSelectDest.showsSelectionIndicator = YES;
    pickerSelectDest.delegate = self;
    pickerSelectDest.dataSource = self;
    
}


-(void)segmentedControlChange:(id)sender{
    NSLog(@"change value");
    UISegmentedControl *se = (UISegmentedControl*)sender;
    switch (se.selectedSegmentIndex) {
        case TICKET_QUERY_ONE:{
            
            break;
        }
        case TICKET_QUERY_RETURN:{
            
            break;
        }
        case 2:{
            
            break;
        }
        default:
            break;
    }
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
    return 2;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = [NSString stringWithFormat:@"cell_%d_%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (0 == indexPath.row) {
            labelOrigin = cell.textLabel;
        }else if(1 == indexPath.row){
            labelStartTime = cell.textLabel;
            cell.textLabel.text = [queryDateFormatter stringFromDate:[NSDate date]];
        }
    }
    
    
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
    if (0 == indexPath.row) {
        [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:pickerSelectDest];
        [pickerSelectDest reloadAllComponents];
        [pickerSelectDest selectRow:0 inComponent:0 animated:YES];
    }else if(1 == indexPath.row){
        [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:startPicker];
    }
    
}
#pragma mark - UIPickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [orginArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"didSelect");
    labelOrigin.text = [orginArr objectAtIndex:row];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return orginArr.count;
}


@end
