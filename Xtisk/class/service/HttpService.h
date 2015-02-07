//
//  HttpService.h
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicDefine.h"
#import "AsyncImgDownLoadRequest.h"
@interface HttpService : NSObject
{
    
}



+(HttpService *)sharedInstance;

-(AsyncHttpRequest *)getRequestLogin:(id<AsyncHttpRequestDelegate>)delegate  name:(NSString *)name psd:(NSString *)psd;
@end
