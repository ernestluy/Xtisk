//
//  JoinInfo.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoinInfo : NSObject

@property(nonatomic,copy)NSString *joinName;//	String	否	报名人姓名
@property(nonatomic,copy)NSString *joinPhone;//	String	否	报名人电话
@property(nonatomic,copy)NSString *joinGender;//	String	否	报名人性别
@property(nonatomic,copy)NSString *joinEmail;//	String	否	报名人邮箱

+(JoinInfo *)getJoinInfoWithDic:(NSDictionary *)dic;
@end
