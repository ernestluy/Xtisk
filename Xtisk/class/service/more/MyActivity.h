//
//  MyActivity.h
//  Xtisk
//
//  Created by 卢一 on 15/3/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityItem.h"
@interface MyActivity : ActivityItem

//@property(nonatomic)int activityId;//	String	否	活动ID
//@property(nonatomic,copy)NSString *activityTitle;//	String	否	活动标题
//@property(nonatomic,copy)NSString *activityTime;//	Stirng	否	活动发布时间
//@property(nonatomic,copy)NSString *activityPic;//	Stirng	是	活动缩略图URL地址
//@property(nonatomic)int favorite;//	Int	否	点赞人数
//@property(nonatomic,copy)NSString *activityBeginTime;//	String	是	活动开始时间
//@property(nonatomic,copy)NSString *activityEndTime;//	Stirng	是	活动结束时间
@property(nonatomic,copy)NSString *status;//	String	是	活动状态
@property(nonatomic,copy)NSString *joinDate;//	String	否	用户报名时间
//@property(nonatomic,copy)NSString *type;

+(NSArray *)getMyActivitysWithArr:(NSArray *)arr;
@end
