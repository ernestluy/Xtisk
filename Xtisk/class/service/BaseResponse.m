//
//  BaseResponse.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse


+(BaseResponse *)getBaseResponseWithDic:(NSDictionary *)dic{
    BaseResponse * ci = [[BaseResponse alloc]init];
    if (!dic) {
        ci.code = 1008614;
        ci.msg = @"服务器返回数据异常";
        return ci;
    }
    
    ci.code = [[dic objectForKey:@"code"] intValue];
    ci.msg = [dic objectForKey:@"msg"];
    ci.data = [dic objectForKey:@"data"];

    return ci;
    
}
@end
