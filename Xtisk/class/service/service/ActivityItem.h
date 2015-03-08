//
//  ActivityItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityItem : NSObject
/*
 {
 "activityId": 471,
 "activityBeginTime": "2015-03-25 13:51:58",
 "activityTitle": "活动1",
 "activityEndTime": "2015-03-27 13:52:01",
 "activityPic": "upload/common/2015_03_04/126_xx.jpg",
 "favorite": 0,
 "activityTime": "2015-03-04 13:48:37"
 }
 */
@property(nonatomic)int activityId;
@property(nonatomic,copy)NSString *activityTitle;
@property(nonatomic,copy)NSString *activityTime;//活动发布时间
@property(nonatomic,copy)NSString *activityPic;//活动缩略图URL地址
@property(nonatomic)int favorite;//点赞人数
@property(nonatomic,copy)NSString *activityBeginTime;
@property(nonatomic,copy)NSString *activityEndTime;

/*
 {
 "reviews": 0,
 "isFull": false,
 "activityPic": "upload/common/2015_03_04/692_01.gif",
 "activityInfo": "<img src=\"/ipop_tms/upload/common/2015_03_04/691_liulan_icon.png\" alt=\"\" />我要金克拉",
 "activityBeginJoinTime": "2015-03-07 13:52:54",
 "favorite": 0,
 "activityId": 478,
 "activityBeginTime": "2015-03-18 13:53:01",
 "activityTitle": "活动5",
 "activityEndTime": "2015-03-20 13:53:04",
 "isFavorite": false,
 "activityEndJoinTime": "2015-03-10 13:52:58",
 "allowJoin": false,
 "allowReview": true,
 "activityTime": "2015-03-04 13:49:40",
 "isJoin": false
 }

 */
@property(nonatomic)int reviews;//	Int	否	评论数
@property(nonatomic)BOOL isFull;//	Boolean	否	是否报名已满（true|false）
@property(nonatomic,copy)NSString *activityInfo;//	String	否	活动详情
@property(nonatomic,copy)NSString *activityBeginJoinTime;//	String	是	活动报名开始时间
@property(nonatomic)BOOL isFavorite;//	Boolean	否	是否已点赞（true|false）
@property(nonatomic,copy)NSString *activityEndJoinTime;//	String	是	活动报名结束时间
@property(nonatomic)BOOL allowJoin;//	Boolean	否	是否允许报名（true|false）
@property(nonatomic)BOOL allowReview;//	Boolean	否	是否允许评论（true|false）
@property(nonatomic)BOOL isJoin;//	Boolean	否	是否已报名（true|false）

@property(nonatomic,copy)NSString *shareUrl;

+(NSArray *)getActivityItemsWithArr:(NSArray *)arr;
+(ActivityItem *)getActivityItemWithDic:(NSDictionary *)dic;


-(ActivityItem *)aClone;
@end
