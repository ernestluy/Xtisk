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
#import "InfoViewController.h"
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
    
    NSArray *allLines;
    
    NSMutableArray *orginArr;
    NSMutableArray *destArr;
    
    NSArray *pickData;
    
    StationSelectType stationSelectType;
    TicketQueryDirType   ticketDirType;
    
    UIButton *btnAgreement;
    UIButton *btnOrder;
}

-(void)flushUI;
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
    segmentedControl.tintColor = _rgb2uic(0x0095f1, 1);
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tRect.size.width, 60)];
    [headerView addSubview:segmentedControl];
    self.tTableView.tableHeaderView = headerView;
    
    orginArr =  [NSMutableArray array];// @[@"北京",@"上海",@"广州",@"深圳"];
    destArr = [NSMutableArray array];//@[@"香港",@"澳门",@"台湾"];
    
    pickerSelectDest = [[UIPickerView alloc] initWithFrame:CGRectMake((tRect.size.width - 200)/2, (tRect.size.height - 200)/2, 200, 200)];//tRect.size.width
    pickerSelectDest.showsSelectionIndicator = YES;
    pickerSelectDest.delegate = self;
    pickerSelectDest.dataSource = self;
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 200)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    
    int btnHeight = 30;
    int btnWidth = 90;
    btnAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnAgreement setTitle:@"同意协议" forState:UIControlStateNormal];
    [btnAgreement setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateNormal];
    [btnAgreement setImage:[UIImage imageNamed:@"login_rmb_selected"] forState:UIControlStateSelected];
    [btnAgreement setImage:[UIImage imageNamed:@"login_rmb_no_selected"] forState:UIControlStateNormal];
    [btnAgreement addTarget:self action:@selector(btnAgreeAction:) forControlEvents:UIControlEventTouchUpInside];
//    btnAgreement.titleLabel.textAlignment = NSTextAlignmentRight;
//    btnAgreement.titleLabel.font = [UIFont systemFontOfSize:14];
//    btnAgreement.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -3);
//    btnAgreement.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    btnAgreement.backgroundColor = [UIColor clearColor];
    [footView addSubview:btnAgreement];
    btnAgreement.frame = CGRectMake(15, 10, btnHeight, btnHeight);
    btnAgreement.selected = YES;
    
    UIButton * btnToNotice = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnToNotice setTitle:@"阅读并同意《购票须知》的条款" forState:UIControlStateNormal];
    [btnToNotice setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateNormal];
    [btnToNotice addTarget:self action:@selector(toNotice) forControlEvents:UIControlEventTouchUpInside];
    btnToNotice.titleLabel.textAlignment = NSTextAlignmentLeft;
    btnToNotice.titleLabel.font = [UIFont systemFontOfSize:14];
    btnToNotice.backgroundColor = [UIColor clearColor];
    [footView addSubview:btnToNotice];
    btnToNotice.frame = CGRectMake(15 + btnHeight +5, 10, 200, btnHeight);
    
    
    int startX = 15;
    CGRect ttr = CGRectMake(startX, 20 + 40, bounds.size.width - 15*2, 44);
    btnOrder = [CTLCustom getTableViewLastButton:ttr];
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"查 询" forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(submitQuery:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    UILabel *labNote = [[UILabel alloc]initWithFrame:CGRectMake(startX, 80 + 40, ttr.size.width, 40)];
    labNote.textColor = defaultTextGrayColor;
    labNote.font = [UIFont systemFontOfSize:13];
    labNote.text = @"温馨提示:所有航线售票截止时间为开船时间前一天，只可以购买15天以内的船票";
    labNote.numberOfLines = 0 ;
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    [footView addSubview:labNote];
    
    tRect = CGRectMake(0, 0, 140, TQV_HEIGHT);
    btnOriginStation = [CTLCustom getButtonNormalWithRect:tRect];
    btnOriginStation.titleLabel.font = DefaultCellFont;
    btnOriginStation.tag = StationOrigin;
    tRect = CGRectMake(bounds.size.width - 140, 0, 140, TQV_HEIGHT);
    btnDestStation = [CTLCustom getButtonNormalWithRect:tRect];
    btnDestStation.titleLabel.font = DefaultCellFont;
    btnDestStation.tag = StationDest;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"船票查询";
    if (![TicketSerivice sharedInstance].allShipLines) {
        [[[HttpService sharedInstance] getRequestQueryShipLine:self]startAsynchronous];
    }else{
        allLines = [TicketSerivice sharedInstance].allShipLines;
    }
    [self flushUI];
}

-(void)btnAgreeAction:(id)sender{
    BOOL b = btnAgreement.selected;
    btnAgreement.selected = !b;
    if (btnAgreement.selected) {
        btnOrder.enabled = YES;
        btnOrder.alpha = 1.0;
    }else{
        btnOrder.enabled = NO;
        btnOrder.alpha = 0.6;
    }
}

-(void)toNotice{
    btnAgreement.selected = NO;
    [self btnAgreeAction:nil];
    InfoViewController *iv = [[InfoViewController alloc]initWithLocalUrl:@"ticket_warning.html" title:@"蛇口购票须知"];
    [self.navigationController pushViewController:iv animated:YES];
}
-(void)setOriginStationTitle:(NSString *)str{
    [btnOriginStation setTitle:str forState:UIControlStateNormal];
}

-(void)setDestStationTitle:(NSString *)str{
    [btnDestStation setTitle:str forState:UIControlStateNormal];
}
/*
 {
 "FROMPORTENAME": "She Kou",
 "FROMPORTCODE": "SK",
 "ISAIRPORTLINE": "0",
 "TOPORTCODE": "HKM",
 "TOPORTENAME": "HK-Macau Ferry Terminal",
 "TOPORTCNAME": "香港港澳码头",
 "FROMPORTTNAME": "蛇口港",
 "LINECODE": "SK-HKM",
 "TOPORTTNAME": "港澳碼頭",
 "FROMPORTCNAME": "蛇口港"
 }
 */


-(void)flushUI{

    for (int i = 0; i<allLines.count; i++) {
        ShipLineItem *line = [allLines objectAtIndex:i];
        if ([line.LINECODE isEqualToString:@"SK-HKM"]) {
            [self setOriginStationTitle:line.FROMPORTCNAME];
            [self setDestStationTitle:line.TOPORTCNAME];
        }
    }
}

-(void)submitQuery:(id)sender{
    NSLog(@"submitQuery");
    [TicketSerivice sharedInstance].ticketQueryType = ticketDirType;
    if (btnOriginStation.titleLabel.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"始发站没有设置" duration:1.5];
        return;
    }
    
    if (btnDestStation.titleLabel.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"终点站没有设置" duration:1.5];
        return;
    }
    
    for (int i = 0; i<allLines.count; i++) {
        ShipLineItem *item = [allLines objectAtIndex:i];
        if ([item.FROMPORTCNAME isEqualToString:btnOriginStation.titleLabel.text] &&
            [item.TOPORTCNAME isEqualToString:btnDestStation.titleLabel.text]) {
            [TicketSerivice sharedInstance].tLine = item;
            
            [TicketSerivice sharedInstance].fromPort = item.FROMPORTCODE;
            [TicketSerivice sharedInstance].toPort = item.TOPORTCODE;
            
            break;
        }
    }
    
//    [TicketSerivice sharedInstance].fromPort = btnOriginStation.titleLabel.text;
//    [TicketSerivice sharedInstance].toPort = btnDestStation.titleLabel.text;
    
    [TicketSerivice sharedInstance].fromDate = labelStartTime.text;
    [TicketSerivice sharedInstance].returnDate = labelEndTime.text;
    
    
    
    
    TicketQueryListViewController *tl = [[TicketQueryListViewController alloc]init];
    tl.tStep = TicketVoyageStepFirst;
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
    labelEndTime.text = [queryDateFormatter stringFromDate:endPicker.date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)stationSelectAction:(UIButton *)btn{
    stationSelectType = (int)btn.tag;
    switch (btn.tag) {
        case StationOrigin:{
            
            [orginArr removeAllObjects];
            [destArr removeAllObjects];
            int tSelectIndex = 0;
            for (int i = 0; i<allLines.count; i++) {
                ShipLineItem *line = [allLines objectAtIndex:i];
                if ([orginArr containsObject:line.FROMPORTCNAME ]) {
                    continue;
                }
                [orginArr addObject:line.FROMPORTCNAME];
            }
            for (int i = 0; i<orginArr.count; i++) {
                NSString *tmpStr = [orginArr objectAtIndex:i];
                //判断当前选择是第几项
                if ([btnOriginStation.titleLabel.text isEqualToString:tmpStr]) {
                    NSLog(@"位置:%d",i);
                    tSelectIndex = i;
                    break;
                }
            }
            
            
            pickData = orginArr;
            [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:pickerSelectDest];
            [pickerSelectDest reloadAllComponents];
            [pickerSelectDest selectRow:tSelectIndex inComponent:0 animated:YES];
            break;
        }
        case StationDest:{
            
            int tSelectIndex = 0;
            [destArr removeAllObjects];
            for (int i = 0; i<allLines.count; i++) {
                ShipLineItem *line = [allLines objectAtIndex:i];
                if ([line.FROMPORTCNAME isEqualToString:btnOriginStation.titleLabel.text]) {
                    [destArr addObject:line.TOPORTCNAME];
                }
                
            }
            
            BOOL isContant = NO;
            for (int i = 0; i<destArr.count; i++) {
                NSString *destStr = [destArr objectAtIndex:i];
                //判断当前选择是第几项
                if ([destStr isEqualToString:btnDestStation.titleLabel.text]) {
                    NSLog(@"位置:%d",i);
                    tSelectIndex = i;
                    isContant = YES;
                    break;
                }
            }
            
            
            //如果不包含
            if (!isContant) {
                tSelectIndex = 0;
                if (destArr.count>0) {
                    [self setDestStationTitle:[destArr objectAtIndex:0]];
                }
                
            }
            
            
            pickData = destArr;
            [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:pickerSelectDest];
            [pickerSelectDest reloadAllComponents];
            [pickerSelectDest selectRow:tSelectIndex inComponent:0 animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (TICKET_QUERY_ONE == ticketDirType) {
        return 1;
    }else if (TICKET_QUERY_RETURN == ticketDirType) {
        return 2;
    }
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 3;
    if (TICKET_QUERY_ONE == ticketDirType) {
        return 2;
    }else if (TICKET_QUERY_RETURN == ticketDirType) {
        if (0 == section) {
            return 2;
        }else{
            return 1;
        }
    }
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = [NSString stringWithFormat:@"cell_%d_%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = defaultTextColor;
        if (0 == indexPath.section && 0 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:btnOriginStation];
            
            [cell addSubview:btnDestStation];
            
            [btnOriginStation addTarget:self action:@selector(stationSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnDestStation addTarget:self action:@selector(stationSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 30, 30)];
            imgView.image = [UIImage imageNamed:@"ticket_switch"];
            imgView.center = CGPointMake(cell.bounds.size.width/2, cell.bounds.size.height/2);
            [cell addSubview:imgView];
            
        }else if(0 == indexPath.section && 1 == indexPath.row){
            CGRect tRect = CGRectMake(20, 0,200, TQV_HEIGHT);
            labelStartTime = [[UILabel alloc]initWithFrame:tRect];
            labelStartTime.textAlignment = NSTextAlignmentLeft;
            labelStartTime.textColor = defaultTextColor;
            labelStartTime.text = [queryDateFormatter stringFromDate:[NSDate date]];
            [cell addSubview:labelStartTime];
        }else if(1 == indexPath.section && 0 == indexPath.row){
            CGRect tRect = CGRectMake(20, 0, 200, TQV_HEIGHT);
            labelEndTime = [[UILabel alloc]initWithFrame:tRect];
            labelEndTime.textAlignment = NSTextAlignmentLeft;
            labelEndTime.textColor = defaultTextColor;
//            UIFont *font = cell.textLabel.font;
            labelEndTime.text = [queryDateFormatter stringFromDate:[NSDate date]];
            [cell addSubview:labelEndTime];
        }
    }
    
    
    if(1 == indexPath.section && 0 == indexPath.row){
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (ticketDirType == TICKET_QUERY_ONE) {
        return @"";
    }
    if (0 == section) {
        return @"启程";
    }else if (1 == section){
        return @"返程";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TQV_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            if (0 == indexPath.row) {
                
            }else if(1 == indexPath.row){
                [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:startPicker];
            }
            break;
        }
        case 1:{
            if(0 == indexPath.row){
                [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:endPicker];
            }
            break;
        }
        default:
            break;
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
        
        [destArr removeAllObjects];
        for (int i = 0; i<allLines.count; i++) {
            ShipLineItem *line = [allLines objectAtIndex:i];
            if ([line.FROMPORTCNAME isEqualToString:btnOriginStation.titleLabel.text]) {
                [destArr addObject:line.TOPORTCNAME];
            }
            
        }
        
        BOOL isContant = NO;
        for (int i = 0; i<destArr.count; i++) {
            NSString *destStr = [destArr objectAtIndex:i];
            //判断当前选择是第几项
            if ([destStr isEqualToString:btnDestStation.titleLabel.text]) {
                NSLog(@"包含该目的地:%@",destStr);
                isContant = YES;
                break;
            }
        }
        
        //如果不包含
        if (!isContant) {NSLog(@"不包含该目的地，设置为第一项");
            if (destArr.count>0) {
                [self setDestStationTitle:[destArr objectAtIndex:0]];
            }
        }

        
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



#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
            
        case HttpRequestType_XT_UPDATEACTIVITYJOININFO:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    [SVProgressHUD showErrorWithStatus:@"修改报名信息成功" duration:DefaultRequestDonePromptTime];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERY_SHIP_LINE:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        allLines = [ShipLineItem getShipLineItemsWithArr:[dic objectForKey:@"shipLineList"]];
                        [TicketSerivice sharedInstance].allShipLines = allLines;
                        [self flushUI];
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        default:
            break;
    }
}


@end
