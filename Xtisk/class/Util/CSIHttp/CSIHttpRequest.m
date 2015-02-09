//
//  AsyncImgDownLoadRequest.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CSIHttpRequest.h"

NSOperationQueue *tQueue = nil;
@interface CSIHttpRequest (){
    int  requestsLimit;
    int requestAllTimes;
}
+(NSOperationQueue *)getSingleQueue;
@end

@implementation CSIHttpRequest
@synthesize error,receviedData,connection,urlRequest;
@synthesize didFailSelector,didFinishSelector;
@synthesize delegate,cRequestMethod,isNeedRequestAgain;
@synthesize requestTimes;

+(NSOperationQueue *)getSingleQueue{
    if (nil == tQueue) {
        @synchronized([CSIHttpRequest class]){
            if (nil == tQueue) {
                tQueue = [[NSOperationQueue alloc] init];
                tQueue.maxConcurrentOperationCount = 5;
            }
        }
    }
    
    return tQueue;
}
-(void)dealloc{
    [error release];
    [receviedData release];
    [urlRequest release];
    [sendData release];
    [cRequestMethod release];
    [super dealloc];
}

- (id)initWithURL:(NSURL *)newURL{
    self = [self init];
    self.urlRequest = [NSMutableURLRequest requestWithURL: newURL];
    sendData = [[NSMutableData alloc] init];
    postTimer = nil;
    isNeedRequestAgain = NO;
    requestTimes = 1;
    requestsLimit = 3;
    requestAllTimes = 0;
    return self;
}

- (void) startAsynchronous{
    self.requestTimes -=1;
    requestAllTimes ++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.connection = [ NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
}


-(void)timeOutAction{
    if (self.connection) {
        [self.connection cancel];
    }
    [self connection:self.connection didFailWithError:nil];
}

-(void)setRequestMethod:(NSString *)method{
    self.cRequestMethod = method;
    [self.urlRequest setHTTPMethod:method];
    self.urlRequest.HTTPBody = sendData;
}

-(void)addRequestHeader:(NSString *)key value:(NSString *)value{
    [self.urlRequest setValue:value forHTTPHeaderField:key];
}

-(void)appendPostData:(NSData*)sData{
    [sendData appendData:sData];
}

- (NSData *)responseData{
    return receviedData;
}

-(void)setTimeOutSeconds:(int)time{
    self.urlRequest.timeoutInterval = time;
}

-(void)requestAgain{
    self.requestTimes +=1;
}
-(BOOL)isRequestAgain{
    
    if (requestAllTimes >= requestsLimit) {
        //已经请求3次了，不允许再请求，返回false
        return NO;
    }
    if (self.requestTimes ==0) {
        return NO;
    }
    NSLog(@"再次请求");
    [self startAsynchronous];
    return YES;
}
#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    //   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
    //    NSUInteger statusCode = [httpResponse statusCode];
    self.receviedData = [NSMutableData data ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receviedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

//    NSLog(@"线程：%@", [NSThread currentThread]);
    if (self.delegate) {
        if ([self.delegate respondsToSelector:self.didFinishSelector]) {
            [self.delegate performSelector:self.didFinishSelector withObject:self];
        }else{
            if ([self.delegate respondsToSelector:@selector(requestFinished:)]) {
                [self.delegate  requestFinished:self];
            }
        }
        
    }
    
    if ([self isRequestAgain]) {
        return;
    }
    self.connection = nil;
    self.delegate = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)er{
//    NSLog(@"线程：%@", [NSThread currentThread]);
    self.error = er;
//    if ([er code] == -1001){ //-1001 is Timeout #warning time out message
//        if (self.delegate) {
//            if ([self.delegate respondsToSelector:self.didFailSelector]) {
//                [self.delegate performSelector:self.didFailSelector withObject:self];
//            }else{
//                if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
//                    [self.delegate requestFailed:self];
//                }
//            }
//            
//        }
//    }
//    else{
//    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:self.didFailSelector]) {
            [self.delegate performSelector:self.didFailSelector withObject:self];
        }else{
            if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
                [self.delegate requestFailed:self];
            }
        }
        
    }
    if ([self isRequestAgain]) {
        return;
    }
    self.delegate = nil;
    self.connection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -

@end
