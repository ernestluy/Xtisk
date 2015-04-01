//
//  TicketQueryListViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/3/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketQueryListViewController.h"
#import "PublicDefine.h"
#import "TicketListTableViewCell.h"
#import "TicketVoyageEditViewController.h"

#define kTicketListTableViewCell @"kTicketListTableViewCell"
#define TicketListCellHeight 50.0
@interface TicketQueryListViewController ()
{
    NSMutableArray *btnArr;
    int selectedIndex;
    
    UITableView *tTableView;
    
    NSArray *voyageLines;
    
    UIActivityIndicatorView *acView;
    
    UIButton *btnDate;
    UIButton *btnLast;
    UIButton *btnNext;
    
    UILabel *labNoteNoData;
}
@end

@implementation TicketQueryListViewController
@synthesize tStep;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"航班信息";
    self.view.backgroundColor = [UIColor whiteColor];
    btnArr = [[NSMutableArray alloc]init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    NSArray *btnTitleArr = @[@"前一天",@"10月25日",@"后一天"];
    int btnW = bounds.size.width / btnTitleArr.count;
    int btnH = TicketListCellHeight;
//    int lineHeight = 20;
    for (int i = 0; i<btnTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        if (0 == i) {
            btnLast = btn;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(getLineInfo:) forControlEvents:UIControlEventTouchUpInside];
        }else if (1 == i){
            btnDate = btn;
            [btn setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateNormal];
        }else if (2 == i){
            btnNext = btn;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(getLineInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:btn];
        btn.tag = i;
        
        if (i == 0) {
            btn.selected = YES;
        }
        if (i !=0) {
            CGRect tmpR  = CGRectMake(i*btnW,0 , 1, btnH);//(btnH - lineHeight)/2
            UIImageView *iv = [[UIImageView alloc]initWithFrame:tmpR];
            iv.image = [UIImage imageNamed:@"line_gray.png"];
            [self.view addSubview:iv];
        }
        [btnArr addObject:btn];
    }
    selectedIndex = 0;
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, btnH - 1, bounds.size.width, 1)];
    iv.image = [UIImage imageNamed:@"line_gray"];
    [self.view addSubview:iv];
    
    
    CGRect tableRect = CGRectMake(0, btnH, bounds.size.width, bounds.size.height - 64 - btnH) ;
    tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStylePlain];
    [self.view addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tTableView registerNib:[UINib nibWithNibName:@"TicketListTableViewCell" bundle:nil] forCellReuseIdentifier:kTicketListTableViewCell];
    
    [[btnArr objectAtIndex:1] setTitle:[TicketSerivice sharedInstance].fromDate forState:UIControlStateNormal];
    
    acView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    acView.color = headerColor;
    UIBarButtonItem *waitViewItem = [[UIBarButtonItem alloc] initWithCustomView:acView] ;
    
    [self.navigationItem setRightBarButtonItems:@[waitViewItem]];
    
    if (tStep == TicketVoyageStepFirst) {
        [btnDate setTitle:[TicketSerivice sharedInstance].fromDate forState:UIControlStateNormal];
    }else if(tStep == TicketVoyageStepSecond){
        [btnDate setTitle:[TicketSerivice sharedInstance].returnDate forState:UIControlStateNormal];
    }
    
    
    labNoteNoData = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    labNoteNoData.text = @"暂无数据";
    labNoteNoData.font = [UIFont systemFontOfSize:14];
    labNoteNoData.textColor = defaultTextColor;
    labNoteNoData.textAlignment = NSTextAlignmentCenter;
}

-(void)requestData{
    
    [acView startAnimating];
    btnLast.enabled = NO;
    btnNext.enabled = NO;
    
    
    TicketSerivice *tSerivice = [TicketSerivice sharedInstance];
    VoyageRequestPar *vrp = [[VoyageRequestPar alloc]init];
    if (tStep == TicketVoyageStepFirst) {
        vrp.sailDate = tSerivice.fromDate;
        vrp.fromPortCode = tSerivice.fromPort;
        vrp.toPortCode = tSerivice.toPort;
    }else if(tStep == TicketVoyageStepSecond){
        vrp.sailDate = tSerivice.returnDate;
        vrp.fromPortCode = tSerivice.toPort;
        vrp.toPortCode = tSerivice.fromPort;
    }
//    vrp.sailDate = tSerivice.fromDate;
//    vrp.fromPortCode = tSerivice.fromPort;
//    vrp.toPortCode = tSerivice.toPort;
    
    [[[HttpService sharedInstance] getRequestQueryVoyage:self info:vrp]startAsynchronous];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (TICKET_QUERY_RETURN == [TicketSerivice sharedInstance].ticketQueryType) {
        if (TicketVoyageStepFirst == tStep) {
            self.title = @"航班信息-启程";
        }else if(TicketVoyageStepSecond == tStep){
            self.title = @"航班信息-返程";
        }
        
    }else if (TICKET_QUERY_ONE == [TicketSerivice sharedInstance].ticketQueryType){
        self.title = @"航班信息";
    }
    
    if (!isRequestSucMark) {
        [self requestData];
    }
}

-(void)flushUI{
    
    if (voyageLines.count == 0) {
        tTableView.tableFooterView = labNoteNoData;
    }else{
        tTableView.tableFooterView = nil;
    }
    [tTableView reloadData];
}

-(void)getLineInfo:(UIButton *)btn{
    NSLog(@"getLineInfo");
    NSString *strDate = [TicketSerivice sharedInstance].fromDate;
    if (tStep == TicketVoyageStepFirst) {
        strDate = [TicketSerivice sharedInstance].fromDate;
    }else if(tStep == TicketVoyageStepSecond){
        strDate = [TicketSerivice sharedInstance].returnDate;
    }
    NSDateFormatter *tFormatter = [[NSDateFormatter alloc] init];
    [tFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *tDate = [tFormatter dateFromString:strDate];
    switch (btn.tag) {
        case 0:{//前一天
            NSDate *lastDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([tDate timeIntervalSinceReferenceDate] - OneDaySeconds)];
            if (tStep == TicketVoyageStepFirst) {
                NSComparisonResult r = [[TicketSerivice sharedInstance].tMinDate compare:lastDate];
                if (NSOrderedDescending == r) {
                    [SVProgressHUD showErrorWithStatus:@"不能购买该日期船票，不在订票日期范围内" duration:2];
                    return;
                }
            }else if(tStep == TicketVoyageStepSecond){
                NSDate *toDate = [tFormatter dateFromString:[TicketSerivice sharedInstance].fromDate];
                NSComparisonResult r = [toDate compare:lastDate];
                if (NSOrderedDescending == r) {
                    [SVProgressHUD showErrorWithStatus:@"返程票时间不能早于启程票" duration:2];
                    return;
                }
            }
            
            strDate = [tFormatter stringFromDate:lastDate];
            break;
        }
        case 2:{//后一天
            NSDate *nextDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([tDate timeIntervalSinceReferenceDate] + OneDaySeconds)];
            
            NSComparisonResult r = [[TicketSerivice sharedInstance].tMaxDate compare:nextDate];
            if (NSOrderedAscending == r) {
                [SVProgressHUD showErrorWithStatus:@"不能购买该日期船票，不在订票日期范围内" duration:2];
                return;
            }
            
            //判断，如果启航日期的下一天大于返航日期则更改返航日期
            if (tStep == TicketVoyageStepFirst) {
                NSDate *rDate = [tFormatter dateFromString:[TicketSerivice sharedInstance].returnDate];
                NSComparisonResult r = [nextDate compare:rDate];
                if (NSOrderedDescending == r) {
                    [TicketSerivice sharedInstance].returnDate = [tFormatter stringFromDate:nextDate];
                }
            }
            
            
            strDate = [tFormatter stringFromDate:nextDate];
            break;
        }
        default:
            break;
    }
    
    if (tStep == TicketVoyageStepFirst) {
        [TicketSerivice sharedInstance].fromDate = strDate;
    }else if(tStep == TicketVoyageStepSecond){
        [TicketSerivice sharedInstance].returnDate = strDate;
    }
    voyageLines = @[];
    [tTableView reloadData];
    [btnDate setTitle:strDate forState:UIControlStateNormal];
    [self requestData];
}


#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return voyageLines.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketListTableViewCell * cell = (TicketListTableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketListTableViewCell];
    
    VoyageItem *item = [voyageLines objectAtIndex:indexPath.row];
    [cell setData:item];
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TicketListCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VoyageItem *item = [voyageLines objectAtIndex:indexPath.row];
    
    if (self.tStep == TicketVoyageStepSecond) {
        //‘返程票时间不能早于启程票’
        VoyageItem *originItem = [TicketSerivice sharedInstance].toVoyageItem;
        NSComparisonResult r = [VoyageItem compare:originItem sitem:item];
        if (NSOrderedDescending == r) {
            //前往时间较大，要修改返程时间
            [SVProgressHUD showErrorWithStatus:@"返程票时间不能早于启程票" duration:2];
            return;
        }else if (NSOrderedAscending == r){
            //时间顺序对，不做修改
        }
    }
    
    
    [item clearData];
    TicketVoyageEditViewController *tvv = [[TicketVoyageEditViewController alloc] init];
    tvv.tStep = self.tStep;
    tvv.mVoyageItem = item;
    [self.navigationController pushViewController:tvv animated:YES];
    
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    
    [acView stopAnimating];
    btnLast.enabled = YES;
    btnNext.enabled = YES;
    
    switch (request.m_requestType) {
            
        case HttpRequestType_XT_QUERY_VOYAGE:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        isRequestSucMark = YES;
                        NSArray *tmpArr = [dic objectForKey:@"VOYAGE"];
                        if([[dic objectForKey:@"VOYAGE"] isKindOfClass:[NSDictionary class]]){
                            NSLog(@"不是array类型，处理一下");
                            tmpArr = @[[dic objectForKey:@"VOYAGE"]];
                            
                        }
                        voyageLines = [VoyageItem getVoyageItemsWithArr:tmpArr];
                        [self flushUI];
                        NSLog(@"请求成功");
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
                
            }else{
                [SVProgressHUD showErrorWithStatus:DefaultRequestFaile duration:DefaultRequestDonePromptTime];
                NSLog(@"请求失败");
            }
            break;
        }
        case HttpRequestType_XT_QUERYSTOREBYCATEGORY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    
                    
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
