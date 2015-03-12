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
#import "TicketNumsEdit1TableViewCell.h"
#import "TicketNumsEdit2TableViewCell.h"
#import "PopoverView.h"
#define kTicketVoyageTableViewCell1 @"kTicketVoyageTableViewCell1"
#define kTicketVoyageTableViewCell2 @"kTicketVoyageTableViewCell2"

@interface TicketVoyageEditViewController ()
{
    UITableView *tTableView;
    
    UIButton *btnOrder;
    UIButton *btnSeatLevel;
    
    
    int seatLevelIndex;
    
    UILabel *labSeatLevel1;
    UILabel *labSeatLevel2;
    UILabel *labSeatLevel3;
    
    UIPickerView *pickerSelectSeatLevel;
    
    UILabel *labTotalPrice;
    
    float fTotalPrice;
    
    NSArray *pickData;
    
    NSMutableArray *mArrStatis;
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
//    tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tTableView registerNib:[UINib nibWithNibName:@"TicketNumsEdit1TableViewCell" bundle:nil] forCellReuseIdentifier:kTicketVoyageTableViewCell1];
    [tTableView registerNib:[UINib nibWithNibName:@"TicketNumsEdit2TableViewCell" bundle:nil] forCellReuseIdentifier:kTicketVoyageTableViewCell2];
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellDefault];
    
    seatLevelIndex = 0;
    fTotalPrice = 0;
    mArrStatis = [NSMutableArray array];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 260)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    
    
    int startX = 15;
    CGRect ttr = CGRectMake(startX, 20 , bounds.size.width - 15*2, 44);
    btnOrder = [CTLCustom getTableViewLastButton:ttr];
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"确定" forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(toNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    UILabel *labNote = [[UILabel alloc]initWithFrame:CGRectMake(startX, 70 , ttr.size.width, 130)];
    labNote.textColor = defaultTextGrayColor;
//    labNote.backgroundColor = [UIColor yellowColor];
    labNote.font = [UIFont systemFontOfSize:13];
    labNote.text = @"温馨提示:\n1.儿童过1.2米但不超过1.5米，需购买小童票；超过1.5米者，应购买全票。每位成人旅客可免费携身高不超过1.2米的儿童一人，超过一人时应按照超过人数购买小童票。\n2.长者（65岁或以上），需购买长者票，取票时必须出示本人身份证。";
    labNote.numberOfLines = 0 ;
    labNote.lineBreakMode = NSLineBreakByWordWrapping;
    [footView addSubview:labNote];
    
    btnSeatLevel = [CTLCustom getButtonRightArrowDownWithRect:CGRectMake(100, 0, 120, 44)];
    
    labTotalPrice = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 160, 44)];
    labTotalPrice.text = [NSString stringWithFormat:@"￥%0.1f",fTotalPrice];
    labTotalPrice.font = [UIFont systemFontOfSize:20];
    labTotalPrice.textAlignment = NSTextAlignmentCenter;
    
    pickerSelectSeatLevel = [[UIPickerView alloc] initWithFrame:CGRectMake((bounds.size.width - 200)/2, (bounds.size.height - 200)/2, 200, 200)];//tRect.size.width
    pickerSelectSeatLevel.showsSelectionIndicator = YES;
    pickerSelectSeatLevel.delegate = self;
    pickerSelectSeatLevel.dataSource = self;
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
            [TicketSerivice sharedInstance].toVoyageItem =self.mVoyageItem;
            TicketQueryListViewController *tvv = [[TicketQueryListViewController alloc] init];
            tvv.tStep = TicketVoyageStepSecond;
            [self.navigationController pushViewController:tvv animated:YES];
        }else if(TicketVoyageStepSecond == tStep){
            NSLog(@"进入订单详情，准备付费");
            [TicketSerivice sharedInstance].returnVoyageItem =self.mVoyageItem;
            TicketOrderEditViewController *to = [[TicketOrderEditViewController alloc] init];
            [self.navigationController pushViewController:to animated:YES];
        }
        
    }else if (TICKET_QUERY_ONE == [TicketSerivice sharedInstance].ticketQueryType){
        NSLog(@"进入订单详情，准备付费");
        TicketOrderEditViewController *to = [[TicketOrderEditViewController alloc] init];
        [TicketSerivice sharedInstance].toVoyageItem =self.mVoyageItem;
        [self.navigationController pushViewController:to animated:YES];
    }
    
    
}

-(void)calTotalPrice{
    fTotalPrice = 0;
    [mArrStatis removeAllObjects];
    for (int i = 0; i<self.mVoyageItem.DTSEATRANKPRICE.count; i++) {
        SeatRankPrice *tmpSeat = [self.mVoyageItem.DTSEATRANKPRICE objectAtIndex:i];
        fTotalPrice += [tmpSeat.PRICE1 floatValue] * tmpSeat.orderNum1;
        fTotalPrice += [tmpSeat.PRICE2 floatValue] * tmpSeat.orderNum2;
        fTotalPrice += [tmpSeat.PRICE3 floatValue] * tmpSeat.orderNum3;
        
        
        
        if (tmpSeat.orderNum1 >0) {
            NSMutableArray *tmpMArr = [NSMutableArray array];
            [tmpMArr addObject:tmpSeat.SEATRANK];
            [tmpMArr addObject:@"成人"];
            [tmpMArr addObject:[NSString stringWithFormat:@"%d张",tmpSeat.orderNum1]];
            NSString *strPrice = [NSString stringWithFormat:@"￥%0.1f",[tmpSeat.PRICE1 floatValue] * tmpSeat.orderNum1];
            [tmpMArr addObject:strPrice];
            [mArrStatis addObject:tmpMArr];
        }
        if (tmpSeat.orderNum2 >0) {
            NSMutableArray *tmpMArr = [NSMutableArray array];
            [tmpMArr addObject:tmpSeat.SEATRANK];
            [tmpMArr addObject:@"长者"];
            [tmpMArr addObject:[NSString stringWithFormat:@"%d张",tmpSeat.orderNum2]];
            NSString *strPrice = [NSString stringWithFormat:@"￥%0.1f",[tmpSeat.PRICE2 floatValue] * tmpSeat.orderNum2];
            [tmpMArr addObject:strPrice];
            [mArrStatis addObject:tmpMArr];
        }
        if (tmpSeat.orderNum3 >0) {
            NSMutableArray *tmpMArr = [NSMutableArray array];
            [tmpMArr addObject:tmpSeat.SEATRANK];
            [tmpMArr addObject:@"小童"];
            [tmpMArr addObject:[NSString stringWithFormat:@"%d张",tmpSeat.orderNum3]];
            NSString *strPrice = [NSString stringWithFormat:@"￥%0.1f",[tmpSeat.PRICE3 floatValue] * tmpSeat.orderNum3];
            [tmpMArr addObject:strPrice];
            [mArrStatis addObject:tmpMArr];
        }
    }
    
    
    
    labTotalPrice.text = [NSString stringWithFormat:@"￥%0.1f",fTotalPrice];
    
    
    
    
    [tTableView reloadData];
}

-(void)changeSeatLevel:(id)sender{
    NSLog(@"changeSeatLevel");
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<self.mVoyageItem.DTSEATRANKPRICE.count; i++) {
        SeatRankPrice*tmpSeat = [self.mVoyageItem.DTSEATRANKPRICE objectAtIndex:i];
        [mArr addObject:tmpSeat.SEATRANK];
    }
    pickData = mArr;
    [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:pickerSelectSeatLevel];
    [pickerSelectSeatLevel reloadAllComponents];
}

-(void)ticketNumAdd:(UIButton *)btn{
    NSLog(@"ticketNumAdd");
    SeatRankPrice *seat = [self.mVoyageItem.DTSEATRANKPRICE objectAtIndex:seatLevelIndex];
    switch (btn.tag) {
        case 0:{
            
            labSeatLevel1.text = [NSString stringWithFormat:@"%d",[labSeatLevel1.text intValue]+1];
            seat.orderNum1 = [labSeatLevel1.text intValue];
            break;
        }
        case 1:{
            
            labSeatLevel2.text = [NSString stringWithFormat:@"%d",[labSeatLevel2.text intValue]+1];
            seat.orderNum2 = [labSeatLevel2.text intValue];
            break;
        }
        case 2:{
            
            labSeatLevel3.text = [NSString stringWithFormat:@"%d",[labSeatLevel3.text intValue]+1];
            seat.orderNum3 = [labSeatLevel3.text intValue];
            break;
        }
        default:
            break;
    }
    
    
    [self calTotalPrice];
}

-(void)ticketNumDel:(UIButton *)btn{
    NSLog(@"ticketNumDel");
    SeatRankPrice *seat = [self.mVoyageItem.DTSEATRANKPRICE objectAtIndex:seatLevelIndex];
    switch (btn.tag) {
        case 0:{
            if ([labSeatLevel1.text intValue] == 0) {
                return;
            }
            labSeatLevel1.text = [NSString stringWithFormat:@"%d",[labSeatLevel1.text intValue]-1];
            seat.orderNum1 = [labSeatLevel1.text intValue];
            break;
        }
        case 1:{
            if ([labSeatLevel2.text intValue] == 0) {
                return;
            }
            labSeatLevel2.text = [NSString stringWithFormat:@"%d",[labSeatLevel2.text intValue]-1];
            seat.orderNum2 = [labSeatLevel2.text intValue];
            break;
        }
        case 2:{
            if ([labSeatLevel3.text intValue] == 0) {
                return;
            }
            labSeatLevel3.text = [NSString stringWithFormat:@"%d",[labSeatLevel3.text intValue]-1];
            seat.orderNum3 = [labSeatLevel3.text intValue];
            break;
        }
        default:
            break;
    }
    [self calTotalPrice];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if(1 == section){
        return 3;
    }else if(2 == section){
        return mArrStatis.count;
    }else if(3 == section){
        return 1;
    }
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell1];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"index:%d%d",(int)indexPath.section,(int)indexPath.row];
    NSString*strIdentifier = [NSString stringWithFormat:@"cell_%d_%d",(int)indexPath.section,(int)indexPath.row];
    switch (indexPath.section) {
        case 0:{
            if (0 == indexPath.row) {
                
                UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:strIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (cell ==nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
                    cell.textLabel.textColor = defaultTextColor;
                }
                cell.textLabel.text = @"座位等级";
                cell.textLabel.textColor = defaultTextGrayColor;
                cell.textLabel.font = DefaultCellFont;
                
                SeatRankPrice *seat = [self.mVoyageItem.DTSEATRANKPRICE objectAtIndex:seatLevelIndex];
                [cell addSubview:btnSeatLevel];
                [btnSeatLevel setTitle:seat.SEATRANK forState:UIControlStateNormal];
                [btnSeatLevel addTarget:self action:@selector(changeSeatLevel:) forControlEvents:
                 UIControlEventTouchUpInside];
                btnSeatLevel.titleLabel.font = DefaultCellFont;
                [btnSeatLevel setTitleColor:headerColor forState:UIControlStateNormal];
                
                return cell;
            }
            break;
        }
        case 1:{
            TicketNumsEdit1TableViewCell * cell = (TicketNumsEdit1TableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.labTicketType.text = [@[@"成人",@"长者",@"小童"] objectAtIndex:indexPath.row];
            SeatRankPrice *seat = [self.mVoyageItem.DTSEATRANKPRICE objectAtIndex:seatLevelIndex];
            [cell.btnAdd addTarget:self action:@selector(ticketNumAdd:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnDel addTarget:self action:@selector(ticketNumDel:) forControlEvents:UIControlEventTouchUpInside];
            
            if (0 == indexPath.row) {
                cell.labTicketPrice.text = seat.PRICE1;
                labSeatLevel1 = cell.labTicketNum;
                cell.btnAdd.tag = indexPath.row;
                cell.btnDel.tag = indexPath.row;
                labSeatLevel1.text = [NSString stringWithFormat:@"%d",seat.orderNum1];
            }else if (1 == indexPath.row) {
                cell.labTicketPrice.text = seat.PRICE2;
                labSeatLevel2 = cell.labTicketNum;
                cell.btnAdd.tag = indexPath.row;
                cell.btnDel.tag = indexPath.row;
                labSeatLevel2.text = [NSString stringWithFormat:@"%d",seat.orderNum2];
            }else if (2 == indexPath.row) {
                cell.labTicketPrice.text = seat.PRICE3;
                labSeatLevel3 = cell.labTicketNum;
                cell.btnAdd.tag = indexPath.row;
                cell.btnDel.tag = indexPath.row;
                labSeatLevel3.text = [NSString stringWithFormat:@"%d",seat.orderNum3];
            }
            
            if (self.mVoyageItem.mArrTicketNums.count>seatLevelIndex ) {
                if ([[self.mVoyageItem.mArrTicketNums objectAtIndex:seatLevelIndex] intValue] == 0) {
                    cell.btnAdd.enabled = NO;
                    cell.btnDel.enabled = NO;
                }else{
                    cell.btnAdd.enabled = YES;
                    cell.btnDel.enabled = YES;
                }
            }else{
                cell.btnAdd.enabled = NO;
                cell.btnDel.enabled = NO;
            }
            
            return cell;
            break;
        }
        case 2:{
            TicketNumsEdit2TableViewCell * cell = (TicketNumsEdit2TableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketVoyageTableViewCell2];
            NSArray *tmpArr = [mArrStatis objectAtIndex:indexPath.row];
            [cell setDataArr:tmpArr];
            
            return cell;
            break;
        }
        case 3:{
            UITableViewCell * cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:strIdentifier];
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if(0 == indexPath.row){
                    cell.textLabel.text = @"合计";
                    cell.textLabel.font = DefaultCellFont;
                    
                    
                    [cell addSubview:labTotalPrice];
                    labTotalPrice.textColor = [UIColor redColor];
                }
            }

            return cell;
            break;
        }
        default:
            break;
    }
    return [tv dequeueReusableCellWithIdentifier:kCellDefault];;
    
    
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 30)];
        for (int i = 0; i<3; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100*i, 0, 100, 30)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = [@[@"票类",@"价格",@"数量"] objectAtIndex:i];
            lab.textAlignment = NSTextAlignmentCenter;
            [tView addSubview:lab];
        }
        return tView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0.2;
    }else if(1 == section){
        return 30;
    }else if(2 == section){
        return 8;
    }else if(3 == section){
        return 8;
    }
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DEFAULT_CELL_HEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
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
    seatLevelIndex = (int)row;
    [tTableView reloadData];
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
            
        case HttpRequestType_XT_QUERY_VOYAGE:{
            
            break;
        }
        default:
            break;
    }
}

@end
