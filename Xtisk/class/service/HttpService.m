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
    urlStr = [urlStr stringByAppendingFormat:@"&NetType=%d",DEBUG?1:2];
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
    return request;
}
@end
