//
//  PeopleInfo.m
//  Xtisk
//
//  Created by 卢一 on 15/3/14.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "PeopleInfo.h"

@implementation PeopleInfo

+(PeopleInfo *)getPeopleInfoWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    PeopleInfo *info = [[PeopleInfo alloc]init];
    info.phone = [dic objectForKey:@"phone"];
    info.name = [dic objectForKey:@"name"];
    info.email = [dic objectForKey:@"email"];
    info.identity_card = [dic objectForKey:@"identity_card"];
    
    return info;
}
@end
