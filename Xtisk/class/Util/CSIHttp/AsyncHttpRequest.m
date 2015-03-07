//
//  AsyncImgDownLoadRequest.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "AsyncHttpRequest.h"
#import "HttpPublic.h"

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#define Time_Out_Seconds 15


@interface AsyncHttpRequest(private)

//请求失败回调
- (void)requestFail;
//请求完成回调
- (void)requestFinish;

//无效字符转换
- (NSString *)replaceJsonString:(NSString *)jsonString;

@end


@implementation AsyncHttpRequest
@synthesize m_asyncHttpRequestDelegate;
@synthesize m_requestType;
@synthesize responseStringData;
@synthesize iMark;


- (id)initWithServiceAPI:(NSString *)turl target:(id<AsyncHttpRequestDelegate>)requestDelegate type:(HttpRequestType )type {

    NSLog(@"url:%@",turl);
	NSURL *urll = [NSURL URLWithString:turl];
	self = [super initWithURL:urll];
    self.m_asyncHttpRequestDelegate = requestDelegate;
    self.m_requestType = type;
    
    
    //添加 JSON 对象，请求体
//    NSString *jsonString;
//    if (jsonString!=nil) {
//        NSData *dataToSend = [[self replaceJsonString:jsonString] dataUsingEncoding:NSUTF8StringEncoding];
//        [self appendPostData:dataToSend];
//    }else {
//		jsonString = @"";
//	}
	
	//    HTTP/1.1 200 OK
	//    Set-Cookie: SessionID=s8bv0Wunbbbq9rKbyj45yT0mPS9fjTq
	//    SEVER-VER: TSP_HTTP_SERVER/2.1.3 VCT WEB 1.0
	//  Connection: Keep-Alive
	//    Content-Type: text/plain
    //    Content-Length: 23
    
    //添加报文头
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
//	if ([defaults objectForKey:@"SessionID"]) {
//		[self addRequestHeader:@"SessionID" value:[defaults objectForKey:@"SessionID"]];
//	}
//    [self addRequestHeader:@"SEVER-VER" value:@"TSP_HTTP_SERVER/2.1.3 VCT WEB 1.0"];
//    [self addRequestHeader:@"Connection" value:@"Keep-Alive"];
//    [self addRequestHeader:@"Content-Type" value:@"text/xml;charset=utf-8"];
//    [self addRequestHeader:@"Content-Length" value:@"0"];
//    [self addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
//	[self addRequestHeader:@"padtype" value:@"ios"];
	
//	//HID版本
//	NSString *hidVersionInfo = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"HID Version"];
//
//    [self addRequestHeader:@"hidversion" value:hidVersionInfo];
	
    //PRINT_LOG("URL:%s   \n Json:%s",[[self.url description] UTF8String],[jsonString UTF8String]);
	//NSLog(@"请求类型: %d 请求URL:%@ ",self.m_requestType,self.url);
//    [self setNumberOfTimesToRetryOnTimeout:2];//超时则请求2次
    
    
    
//    [self setShouldAttemptPersistentConnection:NO];
	[self setRequestMethod:@"POST"];
	[self setTimeOutSeconds:Time_Out_Seconds];
    self.delegate = self;
	[self setDidFinishSelector:@selector(requestFinish)];
	[self setDidFailSelector:@selector(requestFail)];
//    [self setValidatesSecureCertificate:NO];
	
    return self;
}

- (NSString *)replaceJsonString:(NSString *)jsonString {
	if (jsonString == nil) {
		return @"";
	}
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\\" withString:@""];
	
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\"{" withString:@"{"];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\\\"" withString:@"}"];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"{\\\"" withString:@"{\""];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\"}" withString:@"\"}"];
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"[\\\"" withString:@"[\""];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\"]" withString:@"\"]"];
	
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\",\\\"" withString:@"\",\""];
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\":" withString:@"\":"];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@":\\\"" withString:@":\""];
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"{\\\"" withString:@"{\""];
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\":" withString:@"\":"];
	
	jsonString = [jsonString stringByReplacingOccurrencesOfString:@",\\\"" withString:@",\""];
	
	return jsonString;
}


- (void)requestFail {
	if (m_asyncHttpRequestDelegate) {
        NSLog(@"error:%@",[self.error description]);
		[m_asyncHttpRequestDelegate requestDidFinish:self code:HttpResponseTypeFailed];
	}
}

- (void)requestFinish {
	if (m_asyncHttpRequestDelegate) {
        NSLog(@"http request success");
		[m_asyncHttpRequestDelegate requestDidFinish:self code:HttpResponseTypeFinished];
	}
}
-(NSString *)getResponseJsonStr{
    return [[[NSString alloc] initWithData:[self responseData] encoding:NSUTF8StringEncoding]autorelease];
}
-(NSString *)getResponseStr{
    NSData *data = [self responseData];
    if (!data) {
        return nil;
    }
    return [[[NSString alloc] initWithData:[self responseData] encoding:NSUTF8StringEncoding]autorelease];
}
- (NSData *)getResponseData{
    return [super responseData];
}
- (void)setGetFileMode:(NSString *)serviceAPI
{
	[self setRequestMethod:@"GET"];
	//	NSURL *urll = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,serviceAPI]];
	//	self.url = urll;
}
-(void)setHttpsRequest{
//    [Req setAuthenticationScheme:@"https"];//设置验证方式
//    
//    [Req setValidatesSecureCertificate:NO];//设置验证证书
    //self.urlRequest setvali
    
    [self.urlRequest addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
}
- (void)uploadImage:(NSString*)urlstring image:(UIImage*)image params:(NSDictionary*)body{
    
    
//    NSData *imageData = UIImagePNGRepresentation(image);

    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    //转码成UTF-8  否则可能会出现错误
    NSString *URLTmp = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //  NSDictionary *body = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLTmp parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"imageFile" fileName:@"imageFile.jpg" mimeType:@"image/jpg"];
        
    } error:nil];
    
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress = nil;
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            if (m_asyncHttpRequestDelegate) {
                NSLog(@"error:%@",[self.error description]);
                [m_asyncHttpRequestDelegate requestDidFinish:self code:HttpResponseTypeFailed];
            }
            
            
        } else {
            
            NSLog(@"%@",responseObject);
            if (self.receviedData == nil) {
                self.receviedData = [NSMutableData data ];
            }
            if ([responseObject isKindOfClass:[NSData class]]) {
                [self.receviedData  appendData:responseObject];
            }
            
            if (m_asyncHttpRequestDelegate) {
                NSLog(@"error:%@",[self.error description]);
                [m_asyncHttpRequestDelegate requestDidFinish:self code:HttpResponseTypeFinished];
            }
        }
        
    }];
    
    
    [uploadTask resume];
}

-(void)dealloc{
	[responseStringData release];
	[m_asyncHttpRequestDelegate release];
	[super dealloc];
}
@end
