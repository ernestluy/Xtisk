//
//  AsyncImgDownLoadRequest.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpPublic.h"
#import "CSIHttpRequest.h"
@class AsyncHttpRequest;


// HTTP请求回调接口
@protocol AsyncHttpRequestDelegate<NSObject>
//请求结束后回调
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode;

@end

// HTTP请求
@interface AsyncHttpRequest : CSIHttpRequest<CSIHTTPRequestDelegate>
{
	id<AsyncHttpRequestDelegate>  m_asyncHttpRequestDelegate;		//请求的代理
	HttpRequestType               m_requestType;                    //请求类型
	NSString                      *responseStringData;              //服务器返回数据
}
@property (retain,nonatomic) id<AsyncHttpRequestDelegate> m_asyncHttpRequestDelegate;
@property (nonatomic) int  iMark;
@property                    HttpRequestType              m_requestType;
@property (retain,nonatomic) NSString                     *responseStringData; 

//初始化请求
- (id)initWithServiceAPI:(NSString *)turl target:(id<AsyncHttpRequestDelegate>)requestDelegate  type:(HttpRequestType )type ;
- (void)setGetFileMode:(NSString *)serviceAPI;
-(NSString *)getResponseJsonStr;
-(NSString *)getResponseStr;
- (NSData *)getResponseData;

-(void)setHttpsRequest;
@end
