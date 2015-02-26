//
//  HttpService.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
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

#pragma mark - 返回数据处理
-(BaseResponse *)dealResponseData:(NSData *)data{
    if (!data) {
        return nil;
    }
//    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    BaseResponse *br = [BaseResponse getBaseResponseWithDic:[Util getObjWithJsonData:data]];
    return br;
}
#pragma mark - 4.3.1.1	获取海报
-(AsyncHttpRequest *)getRequestPosterList:(id<AsyncHttpRequestDelegate>)delegate {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryPoster",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_POSTERLIST];
    
    [request setRequestMethod:@"GET"];
    
    return request;
}
#pragma mark - 4.3.1.2	获取推荐位
-(AsyncHttpRequest *)getRequestRecomList:(id<AsyncHttpRequestDelegate>)delegate{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryRecom",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_RECOMMENDLIST];
    
    [request setRequestMethod:@"GET"];
    
    return request;
    
}

#pragma mark - 4.3.2.1	获取活动列表
-(AsyncHttpRequest *)getRequestActivityList:(id<AsyncHttpRequestDelegate>)delegate pageNo:(int)pageNo pageSize:(int)pageSize{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryActivityList",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryActivityDetail",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activityCommentsList",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/activityComments",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/favoriteActivity",SERVICE_HOME];
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
-(AsyncHttpRequest *)getRequestJoinActivity:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId joinName:(NSString *)joinName joinPhone:(NSString *)joinPhone joinGender:(NSString *)joinGender joinEmail:(NSString *)joinEmail{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    /*
     activityId	String	否		活动ID
     joinName	String	否	2-20	报名人姓名
     joinPhone	String	否	11-13	报名人电话
     joinGender	String	否		性别(男/女)
     joinEmail	String	否	10-100	报名者邮箱
     */
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/favoriteActivity",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_ACTIVITYCOMMENTS];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr stringByAppendingFormat:@"activityId=%@&",activityId];
    [mContentStr stringByAppendingFormat:@"joinName=%@&",joinName];
    [mContentStr stringByAppendingFormat:@"joinPhone=%@&",joinPhone];
    [mContentStr stringByAppendingFormat:@"joinGender=%@&",joinGender];
    [mContentStr stringByAppendingFormat:@"joinEmail=%@",joinEmail];
    
    NSData *data = [Util strToData:mContentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.7	查看活动报名信息
-(AsyncHttpRequest *)getRequestQueryActivityJoinInfo:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryActivityJoinInfo",SERVICE_HOME];
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
-(AsyncHttpRequest *)getRequestUpdateActivityJoinInfo:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId joinName:(NSString *)joinName joinPhone:(NSString *)joinPhone joinGender:(NSString *)joinGender joinEmail:(NSString *)joinEmail{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/updateActivityJoinInfo",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPDATEACTIVITYJOININFO];
    
    NSMutableString *mContentStr = [NSMutableString string];
    [mContentStr stringByAppendingFormat:@"activityId=%@&",activityId];
    [mContentStr stringByAppendingFormat:@"joinName=%@&",joinName];
    [mContentStr stringByAppendingFormat:@"joinPhone=%@&",joinPhone];
    [mContentStr stringByAppendingFormat:@"joinGender=%@&",joinGender];
    [mContentStr stringByAppendingFormat:@"joinEmail=%@",joinEmail];
    
    NSData *data = [Util strToData:mContentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.2.9	取消报名
-(AsyncHttpRequest *)getRequestCancelActivityJoin:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID。
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/cancelActivityJoin",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryCategory?parentCategoryId=%@",SERVICE_HOME,parentCategoryId];
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
-(AsyncHttpRequest *)getRequestQueryStoreByCategory:(id<AsyncHttpRequestDelegate>)delegate categoryId:(NSString *)categoryId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryStoreByCategory",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYSTOREBYCATEGORY];
    
    NSString *contentStr = [NSString stringWithFormat:@"categoryId=%@",categoryId];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}
#pragma mark - 4.3.3.3	获取店家详情
-(AsyncHttpRequest *)getRequestQueryStoreDetail:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryStoreDetail",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryStoreMenu",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/favoriteStore",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/storeComments",SERVICE_HOME];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/querystoreComments",SERVICE_HOME];
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


#pragma mark - 4.3.4.4	查看我报名的活动列表
-(AsyncHttpRequest *)getRequestQueryMyActivity:(id<AsyncHttpRequestDelegate>)delegate pageNo:(int)pageNo pageSize:(int)pageSize{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/queryMyActivity",SERVICE_HOME];
    urlStr = [NSString stringWithFormat:@"%@?pageNo=%d&pageSize=%d",urlStr,pageNo,pageSize];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_QUERYMYACTIVITY];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark - 4.3.4.5	修改密码
-(AsyncHttpRequest *)getRequestUpdateMyPassword:(id<AsyncHttpRequestDelegate>)delegate oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword checkPassword:(NSString *)checkPassword{
    //APP请求时需要在http header cookie属性里面携带上登录成功时返回的JSESSIONID
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/updateMyPassword",SERVICE_HOME];
    urlStr = [NSString stringWithFormat:@"%@?oldPassword=%@&newPassword=%@&checkPassword=%@",urlStr,oldPassword,newPassword,checkPassword];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_UPDATEMYPASSWORD];
    [request setRequestMethod:@"GET"];
    return request;
}

#pragma mark - 4.3.4.9	登录
-(AsyncHttpRequest *)getRequestLogin:(id<AsyncHttpRequestDelegate>)delegate  name:(NSString *)name psd:(NSString *)psd{
    
#pragma mark 密码加密 -
    NSString *middleString = @"&passWord=";
    NSString *pass = psd;
    NSData *plain = [pass dataUsingEncoding:NSUTF8StringEncoding];
    //设置密钥"ABCD1234abcd5678"
    NSString *keyString =  @"ABCD1234abcd5678";
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encData = [HttpService doCipher:plain key:keyData context:kCCEncrypt];
    NSString *encoded = [encData base64EncodedString];
    NSString *decoded   = [encoded stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *reEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                ( CFStringRef)decoded,
                                                                                                NULL,
                                                                                                CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                                kCFStringEncodingUTF8));
    NSLog(@"reEncoded: '%@'", reEncoded);
#pragma mark 发送消息到服务器格式 -
    NSString *ip = @"116.7.243.122:9999";
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/UCM/LoginServiceDS?IMSNo=", ip];
    urlStr = [urlStr stringByAppendingString:name];
    urlStr = [urlStr stringByAppendingString:middleString];
    urlStr = [urlStr stringByAppendingString:reEncoded];
    // TODO: 4 is iPhone module type .
    urlStr = [urlStr stringByAppendingFormat:@"&NetType=%d",1];
    urlStr = [urlStr stringByAppendingString:@"&ModuleType=4"];
    
    // version number
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    urlStr = [urlStr stringByAppendingFormat:@"&Version=%@",[NSString stringWithFormat:@"%@.%@",
                                                             majorVersion, minorVersion]];
     AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
     target:delegate
     type:HttpRequestType_XT_LOGIN];
     [request setRequestMethod:@"GET"];
    
    
    /*
    NSString *urlStr = [NSString stringWithFormat:@"https://%@/login",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_LOGIN];
//    NSMutableString *contentStr = [NSMutableString string];
//    [contentStr stringByAppendingFormat:@"phone=%@&password=%@",name,psd];
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&password=%@",name,psd];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
     */
    return request;
}


#pragma mark - 4.3.4.10	注册
-(AsyncHttpRequest *)getRequestReg:(id<AsyncHttpRequestDelegate>)delegate  account:(NSString *)account psd:(NSString *)psd authCode:(NSString *)authCode{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/createUser",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_LOGIN];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr stringByAppendingFormat:@"phone=%@&password=%@",name,psd];
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&password=%@&checkPassword=%@&authCode=%@",account,psd,psd,authCode];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark - 4.3.4.11	获取/验证短信验证码
-(AsyncHttpRequest *)getRequestSmsCode:(id<AsyncHttpRequestDelegate>)delegate  account:(NSString *)account method:(NSString *)method smsCode:(NSString *)smsCode{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/smsCode",SERVICE_HOME];
    AsyncHttpRequest *request = [[AsyncHttpRequest alloc]initWithServiceAPI:urlStr
                                                                     target:delegate
                                                                       type:HttpRequestType_XT_LOGIN];
    //    NSMutableString *contentStr = [NSMutableString string];
    //    [contentStr stringByAppendingFormat:@"phone=%@&password=%@",name,psd];
    NSString *contentStr = [NSString stringWithFormat:@"phone=%@&method=%@&smsCode=%@",account,method,smsCode];
    NSData *data = [Util strToData:contentStr];
    [request appendPostData:data];
    [request setRequestMethod:@"POST"];
    return request;
}
@end
