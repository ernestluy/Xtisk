//
//  ComCommendViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ComCommendViewController.h"
#import "PublicDefine.h"
#import "DetailFoodCommendTableViewCell.h"
@interface ComCommendViewController ()
{
    NSArray *comArr;
}
@end

@implementation ComCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64);
    self.tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStylePlain];
    [self.view addSubview:self.tTableView];
    self.tTableView.dataSource = self;
    self.tTableView.delegate = self;
    
    [self.tTableView registerNib:[UINib nibWithNibName:@"DetailFoodCommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.title = @"网友评价";
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    [[[HttpService sharedInstance] getRequestStoreCommentsList:self storeId:int2str(self.storeId) pageNo:1 pageSize:10]startAsynchronous];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return comArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    DetailFoodCommendTableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil) {
        cell = [[DetailFoodCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CommentsItem *ci = [comArr objectAtIndex:indexPath.row];
    [cell setDataWith:ci];
    return cell;
    
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return COMMEND_CELL_HEIGHT;
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
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <2000) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_STORECOMMENTSLIST:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    NSArray *tmpComArr = [dic objectForKey:@"items"];
                    comArr = [CommentsItem getCommentsItemsWithArr:tmpComArr];
                    [self.tTableView reloadData];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:DefaultRequestDonePromptTime];
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
