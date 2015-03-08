//
//  MessageListViewController.m
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MessageListViewController.h"
#define kMessageListCell @"kMessageListCell"
#import "MessageDBManager.h"
@interface MessageListViewController ()
{
    LYTableView *tTableView;
    NSMutableArray *mDataArr;
    UILabel *labTmp;
    int fontSize;
    UIFont *fontMsg;
}
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
//    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    mDataArr = [NSMutableArray array];
    fontSize = 14;
    fontMsg = [UIFont systemFontOfSize:14];
    CGRect bounds = [UIScreen mainScreen].bounds;
    int tableHeight = bounds.size.height - 64;
    tTableView = [[LYTableView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, tableHeight) style:UITableViewStylePlain];
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.lyDelegate = self;
//    [tTableView setNeedBottomFlush];
    [tTableView setNeedTopFlush];
    tTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [tTableView registerNib:[UINib nibWithNibName:@"MsgTicketListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [tTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMessageListCell];
    [self.view addSubview:tTableView];
    [self addData];
    
    labTmp = [[UILabel alloc]init] ;
    labTmp.frame = CGRectMake(0, 0, 300, 20);
    labTmp.font = fontMsg;
    labTmp.numberOfLines = 0;
    labTmp.lineBreakMode = NSLineBreakByWordWrapping;
    labTmp.text = [self getRandomStr];
    [labTmp sizeToFit];
    CGRect tr = labTmp.frame;
    NSLog(@"over");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[HttpService sharedInstance] getRequestGetUserUnreadMsg:self type:@""]startAsynchronous];
}


/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

-(void)addData{
    for (int i = 0; i<5; i++) {
        [mDataArr addObject:[self getRandomStr]];
    }
}
-(NSString *)getRandomStr{
    NSString*tStr = @"我阿打算开房间啊345快算开房间啊快算开房间啊快递费";
    int iRan = arc4random_uniform(10);
    NSMutableString *mStr = [NSMutableString stringWithString:tStr];
    for (int i = 0; i<iRan; i++) {
        [mStr appendString:tStr];
        
    }
    return mStr;
}
#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    [tTableView performSelector:@selector(flushDoneStatus:) withObject:nil afterDelay:4];
}
- (void)flushUpEnd:(NSObject *)ly{
    
}
- (void)startToFlushDown:(NSObject *)ly{
    
}
- (void)flushDownEnd:(NSObject *)ly{
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tTableView setIsDraging:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [tTableView judgeDragIng];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    NSLog(@"drag end");
    [tTableView judgeDragEnd];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mDataArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell * cell = (UITableViewCell*)[tv dequeueReusableCellWithIdentifier:kMessageListCell];
    
    int tTag = 1001;
    CGRect bounds = [UIScreen mainScreen].bounds;
    UILabel *labMsg = ( UILabel *) [cell viewWithTag:tTag];
    if (labMsg == nil) {
        labMsg = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, bounds.size.width - 20, 50)];
        labMsg.numberOfLines = 0;
        labMsg.lineBreakMode = NSLineBreakByWordWrapping;
        [cell addSubview:labMsg];
        labMsg.backgroundColor = [UIColor lightGrayColor];
        labMsg.font = fontMsg;
    }
    NSString *tStr = [mDataArr objectAtIndex:indexPath.row];
    labMsg.text = tStr;
    [labMsg sizeToFit];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    labTmp.text = [mDataArr objectAtIndex:indexPath.row];
    [labTmp sizeToFit];
    return labTmp.frame.size.height+15;
//    return DEFAULT_CELL_HEIGHT;
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
                if (!data || data.length <DefaultImageMinSize) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
//                UIImage *rImage = [UIImage imageWithData:data];
//                StoreItem *tmpStroeItem = [mDataArr objectAtIndex:ir.indexPath.row];
//                [XTFileManager saveTmpFolderFileWithUrlPath:tmpStroeItem.storeMiniPic with:rImage];
//                FoodListTableViewCell  * pc = (FoodListTableViewCell * )[self.tTableView cellForRowAtIndexPath:ir.indexPath];
//                if (pc) {
//                    pc.imgHeader.contentMode = DefaultImageViewContentMode;
//                    pc.imgHeader.image = rImage;
//                }
                
                
            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        case HttpRequestType_XT_GET_USER_UNREAD_MSG:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    NSLog(@"请求成功");
                    NSDictionary *dic = (NSDictionary *)br.data;
                    if (dic) {
                        NSArray *tmpArr = [dic objectForKey:@"msgList"];
                        NSArray *msgArr = [PushMessageItem getPushMessageItemsWithArr:tmpArr];
                        int intSuc = [DBManager insertPushMessageItems:msgArr];
                        NSLog(@"intSuc:%d",intSuc);
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
