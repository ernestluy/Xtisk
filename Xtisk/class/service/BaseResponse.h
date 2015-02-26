//
//  BaseResponse.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject
@property(nonatomic)int code;//如果处理成功，结果码为0；其他值表示有误（参见错误码说明）
@property(nonatomic,copy)NSString *msg;//错误描述
@property(nonatomic,copy)NSObject *data;//接口返回的数据内容

+(BaseResponse *)getBaseResponseWithDic:(NSDictionary *)dic;
@end
