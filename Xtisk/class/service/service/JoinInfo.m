//
//  JoinInfo.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "JoinInfo.h"

@implementation JoinInfo

+(JoinInfo *)getJoinInfoWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    
    JoinInfo *fi = [[JoinInfo alloc]init];
    fi.joinName = [dic objectForKey:@"joinName"];
    fi.joinPhone = [dic objectForKey:@"joinPhone"];
    fi.joinGender = [dic objectForKey:@"joinGender"];
    fi.joinEmail = [dic objectForKey:@"joinEmail"];
    
    return fi;
}
@end
