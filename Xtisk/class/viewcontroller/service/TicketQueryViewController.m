//
//  TicketQueryViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketQueryViewController.h"
#import "PopoverView.h"
#import "PublicDefine.h"
#import "TicketQueryListViewController.h"
#define TQV_HEIGHT 44.0
@interface TicketQueryViewController ()
{
    NSDateFormatter *queryDateFormatter;
    UILabel *labelStartTime;
    UILabel *labelEndTime;
    
    UIButton *btnOriginStation;
    UIButton *btnDestStation;
    
    UISegmentedControl *segmentedControl;
    TicketQueryDirType *ticketQdt;
    
    UIPickerView *pickerSelectDest;//destination
    
    NSArray *orginArr;
    NSArray *destArr;
    
    NSArray *pickData;
    
    StationSelectType stationSelectType;
    TicketQueryDirType   ticketDirType;
}
-(void)stationSelectAction:(UIButton *)btn;
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
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
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
    destArr = @[@"香港",@"澳门",@"台湾"];
    
    pickerSelectDest = [[UIPickerView alloc] initWithFrame:CGRectMake((tRect.size.width - 200)/2, (tRect.size.height - 200)/2, 200, 200)];//tRect.size.width
    pickerSelectDest.showsSelectionIndicator = YES;
    pickerSelectDest.delegate = self;
    pickerSelectDest.dataSource = self;
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 200)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    int startX = 15;
    CGRect ttr = CGRectMake(startX, 20, bounds.size.width - 15*2, 44);
    UIButton *btnOrder = [CTLCustom getTableViewLastButton:ttr];
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"查 询" forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(submitQuery:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    UILabel *labNote = [[UILabel alloc]initWithFrame:CGRectMake(startX, 70, ttr.size.width, 40)];
    labNote.textColor = defaultTextGrayColor;
    labNote.font = [UIFont systemFontOfSize:13];
    labNote.text = @"温馨提示:所有航线售票截止时间为开船时间前一天，只可以购买15天以内的船票";
    labNote.numberOfLines = 0 ;
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    [footView addSubview:labNote];
}

-(void)submitQuery:(id)sender{
    NSLog(@"submitQuery");
    TicketQueryListViewController *tl = [[TicketQueryListViewController alloc]init];
    [self.navigationController pushViewController:tl animated:YES];
}

-(void)segmentedControlChange:(id)sender{
    NSLog(@"change value");
    UISegmentedControl *se = (UISegmentedControl*)sender;
    ticketDirType = (int)se.selectedSegmentIndex;
    switch (se.selectedSegmentIndex) {
        case TICKET_QUERY_ONE:{
            [tTableView reloadData];
            break;
        }
        case TICKET_QUERY_RETURN:{
            [tTableView reloadData];
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
    labelEndTime.text = [queryDateFormatter stringFromDate:startPicker.date];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"船票查询";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)stationSelectAction:(UIButton *)btn{
    stationSelectType = (int)btn.tag;
    switch (btn.tag) {
        case StationOrigin:{
            pickData = orginArr;
            [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:pickerSelectDest];
            [pickerSelectDest reloadAllComponents];
            [pickerSelectDest selectRow:0 inComponent:0 animated:YES];
            break;
        }
        case StationDest:{
            pickData = destArr;
            [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:pickerSelectDest];
            [pickerSelectDest reloadAllComponents];
            [pickerSelectDest selectRow:0 inComponent:0 animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 3;
    if (TICKET_QUERY_ONE == ticketDirType) {
        return 2;
    }else if (TICKET_QUERY_RETURN == ticketDirType) {
        return 3;
    }
    return 2;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = [NSString stringWithFormat:@"cell_%d_%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = defaultTextColor;
        if (0 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CGRect bounds = [UIScreen mainScreen].bounds;
            CGRect tRect = CGRectMake(0, 0, 110, TQV_HEIGHT);
            btnOriginStation = [CTLCustom getButtonNormalWithRect:tRect];
            [btnOriginStation setTitle:[orginArr objectAtIndex:0] forState:UIControlStateNormal];
            btnOriginStation.tag = StationOrigin;
            [cell addSubview:btnOriginStation];
            tRect = CGRectMake(bounds.size.width - 110, 0, 110, TQV_HEIGHT);
            btnDestStation = [CTLCustom getButtonNormalWithRect:tRect];
            [btnDestStation setTitle:[destArr objectAtIndex:0] forState:UIControlStateNormal];
            btnDestStation.tag = StationDest;
            [cell addSubview:btnDestStation];
            
            [btnOriginStation addTarget:self action:@selector(stationSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnDestStation addTarget:self action:@selector(stationSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if(1 == indexPath.row){
            cell.textLabel.text = @"出发:";
            CGRect tRect = CGRectMake(60, 0, 170, TQV_HEIGHT);
            labelStartTime = [[UILabel alloc]initWithFrame:tRect];
            labelStartTime.textAlignment = NSTextAlignmentLeft;
            labelStartTime.textColor = defaultTextColor;
            labelStartTime.text = [queryDateFormatter stringFromDate:[NSDate date]];
            [cell addSubview:labelStartTime];
        }else if(2 == indexPath.row){
            cell.textLabel.text = @"返回:";
            CGRect tRect = CGRectMake(60, 0, 170, TQV_HEIGHT);
            labelEndTime = [[UILabel alloc]initWithFrame:tRect];
            labelEndTime.textAlignment = NSTextAlignmentLeft;
            labelEndTime.textColor = defaultTextColor;
//            UIFont *font = cell.textLabel.font;
            labelEndTime.text = [queryDateFormatter stringFromDate:[NSDate date]];
            [cell addSubview:labelEndTime];
        }
    }
    
    
    if(2 == indexPath.row){
        NSDate *fDate = [queryDateFormatter dateFromString:labelStartTime.text];
        NSDate *bDate = [queryDateFormatter dateFromString:labelEndTime.text];
        NSComparisonResult r = [fDate compare:bDate];
        if (NSOrderedDescending == r) {
            //前往时间较大，要修改返程时间
            labelEndTime.text = labelStartTime.text;
        }else if (NSOrderedAscending == r){
             //时间顺序对，不做修改
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        
    }else if(1 == indexPath.row){
        [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:startPicker];
    }else if(2 == indexPath.row){
        [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:endPicker];
    }
    
}
#pragma mark - UIPickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"didSelect");
//    labOriginStation.text = [orginArr objectAtIndex:row];
    if (StationOrigin == stationSelectType) {
        [btnOriginStation setTitle:[pickData objectAtIndex:row] forState:UIControlStateNormal];
    }else if (StationDest == stationSelectType){
        [btnDestStation setTitle:[pickData objectAtIndex:row] forState:UIControlStateNormal];
    }
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickData.count;
}


@end
