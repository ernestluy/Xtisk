//
//  UserService.h
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingService : NSObject
{
    
}
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *psd;
+(SettingService *)sharedInstance;
@end
