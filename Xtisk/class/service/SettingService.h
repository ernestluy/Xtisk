//
//  UserService.h
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUser.h"
@interface SettingService : NSObject
{
    
}
/*
 Key: TGT token值
 OrgId：企业id
 Account：登录账号
 User：UCM对应ipop的对应值
 Token：token值，主要为DAS系统时试用
 SoftNO：软电话num
 SoftNOPW：软电话密码
 ServicesParam: 该账号具有的服务参数list
 Capacity：业务id list
 ResultInfo:结果信息
 */
@property(nonatomic,copy)IUser *iUser;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *orgId;
@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *user;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *psd;
@property(nonatomic,copy)NSString *JSESSIONID;
+(SettingService *)sharedInstance;

-(BOOL)isLogin;

-(void)logout;

@end
