//
//  ActivityItem.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityItem : NSObject

@property(nonatomic,copy)NSString *activityId;
@property(nonatomic,copy)NSString *activityTitle;
@property(nonatomic,copy)NSString *activityTime;
@property(nonatomic,copy)NSString *activityPic;//活动缩略图URL地址
@property(nonatomic)int favorite;//点赞人数
@property(nonatomic,copy)NSString *activityBeginTime;
@property(nonatomic,copy)NSString *activityEndTime;

@property(nonatomic,copy)NSString *status;//	String		活动状态

+(NSArray *)getActivityItemsWithArr:(NSArray *)arr;
@end
