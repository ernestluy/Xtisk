//
//  UserService.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SettingService.h"
static SettingService *settingServiceInstance = nil;
@implementation SettingService
@synthesize account,user,token,psd,key,orgId,JSESSIONID;
+(SettingService *)sharedInstance{
    if (!settingServiceInstance) {
        @synchronized([SettingService class]){
            if (!settingServiceInstance) {
                settingServiceInstance = [[SettingService alloc] init];
            }
        }
    }
    return settingServiceInstance;
}

-(BOOL)isLogin{
//    if (self.JSESSIONID && self.JSESSIONID.length>0) {
//        return YES;
//    }
    if (self.account && self.account.length>0) {
        return YES;
    }
    return NO;
}

-(void)logout{

    self.iUser = nil;
    self.JSESSIONID = nil;
}
@end
