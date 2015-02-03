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
@end
