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
    iuser.JSESSIONID   = [dic objectForKey:@"JSESSIONID"];
    iuser.phone        = [dic objectForKey:@"phone"];
    iuser.headImageUrl = [dic objectForKey:@"headImageUrl"];
    iuser.nickName     = [dic objectForKey:@"nickName"];
    iuser.signature    = [dic objectForKey:@"signature"];
    iuser.gender       = [dic objectForKey:@"gender"];
    iuser.birthday     = [dic objectForKey:@"birthday"];
    iuser.maritalStatus= [dic objectForKey:@"maritalStatus"];
    iuser.enterprise   = [dic objectForKey:@"enterprise"];
    return iuser;
}
@end
