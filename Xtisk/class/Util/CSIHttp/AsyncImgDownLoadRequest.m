//
//  AsyncImgDownLoadRequest.m
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "AsyncImgDownLoadRequest.h"

@implementation AsyncImgDownLoadRequest
- (id)initWithServiceAPI:(NSString *)turl target:(id<AsyncHttpRequestDelegate>)requestDelegate type:(HttpRequestType )type{
    
    self =[super initWithServiceAPI:(NSString *)turl target:requestDelegate type:type];
    
    [self.urlRequest setValue:@"*" forHTTPHeaderField:@"Accept-Encoding"];
    return self;
}
@end
