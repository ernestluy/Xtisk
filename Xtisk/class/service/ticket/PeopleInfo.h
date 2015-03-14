//
//  PeopleInfo.h
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleInfo : NSObject
@property(nonatomic,copy)NSString *name;//	String	否	用户姓名
@property(nonatomic,copy)NSString *email;//	String	否	用户邮箱
@property(nonatomic,copy)NSString *phone;//	String	否	电话号码
@property(nonatomic,copy)NSString *identity_card;//	String	否	提票验证码，3位数字

+(PeopleInfo *)getPeopleInfoWithDic:(NSDictionary *)dic;
@end
