//
//  AsyncImgDownLoadRequest.m
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "AsyncImgDownLoadRequest.h"
@interface AsyncImgDownLoadRequest(){
    int requestTimes;
}
@end
@implementation AsyncImgDownLoadRequest
- (id)initWithServiceAPI:(NSString *)turl target:(id<AsyncHttpRequestDelegate>)requestDelegate type:(HttpRequestType )type{
    
    self =[super initWithServiceAPI:(NSString *)turl target:requestDelegate type:type];
    
    [self.urlRequest setValue:@"*" forHTTPHeaderField:@"Accept-Encoding"];
    self.urlRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    // this will make sure the request always returns the cached image
    
    requestTimes = 1;
    self.urlRequest.HTTPShouldHandleCookies = NO;
    
    
    self.urlRequest.HTTPShouldUsePipelining = YES;
    
    
    [self.urlRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    [self setTimeOutSeconds:30];
    return self;
}



@end
