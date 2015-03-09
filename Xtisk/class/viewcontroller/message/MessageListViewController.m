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

    int fontSize;
    UIFont *fontMsg;
    
    int maxWidth;
    int curId;
    
    int curIndex;
    
    float tOffsetY;
    
    BOOL isNeedReload;
}
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"i蛇口";
//    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    mDataArr = [NSMutableArray array];
    fontSize = 14;
    fontMsg = [UIFont systemFontOfSize:14];
    curId = -1;
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
    
    maxWidth = 150;
//    CGRect tr = labTmp.frame;
    NSLog(@"over");
//    NSArray *tmpMsgArr = [DBManager queryPushMessageItemWithAccount:[SettingService sharedInstance].iUser.phone];
    NSArray *tmpMsgArr = [DBManager queryRecentMessagesWithSid:curId account:[SettingService sharedInstance].iUser.phone];
    if (tmpMsgArr) {
        [mDataArr addObjectsFromArray:tmpMsgArr];
    }
    
    self.view.backgroundColor = _rgb2uic(0xf7f7f7, 1);
    tTableView.backgroundColor = [UIColor clearColor];
    [DBManager updateMsgIsReadWithAccount:[SettingService sharedInstance].iUser.phone];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
    
}

-(void)requestData{
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
- (float) heightForString:(NSString *)value fontSize:(float)pFontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:pFontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
- (CGSize) sizeForString:(NSString *)value fontSize:(float)pFontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:pFontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit;
}

-(void)flushUI{
    [tTableView reloadData];
    if (mDataArr.count>0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(mDataArr.count - 1) inSection:0];
        [tTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
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
-(float)calHeightWithData:(PushMessageItem *)item{
    item.tSize = [self sizeForString:item.content fontSize:fontSize andWidth:maxWidth];
    return item.tSize.height + 15 + 14;
}

-(float)calHeightWithArr:(NSArray *)arr{
    float allHeight = 0;
    for (int i = 0; i<arr.count; i++) {
        PushMessageItem *item = [arr objectAtIndex:i];
        allHeight += [self calHeightWithData:item];
    }
    return allHeight;
}
#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    if (mDataArr.count>0) {
        PushMessageItem *item = [mDataArr objectAtIndex:0];
        curId = item.sid;
        NSArray *tmpMsgArr = [DBManager queryRecentMessagesWithSid:curId account:[SettingService sharedInstance].iUser.phone];
        if (tmpMsgArr && tmpMsgArr.count>0) {
            [mDataArr insertObjects:tmpMsgArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tmpMsgArr.count)]];
//            curIndex = tmpMsgArr.count - 1;
            
            tOffsetY = [self calHeightWithArr:tmpMsgArr];
            isNeedReload = YES;
//            tTableView.contentOffset = CGPointMake(0, tHeight);
//            [tTableView setContentOffset:CGPointMake(0,tHeight)];
            
        }else{
            isNeedReload = NO;
        }
    }
    
    
    [tTableView performSelector:@selector(flushDoneStatus:) withObject:nil afterDelay:0.1];
}
- (void)flushUpEnd:(NSObject *)ly{
    if (isNeedReload) {
        isNeedReload = NO;
        [tTableView reloadData];
        if (tOffsetY>0) {
            tTableView.contentOffset = CGPointMake(0, tOffsetY - 20);
        }
    }
    
//    [UIView animateWithDuration:0.25 animations:^{
//        if (tOffsetY>0) {
//            tTableView.contentOffset = CGPointMake(0, tOffsetY - 20);
//        }
//    }completion:^(BOOL finished){
//        
//    }];
    
    
    tOffsetY = 0;
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
    int frameTag = 1003;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    UILabel *labMsg = ( UILabel *) [cell viewWithTag:tTag];
    UIImageView *frameImgView = (UIImageView *)[cell viewWithTag:frameTag];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [ UIColor clearColor];
    int insetH = 14;
    
    if (labMsg == nil) {
        labMsg = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, bounds.size.width - 20, 50)];
        labMsg.numberOfLines = 0;
        labMsg.lineBreakMode = NSLineBreakByWordWrapping;
        labMsg.textColor = _rgb2uic(0x707070, 1);
        [cell addSubview:labMsg];
        labMsg.tag = tTag;
        labMsg.font = fontMsg;
        
        UIImageView *shekouImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2 + insetH/2, 27, 27)];
        shekouImgView.image = [UIImage imageNamed:@"msg_shekou_icon"];
        [cell addSubview:shekouImgView];
        
        frameImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 27, 27)];
        
        frameImgView.tag = frameTag;
//        frameImgView.backgroundColor = [UIColor yellowColor];
        [cell addSubview:frameImgView];
        [cell sendSubviewToBack:frameImgView];
    }
    PushMessageItem *item = [mDataArr objectAtIndex:indexPath.row];
    NSString *tContent = [item.content stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    labMsg.text = tContent;
    //18
    
    labMsg.frame = CGRectMake(60, 7 + insetH/2, item.tSize.width, item.tSize.height);
    frameImgView.frame = CGRectMake(45, 2 + insetH/2, item.tSize.width + 20, item.tSize.height + 13);
    UIImage* tImage =  [UIImage imageNamed:@"msg_im_frame"];
    tImage = [tImage stretchableImageWithLeftCapWidth:22 topCapHeight:25];
    frameImgView.image = tImage;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    PushMessageItem *item = [mDataArr objectAtIndex:indexPath.row];
    item.tSize = [self sizeForString:item.content fontSize:fontSize andWidth:maxWidth];
    return item.tSize.height + 15 + 14;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    tTableView.contentOffset = CGPointMake(0, 120);
}


#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    [SVProgressHUD dismiss];
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
//                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
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
                    NSArray *tmpArr = (NSArray *)br.data;
                    if (tmpArr) {
                        NSArray *msgArr = [PushMessageItem getPushMessageItemsWithArr:tmpArr];
                        [PushMessageItem setPushMessageItemsIsRead:YES arr:msgArr];
                        if (msgArr) {
                            [mDataArr addObjectsFromArray:msgArr];
                        }
                        int intSuc = [DBManager insertPushMessageItems:msgArr];
                        NSLog(@"intSuc:%d",intSuc);
                        if (msgArr.count>0) {
                            [self flushUI];
                        }
                        
                        
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
