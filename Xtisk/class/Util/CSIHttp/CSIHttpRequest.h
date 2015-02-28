//
//  AsyncImgDownLoadRequest.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CSIHttpRequest;
@protocol CSIHTTPRequestDelegate <NSObject>

@optional

- (void)requestFinished:(CSIHttpRequest *)request;
- (void)requestFailed:(CSIHttpRequest *)request;

@end
@interface CSIHttpRequest : NSObject<NSURLConnectionDataDelegate>
{
    NSError *error;
    NSMutableURLRequest *urlRequest;
    NSURLConnection *connection;
    
    NSMutableData* receviedData;
    
    NSMutableData *sendData;
    

    id<CSIHTTPRequestDelegate> delegate;
    NSTimer *postTimer;
    NSString *cRequestMethod;
    BOOL isNeedRequestAgain;
    int requestTimes;
}
@property (atomic, retain) NSError *error;
@property (atomic, retain) NSMutableURLRequest *urlRequest;
@property (nonatomic, retain) NSMutableData* receviedData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) id<CSIHTTPRequestDelegate> delegate;
@property (nonatomic, copy) NSString *cRequestMethod;
@property (nonatomic) BOOL isNeedRequestAgain;
@property (nonatomic) int requestTimes;

@property (atomic, assign) SEL didFinishSelector;
@property (atomic, assign) SEL didFailSelector;

- (id)initWithURL:(NSURL *)newURL;
- (void) startAsynchronous;
-(void)requestAgain;
-(void)setRequestMethod:(NSString *)method;
-(void)addRequestHeader:(NSString *)key value:(NSString *)value;
-(void)appendPostData:(NSData*)sData;
- (NSData *)responseData;
-(void)setTimeOutSeconds:(int)time;
@end
