//
//  IUser.m
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "IUser.h"

@implementation IUser


+(IUser *)getIUserWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    IUser *iuser = [[IUser alloc]init];
    iuser.JSESSIONID   = [IUser getValueFromKey:dic key:@"JSESSIONID"];//  [dic objectForKey:@"JSESSIONID"];
    iuser.phone        = [IUser getValueFromKey:dic key:@"phone"];// [dic objectForKey:@"phone"];
    iuser.headImageUrl = [IUser getValueFromKey:dic key:@"headImageUrl"];// [dic objectForKey:@"headImageUrl"];
    iuser.nickName     = [IUser getValueFromKey:dic key:@"nickName"];// [dic objectForKey:@"nickName"];
    iuser.signature    = [IUser getValueFromKey:dic key:@"signature"];// [dic objectForKey:@"signature"];
    iuser.gender       = [IUser getValueFromKey:dic key:@"gender"];// [dic objectForKey:@"gender"];
    iuser.birthday     = [IUser getValueFromKey:dic key:@"birthday"];// [dic objectForKey:@"birthday"];
    iuser.maritalStatus= [IUser getValueFromKey:dic key:@"maritalStatus"];// [dic objectForKey:@"maritalStatus"];
    iuser.enterprise   = [IUser getValueFromKey:dic key:@"enterprise"];// [dic objectForKey:@"enterprise"];
    iuser.deviceId   = [IUser getValueFromKey:dic key:@"deviceId"];
    return iuser;
}
+(NSString *)getValueFromKey:(NSDictionary *)dic key:(NSString *)key{
    NSString *tStr = [dic objectForKey:key];
    if (tStr == nil) {
        return @"";
    }
    return tStr;
}
@end
