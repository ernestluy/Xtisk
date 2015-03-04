//
//  IUser.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IUser : NSObject
@property(nonatomic,copy)NSString *JSESSIONID;//登录成功后用来维持回话的ID
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *headImageUrl;//用户头像图片URL地址
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *signature;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *maritalStatus;
@property(nonatomic,copy)NSString *enterprise;
@property(nonatomic,copy)NSString *account;//企业


+(IUser *)getIUserWithDic:(NSDictionary *)dic;
@end
