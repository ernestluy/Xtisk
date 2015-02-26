//
//  UserService.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SettingService.h"
static SettingService *settingServiceInstance = nil;
@interface SettingService()
{
    BMKMapManager *_mapManager;
}
@end
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
-(id)init{
    self = [super init];
    _mapManager = nil;
    return self;
}
-(BOOL)isLogin{
//    if (self.JSESSIONID && self.JSESSIONID.length>0) {
//        return YES;
//    }
    if (self.iUser && self.iUser.phone.length>0) {
        return YES;
    }
    return NO;
}

-(void)logout{

    self.iUser = nil;
    self.account = nil;
    self.JSESSIONID = nil;
}

-(void)PermissionBaiduMap{
    if (!_mapManager) {
        _mapManager = [[BMKMapManager alloc]init];
        BOOL ret = [_mapManager start:@"XPR9zb3EpPOPtG9wZznrmvvB" generalDelegate:self];
        
        if (!ret) {
            NSLog(@"manager start failed!");
        }
    }
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
@end
