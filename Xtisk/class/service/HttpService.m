//
//  HttpService.m
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "HttpService.h"
#import "NSData+Base64.h"
#import "NSData+AES256.h"
#import "NSDate+utils.h"

static HttpService *httpServiceInstance = nil;
@implementation HttpService

+ (NSData *)doCipher:(NSData *)dataIn key:(NSData *)symmetricKey context:(CCOperation)encryptOrDecrypt{
    CCCryptorStatus ccStatus = kCCSuccess;
    size_t cryptBytes = 0;
    NSMutableData *dataOut = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeAES128];
    
    ccStatus = CCCrypt( encryptOrDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, symmetricKey.bytes, kCCKeySizeAES128, 0, dataIn.bytes, dataIn.length, dataOut.mutableBytes, dataOut.length, &cryptBytes);
    
    if (ccStatus != kCCSuccess){
        NSLog(@"CCCrypt status:%d",ccStatus);
    }
    dataOut.length = cryptBytes;
    return dataOut;
}
+(HttpService *)sharedInstance{
    if (!httpServiceInstance) {
        @synchronized([HttpService class]){
            if (!httpServiceInstance) {
                httpServiceInstance = [[HttpService alloc] init];
            }
        }
    }
    return httpServiceInstance;
}

+(NSString *)getErrorStrWithCode:(int)code{
    switch (code) {
        case 0:
            return @"成功";
        case 1:
            return @"系统异常";
        case 2:
            return @"用户未登录";
        case 110101:
            return @"手机号码不正确";
        case 110102:
            return @"无效的验证码";
        case 110103:
            return @"验证码发送失败";
        case 110201:
            return @"密码重置失败";
        default:
            return @"未知错误";
    }
}

#pragma mark - 返回数据处理
-(BaseResponse *)dealResponseData:(NSData *)data{
    if (!data) {
        return nil;
    }
    NSLog(@"result:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    BaseResponse *br = [BaseResponse getBaseResponseWithDic:[Util getObjWithJsonData:data]];
    if (2 == br.code) {
        //用户未登录
        [[SettingService sharedInstance] logout];
    }
    return br;
}

-(AsyncImgDownLoadRequest *)getImgRequest:(id<AsyncHttpRequestDelegate>)delegate url:(NSString *)str{
    AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:str
                                                                                   target:delegate
                                                                                     type:HttpRequestType_Img_LoadDown];
    return request;
}

-(AsyncHttpRequest *)getRequestUploadImage:(id<AsyncHttpRequestDelegate>)delegate url:(NSString*)urlstring image:(UIImage*)image{
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/uploadImage",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPDATE_IMG];
    //[mutableHeaders setValue:[NSString stringWithFormat:@"form-data; name=\"%@\"; filename=\"%@\"", name, fileName] forKey:@"Content-Disposition"];
//    NSString *nValue = [NSString stringWithFormat:@"form-data; name=\"%@\"; filename=\"%@\"", @"imageFile", @"avatar.jpg"];
////    [mutableHeaders setValue:mimeType forKey:@"Content-Type"];
//    [request.urlRequest addValue:nValue forHTTPHeaderField:@"Content-Disposition"];
//    [request.urlRequest addValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
//    [request appendPostData:imageData];
//    [request setRequestMethod:@"POST"];
    [request uploadImage:urlStr image:image params:nil];
    return request;
}

#pragma mark - 4.3.1.1	获取海报
-(AsyncHttpRequest *)getRequestPosterList:(id<AsyncHttpRequestDelegate>)delegate {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/index/queryPoster",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_POSTERLIST];
    
    [request setRequestMethod:@"GET"];
    
    return request;
}
#pragma mark - 4.3.1.2	获取推荐位
-(AsyncHttpRequest *)getRequestRecomList:(id<AsyncHttpRequestDelegate>)delegate{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/index/queryRecom",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_RECOMMENDLIST];
    
//    [request appendPostData:data];
//    [request setRequestMethod:@"POST"];
    [request setRequestMethod:@"GET"];
    
    return request;
    
}

#pragma mark - 4.3.2.1	获取活动列表
-(AsyncHttpRequest *)getRequestActivityList:(id<AsyncHttpRequestDelegate>)delegate pageNo:(int)pageNo pageSize:(int)pageSize{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/queryActivityList",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_ACTIVITYLIST];

    NSString *contentStr = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",pageNo,pageSize];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}
#pragma mark - 4.3.2.2	获取活动详情
-(AsyncHttpRequest *)getRequestActivityDetail:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/queryActivityDetail",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_ACTIVITYDETAIL];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@",activityId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.3	获取活动评论 页码，默认为1
-(AsyncHttpRequest *)getRequestactivityCommentsList:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId pageNo:(int)pageNo pageSize:(int)pageSize{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/activityCommentsList",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_ACTIVITYCOMMENTSLIST];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@&pageNo=%d&pageSize=%d",activityId,pageNo,pageSize];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.4	评论活动
-(AsyncHttpRequest *)getRequestActivityComments:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId content:(NSString *)content{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/activityComments",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_ACTIVITYCOMMENTS];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@&content=%@",activityId,content];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.5	活动点赞/取消点赞
-(AsyncHttpRequest *)getRequestFavoriteActivity:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/favoriteActivity",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_FAVORITEACTIVITY];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@",activityId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.6	活动报名
-(AsyncHttpRequest *)getRequestJoinActivity:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId joinInfo:(JoinInfo *)jInfo{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    /*
     activityId	String	否		活动ID
     joinName	String	否	2-20	报名人姓名
     joinPhone	String	否	11-13	报名人电话
     joinGender	String	否		性别(男/女)
     joinEmail	String	否	10-100	报名者邮箱
     */
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/joinActivity",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_JOINACTIVITY];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"activityId=%@&",activityId];
    [mContentStr appendFormat:@"joinName=%@&",jInfo.joinName];
    [mContentStr appendFormat:@"joinPhone=%@&",jInfo.joinPhone];
    [mContentStr appendFormat:@"joinGender=%@&",jInfo.joinGender];
    [mContentStr appendFormat:@"joinEmail=%@",jInfo.joinEmail];
    NSLog(@"mContentStr%@",mContentStr );
    NSData *data = [Util strToData:mContentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.7	查看活动报名信息
-(AsyncHttpRequest *)getRequestQueryActivityJoinInfo:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/queryActivityJoinInfo",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYACTIVITYJOININFO];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@",activityId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.8	修改活动报名信息
-(AsyncHttpRequest *)getRequestUpdateActivityJoinInfo:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId  joinInfo:(JoinInfo *)jInfo{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/updateActivityJoinInfo",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPDATEACTIVITYJOININFO];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"activityId=%@&",activityId];
    [mContentStr appendFormat:@"joinName=%@&",jInfo.joinName];
    [mContentStr appendFormat:@"joinPhone=%@&",jInfo.joinPhone];
    [mContentStr appendFormat:@"joinGender=%@&",jInfo.joinGender];
    [mContentStr appendFormat:@"joinEmail=%@",jInfo.joinEmail];
    
    NSData *data = [Util strToData:mContentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.9	取消报名
-(AsyncHttpRequest *)getRequestCancelActivityJoin:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activity/cancelActivityJoin",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_CANCELACTIVITYJOIN];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@",activityId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    /*
     响应参数
     字段名称	类型	是否可空	字段说明
     joinPeople	Int	否	报名人数
     */
    return request;
}

#pragma mark - 4.3.3	周边
#pragma mark - 4.3.3.1	获取周边的分类（含根据父分类获取子分类）
-(AsyncHttpRequest *)getRequestCategoryTypeList:(id<AsyncHttpRequestDelegate>)delegate parentCategoryId:(NSString *)parentCategoryId{
    //parentCategoryId	String	是	父分类ID，如果获取第一层分类则改ID不填
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/queryCategory?parentCategoryId=%@",SERVICE_HOME,parentCategoryId];
    if (parentCategoryId && parentCategoryId.length>0) {
        urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/queryCategory?parentCategoryId=%@",SERVICE_HOME,parentCategoryId];
    }else{
        urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/queryCategory",SERVICE_HOME];
    }
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYCATEGORY];
    
//    NSString *contentStr = [NSString stringWithFormat:@"parentCategoryId=%@",parentCategoryId];
//    NSData *data = [Util strToData:contentStr];
//    [request appendPostData:data];
    [request setRequestMethod:@"GET"];

    return request;
}
#pragma mark - 4.3.3.2	根据分类获取分类下的店家列表
-(AsyncHttpRequest *)getRequestQueryStoreByCategory:(id<AsyncHttpRequestDelegate>)delegate categoryId:(NSString *)categoryId pageNo:(int)pageNo pageSize:(int)pageSize orderBy:(int)orderBy;{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/queryStoreByCategory",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYSTOREBYCATEGORY];
    
    NSString *contentStr = [NSString stringWithFormat:@"categoryId=%@&pageNo=%d&pageSize=%d&orderBy=%d",categoryId,pageNo,pageSize,orderBy];//  
    NSData *data = [Util strToData:contentStr];
    NSLog(@"QueryStoreByCategory:%@",contentStr);
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}
#pragma mark - 4.3.3.3	获取店家详情
-(AsyncHttpRequest *)getRequestQueryStoreDetail:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/queryStoreDetail",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYSTOREDETAIL];
    
    NSString *contentStr = [NSString stringWithFormat:@"storeId=%@",storeId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.3.4	获取店家菜单列表
-(AsyncHttpRequest *)getRequestQueryStoreMenu:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/queryStoreMenu",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYSTOREMENU];
    
    NSString *contentStr = [NSString stringWithFormat:@"storeId=%@",storeId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.3.5	店家点赞/取消点赞
-(AsyncHttpRequest *)getRequestFavoriteStore:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/favoriteStore",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_FAVORITESTORE];
    
    NSString *contentStr = [NSString stringWithFormat:@"storeId=%@",storeId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.3.6	店铺评价
-(AsyncHttpRequest *)getRequestStoreComments:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId content:(NSString *)content{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/storeComments",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_STORECOMMENTS];
//    storeId	String		否	店铺ID
//    content	String	300	否	评价内容
    content = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *contentStr = [NSString stringWithFormat:@"storeId=%@&content=%@",storeId,content];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.3.7	获取店铺评价列表
-(AsyncHttpRequest *)getRequestStoreCommentsList:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId pageNo:(int)pageNo pageSize:(int)pageSize{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/neighborhood/querystoreComments",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_STORECOMMENTSLIST];
    
    NSString *contentStr = [NSString stringWithFormat:@"storeId=%@&pageNo=%d&pageSize=%d",storeId,pageNo,pageSize];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4	我的
#pragma mark - 4.3.4.1	查看我的船票订单列表
-(AsyncHttpRequest *)getRequestQueryMyTicketOrder:(id<AsyncHttpRequestDelegate>)delegate{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/queryMyTicketOrder",SERVICE_HOME];

    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERY_MY_TICKETS];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark - 4.3.4.2	查看船票订单的详情
-(AsyncHttpRequest *)getRequestQueryTicketOrderDetail:(id<AsyncHttpRequestDelegate>)delegate orderId:(NSString *)orderId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/queryTicketOrderDetail",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERY_MY_TICKET_ORDER_DETAIL];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr appendFormat:@"phone=%@&password=%@",name,psd];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"orderId=%@",orderId];
    
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}


#pragma mark - 4.3.4.3	删除我的船票订单
-(AsyncHttpRequest *)getRequestDelMyTicketOrder:(id<AsyncHttpRequestDelegate>)delegate orderIds:(NSArray *)orderIds{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/delMyTicketOrder",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_DEL_MY_TICKETS];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr appendFormat:@"phone=%@&password=%@",name,psd];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendString:@"orderIds="];
    for (int i = 0; i<orderIds.count; i++) {
        [mContentStr appendFormat:@"%@;",[orderIds objectAtIndex:i]];
    }
    
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}


#pragma mark - 4.3.4.4	查看我报名的活动列表
-(AsyncHttpRequest *)getRequestQueryMyActivity:(id<AsyncHttpRequestDelegate>)delegate activityStatus:(int)activityStatus pageNo:(int)pageNo pageSize:(int)pageSize{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/queryMyActivity",SERVICE_HOME];
    urlStr = [NSString stringWithFormat:@"%@?pageNo=%d&pageSize=%d&activityStatus=%d",urlStr,pageNo,pageSize,activityStatus];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYMYACTIVITY];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark - 4.3.4.5	修改密码
-(AsyncHttpRequest *)getRequestUpdateMyPassword:(id<AsyncHttpRequestDelegate>)delegate oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword checkPassword:(NSString *)checkPassword{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/updateMyPassword",SERVICE_HOME];
    urlStr = [NSString stringWithFormat:@"%@?oldPassword=%@&newPassword=%@&checkPassword=%@",urlStr,oldPassword,newPassword,checkPassword];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPDATEMYPASSWORD];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark - 4.3.4.7	修改个人信息
-(AsyncHttpRequest *)getRequestUpdatePerson:(id<AsyncHttpRequestDelegate>)delegate user:(IUser*)user{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/updatePerson",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPDATEPERSON];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr appendFormat:@"phone=%@&password=%@",name,psd];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"imageFileUrl=%@&",user.headImageUrl];
    [mContentStr appendFormat:@"nickName=%@&",user.nickName];
    [mContentStr appendFormat:@"signature=%@&",user.signature];
    [mContentStr appendFormat:@"gender=%@&",user.gender];
    [mContentStr appendFormat:@"birthday=%@&",user.birthday];
    [mContentStr appendFormat:@"maritalStatus=%@&",user.maritalStatus];
    [mContentStr appendFormat:@"enterprise=%@",user.enterprise];
    
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4.8	注销
-(AsyncHttpRequest *)getRequestlogout:(id<AsyncHttpRequestDelegate>)delegate{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/logout",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_LOGOUT];
   
    [request setRequestMethod:@"GET"];
    
    return request;
}

#pragma mark - 4.3.4.9	登录
-(AsyncHttpRequest *)getRequestLogin:(id<AsyncHttpRequestDelegate>)delegate  name:(NSString *)name psd:(NSString *)psd{
   
    
    //此处暂时改为http
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/applogin",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_LOGIN];
//    NSMutableString *contentStr = [NSMutableString string];
//    [contentStr appendFormat:@"phone=%@&password=%@",name,psd];
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&password=%@",name,psd];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
//    [request setHttpsRequest];
    return request;
}


#pragma mark - 4.3.4.10	注册
-(AsyncHttpRequest *)getRequestReg:(id<AsyncHttpRequestDelegate>)delegate  account:(NSString *)account psd:(NSString *)psd authCode:(NSString *)authCode{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/createUser",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_REG];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr appendFormat:@"phone=%@&password=%@",name,psd];
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&password=%@&authCode=%@",account,psd,authCode];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4.11	获取/验证短信验证码
-(AsyncHttpRequest *)getRequestSmsCode:(id<AsyncHttpRequestDelegate>)delegate  account:(NSString *)account method:(NSString *)method smsCode:(NSString *)smsCode{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/smsCode",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_GETSMSCODE];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr appendFormat:@"phone=%@&password=%@",name,psd];
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&method=%@&smsCode=%@",account,method,smsCode];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4.12	重置密码
-(AsyncHttpRequest *)getRequestResetPassword:(id<AsyncHttpRequestDelegate>)delegate  phone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/resetPassword",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_RESETPSD];
    
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&password=%@&checkPassword=%@&authCode=%@",phone,password,password,authCode];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4.14	建议反馈
-(AsyncHttpRequest *)getRequestSuggestion :(id<AsyncHttpRequestDelegate>)delegate  content:(NSString *)content{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/suggestion",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_SUGGESTION];
    //content	String	300	否	建议反馈内容
    NSString *contentStr = [NSString stringWithFormat:@"content=%@",content];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4.16 删除我的活动
-(AsyncHttpRequest *)getRequestDelMyActivity :(id<AsyncHttpRequestDelegate>)delegate  activityId:(NSString *)activityId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/delMyActivity",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_DEL_MYACTIVITY];
    
    NSString *contentStr = [NSString stringWithFormat:@"activityId=%@",activityId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}
-(AsyncHttpRequest *)getRequestDelMyActivitys:(id<AsyncHttpRequestDelegate>)delegate  activityIds:(NSArray *)ids{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/delMyActivity",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_DEL_MYACTIVITY];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendString:@"activityId="];
    for (int i = 0; i<ids.count; i++) {
        if (0 == i) {
            [mContentStr appendFormat:@"%@",[ids objectAtIndex:i]];
        }else{
            [mContentStr appendFormat:@";%@",[ids objectAtIndex:i]];
        }
    }
    NSLog(@"mContentStr:%@",mContentStr);
    NSData *data = [Util strToData:mContentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}


#pragma mark - 4.3.5.1 获取航线列表
-(AsyncHttpRequest *)getRequestQueryShipLine:(id<AsyncHttpRequestDelegate>)delegate{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/tickets/queryShipLine",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERY_SHIP_LINE];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark - 4.3.5.2 获取航程信息
-(AsyncHttpRequest *)getRequestQueryVoyage:(id<AsyncHttpRequestDelegate>)delegate info:(VoyageRequestPar *)par{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/tickets/queryVoyage",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERY_VOYAGE];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"sailDate=%@&",par.sailDate];
//    [mContentStr appendFormat:@"sailDateReturn=%@&",par.sailDateReturn];
    [mContentStr appendFormat:@"fromPortCode=%@&",par.fromPortCode];
    [mContentStr appendFormat:@"toPortCode=%@&",par.toPortCode];
//    [mContentStr appendFormat:@"fromPortCodeReturn=%@&",par.fromPortCodeReturn];
//    [mContentStr appendFormat:@"toPortCodeReturn=%@&",par.toPortCodeReturn];
    [mContentStr appendFormat:@"currencyCode=%@&",par.currencyCode];
    [mContentStr appendFormat:@"isRoundtrip=%@&",par.isRoundtrip];
    [mContentStr appendFormat:@"lang=%@",par.lang];
    NSLog(@"mContentStr:%@",mContentStr);
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.5.3 船票下订单
-(AsyncHttpRequest *)getRequestSubmitBooking:(id<AsyncHttpRequestDelegate>)delegate info:(TicketOrder *)order{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/tickets/submitBooking",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_SUBMIT_BOOKING];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"name=%@&",order.name];
    [mContentStr appendFormat:@"email=%@&",order.email];
    [mContentStr appendFormat:@"address=%@&",order.address];
    [mContentStr appendFormat:@"phone=%@&",order.phone];
    [mContentStr appendFormat:@"cardnum=%@&",order.cardNum];
    [mContentStr appendFormat:@"lang=%@&",order.lang];
    [mContentStr appendFormat:@"total_fee=%.1f&",order.total_fee];
    [mContentStr appendFormat:@"discount_fee=%.1f&",order.discount_fee];
    [mContentStr appendFormat:@"tickets=%@",order.tickets];

    
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}


#pragma mark - 4.3.6  消息

#pragma mark - 4.3.6.3根据消息id获取消息详情
-(AsyncHttpRequest *)getRequestGetMsgById:(id<AsyncHttpRequestDelegate>)delegate msgId:(NSString *)msgId{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/push/getMsgById",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_GET_MSG_BY_ID];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"msgId=%@&",msgId];
    
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}


#pragma mark - 4.3.6.4获取用户未读消息
-(AsyncHttpRequest *)getRequestGetUserUnreadMsg:(id<AsyncHttpRequestDelegate>)delegate type:(NSString *)tType{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/push/userUnreadMsg",SERVICE_HOME];
    if (tType && tType.length >0) {
        urlStr = [NSString stringWithFormat:@"http://%@/push/userUnreadMsg?type=%@",SERVICE_HOME,tType];
    }
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_GET_USER_UNREAD_MSG];
    
//    NSMutableString *mContentStr = [NSMutableString string];
//    [mContentStr appendFormat:@"type=%@&",tType];
//    
//    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [Util strToData:sendStr];
//    [request appendPostData:data];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark -  把ios的token发到tms
-(AsyncHttpRequest *)getRequestUploadDeviceId:(id<AsyncHttpRequestDelegate>)delegate token:(NSString *)token{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/user/uploadDeviceId",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPLOAD_DEVICE_TOKEN];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr appendFormat:@"deviceId=%@&",token];
    NSString *sendStr = [mContentStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [Util strToData:sendStr];
    [request appendPostData:data];

    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 获取服务器时间
-(AsyncHttpRequest *)getRequestGetTime:(id<AsyncHttpRequestDelegate>)delegate{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/now",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_TIME];
    
    [request setRequestMethod:@"GET"];
    return request;
}




@end
