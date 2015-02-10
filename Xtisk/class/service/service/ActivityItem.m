//
//  ActivityItem.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem


+(NSArray *)getActivityItemsWithArr:(NSArray *)arr{
    
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        ActivityItem * ci = [[ActivityItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.activityId = [dic objectForKey:@"activityId"];
        ci.activityTitle = [dic objectForKey:@"activityTitle"];
        ci.activityTime = [dic objectForKey:@"activityTime"];
        ci.activityPic = [dic objectForKey:@"activityPic"];
        ci.favorite = [[dic objectForKey:@"favorite"] intValue];
        ci.activityBeginTime = [dic objectForKey:@"activityBeginTime"];
        ci.activityEndTime = [dic objectForKey:@"activityEndTime"];
        [mArr addObject:ci];
    }
    return mArr;
}
@end
