//
//  CSIHttpRequest.h
//  StockMobile
//
//  Created by zzt on 15/1/8.
//  Copyright (c) 2015年 zzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CSIHttpRequest;
@protocol CSIHTTPRequestDelegate <NSObject>

@optional

- (void)requestFinished:(CSIHttpRequest *)request;
- (void)requestFailed:(CSIHttpRequest *)request;

@end
@interface CSIHttpRequest : NSObject
{
    NSError *error;
    NSMutableURLRequest *urlRequest;
    NSURLConnection *connection;
    
    NSMutableData* receviedData;
    
    NSMutableData *sendData;
    

    id<CSIHTTPRequestDelegate> delegate;
}
@property (atomic, retain) NSError *error;
@property (atomic, retain) NSMutableURLRequest *urlRequest;
@property (nonatomic, retain) NSMutableData* receviedData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) id<CSIHTTPRequestDelegate> delegate;

@property (atomic, assign) SEL didFinishSelector;
@property (atomic, assign) SEL didFailSelector;

- (id)initWithURL:(NSURL *)newURL;
- (void) startAsynchronous;
-(void)setRequestMethod:(NSString *)method;
-(void)addRequestHeader:(NSString *)key value:(NSString *)value;
-(void)appendPostData:(NSData*)sData;
- (NSData *)responseData;
-(void)setTimeOutSeconds:(int)time;
@end
