//
//  MyActivity.m
//  Xtisk
//
//  Created by 卢一 on 15/3/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyActivity.h"

@implementation MyActivity

/*
 {
 "joinDate": "2015-03-04 16:57:08",
 "activityId": 471,
 "activityBeginTime": "2015-03-25 13:51:58",
 "activityTitle": "活动1",
 "activityEndTime": "2015-03-27 13:52:01",
 "activityPic": "upload/common/2015_03_04/126_xx.jpg",
 "status": "Y",
 "favorite": 1,
 "activityTime": "2015-03-04 13:48:37"
 }
 */
+(NSArray *)getMyActivitysWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        MyActivity * ci = [[MyActivity alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.activityId = [[dic objectForKey:@"activityId"] intValue];
        ci.activityTitle = [dic objectForKey:@"activityTitle"];
        ci.activityTime = [dic objectForKey:@"activityTime"];
        ci.activityPic = [dic objectForKey:@"activityPic"];
        ci.favorite = [[dic objectForKey:@"favorite"] intValue];
        ci.activityBeginTime = [dic objectForKey:@"activityBeginTime"];
        ci.activityEndTime = [dic objectForKey:@"activityEndTime"];
        ci.status = [dic objectForKey:@"status"];
        ci.joinDate = [dic objectForKey:@"joinDate"];

        [mArr addObject:ci];
    }
    return mArr;
    
}
@end
