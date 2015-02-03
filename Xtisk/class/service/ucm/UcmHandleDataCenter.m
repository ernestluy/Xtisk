//
//  UcmHandleDataCenter.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "UcmHandleDataCenter.h"
@interface UcmHandleDataCenter ()
{
    dispatch_queue_t m_socketDelegateQueue;
    dispatch_queue_t m_socketQueue;
    NSMutableData* m_receivedData;
}
@end
@implementation UcmHandleDataCenter
@synthesize m_socket;

- (id) init
{
    self = [super init];
    if (self) {
        m_socketDelegateQueue = dispatch_queue_create("imsockDelegateQue", 0);
        m_socketQueue=dispatch_queue_create("imsocketqueue", 0);
        m_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:m_socketDelegateQueue socketQueue:m_socketQueue];
        m_receivedData = nil;
        
    }
    return self;
}

@end
