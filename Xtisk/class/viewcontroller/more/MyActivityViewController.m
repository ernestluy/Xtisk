//
//  MyActivityViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyActivityViewController.h"
#import "PublicDefine.h"
#import "MyActivityTableViewCell.h"
#define TheCellId  @"cell"
@interface MyActivityViewController ()
{
    NSMutableArray *btnArr;
    int selectedIndex;
    
    int tAcount;
    
    UIBarButtonItem * doneItem;
    UIBarButtonItem * delItem;
    
    NSArray *allMyActivityArr;
}
@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tAcount = 5;
    // Do any additional setup after loading the view.
    self.title = @"我的活动";
    self.view.backgroundColor = [UIColor whiteColor];
    btnArr = [[NSMutableArray alloc]init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    NSArray *btnTitleArr = @[@"全部",@"进行中",@"已结束"];
    int btnW = bounds.size.width / btnTitleArr.count;
    int btnH = 40;
    int lineHeight = 20;
    for (int i = 0; i<btnTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:_rgb2uic(0x0095f1, 1) forState:UIControlStateSelected];
        btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(actListAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.selected = YES;
        }
        if (i !=0) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*btnW, (btnH - lineHeight)/2, 1, lineHeight)];
            iv.image = [UIImage imageNamed:@"line_gray"];
            [self.view addSubview:iv];
        }
        [btnArr addObject:btn];
    }
    selectedIndex = 0;
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, btnH - 1, bounds.size.width, 1)];
    iv.image = [UIImage imageNamed:@"line_gray"];
    [self.view addSubview:iv];
    
    int tableHeight = bounds.size.height - 64 - btnH;
    tTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, btnH, bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    [tTableView registerNib:[UINib nibWithNibName:@"MyActivityTableViewCell" bundle:nil] forCellReuseIdentifier:TheCellId];
    [self.view addSubview:tTableView];
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 20, 20);
    [okBtn setBackgroundImage:[UIImage imageNamed:@"ac_delete"] forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(toDelete:) forControlEvents:UIControlEventTouchUpInside];
    delItem = [[UIBarButtonItem alloc] initWithCustomView:okBtn] ;
    [self.navigationItem setRightBarButtonItem:delItem];
    
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(0, 0, 30, 20);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:headerColor forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [doneBtn addTarget:self action:@selector(doneDelete:) forControlEvents:UIControlEventTouchUpInside];
    doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn] ;
//    [self.navigationItem setRightBarButtonItem:doneItem];
    
//    进行中 f75218
//    已结束 bcbcbc
//    未开始 4ad02a
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [[[HttpService sharedInstance] getRequestQueryMyActivity:self pageNo:1 pageSize:DefaultPageSize]startAsynchronous];
}

-(void)doneDelete:(id)sender{
    NSLog(@"doneDelete");
    [self.navigationItem setRightBarButtonItem:delItem];
    [tTableView setEditing:NO];
}
-(void)toDelete:(id)sender{
    NSLog(@"toDelete");
    [self.navigationItem setRightBarButtonItem:doneItem];
    [tTableView setEditing:YES];
}
-(void)actListAction:(id)sender{
    NSLog(@"actListAction");
    UIButton *btn = (UIButton *)sender;
    if (selectedIndex == btn.tag) {
        return;
    }
    selectedIndex = (int)btn.tag;
    for (UIButton *tBtn in btnArr) {
        tBtn.selected = NO;
    }
    
    btn.selected = YES;
    switch (btn.tag) {
        case 0:
            
            break;
            
        default:
            break;
    }
}


-(void)flushUI{
    [tTableView reloadData];
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return tAcount;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"commitEditing");
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
        NSLog(@"sec:%d,row:%d",(int)indexPath.section,(int)indexPath.row);
        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        tAcount --;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
    }
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:TheCellId];

    
    return cell;
}

#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
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
          
        case HttpRequestType_XT_QUERYMYACTIVITY:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        int tTotal = [[dic objectForKey:@"total"] intValue];
                        //改为items
                        NSArray *tmpArr = [dic objectForKey:@"items"];
                        allMyActivityArr = [MyActivity getMyActivitysWithArr:tmpArr];
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
