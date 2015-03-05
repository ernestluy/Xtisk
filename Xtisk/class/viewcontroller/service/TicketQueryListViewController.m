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

#define kTicketListTableViewCell @"kTicketListTableViewCell"
#define TicketListCellHeight 50.0
@interface TicketQueryListViewController ()
{
    NSMutableArray *btnArr;
    int selectedIndex;
    
    UITableView *tTableView;
}
@end

@implementation TicketQueryListViewController

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
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(getLineInfo:) forControlEvents:UIControlEventTouchUpInside];
        }else if (1 == i){
            [btn setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateNormal];
        }else if (2 == i){
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
}


-(void)getLineInfo:(UIButton *)btn{
    NSLog(@"getLineInfo");
    switch (btn.tag) {
        case 0:{//前一天
            
            break;
        }
        case 2:{//后一天
            
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
    
    return 15;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketListTableViewCell * cell = (TicketListTableViewCell *)[tv dequeueReusableCellWithIdentifier:kTicketListTableViewCell];
    
    
    
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
    
    
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
            
        case HttpRequestType_XT_UPDATEACTIVITYJOININFO:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    [self.navigationController popViewControllerAnimated:YES];
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
        default:
            break;
    }
}

@end
