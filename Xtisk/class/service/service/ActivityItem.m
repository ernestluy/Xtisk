//
//  ActivityItem.m
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityItem.h"
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
@implementation ActivityItem

-(id)init{
    self = [super init];
    
    self.allowJoin = YES;
    return self;
}

+(NSArray *)getActivityItemsWithArr:(NSArray *)arr{
    
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        ActivityItem * ci = [[ActivityItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.activityId = [[dic objectForKey:@"activityId"]intValue];
        ci.activityTitle = [dic objectForKey:@"activityTitle"];
        ci.activityTime = [dic objectForKey:@"activityTime"];
        ci.activityPic = [dic objectForKey:@"activityPic"];
        ci.favorite = [[dic objectForKey:@"favorite"] intValue];
        ci.activityBeginTime = [dic objectForKey:@"activityBeginTime"];
        ci.activityEndTime = [dic objectForKey:@"activityEndTime"];
        ci.isFull = [[dic objectForKey:@"isFull"] boolValue];
        ci.allowJoin = [[dic objectForKey:@"allowJoin"] boolValue];
        [mArr addObject:ci];
    }
    return mArr;
}


+(ActivityItem *)getActivityItemWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    ActivityItem * ci = [[ActivityItem alloc]init];
    ci.activityId = [[dic objectForKey:@"activityId"]intValue];
    ci.activityTitle = [dic objectForKey:@"activityTitle"];
    ci.activityTime = [dic objectForKey:@"activityTime"];
    ci.activityPic = [dic objectForKey:@"activityPic"];
    ci.favorite = [[dic objectForKey:@"favorite"] intValue];
    ci.activityBeginTime = [dic objectForKey:@"activityBeginTime"];
    ci.activityEndTime = [dic objectForKey:@"activityEndTime"];
    /*
     @property(nonatomic)int reviews;//	Int	否	评论数
     @property(nonatomic)BOOL isFull;//	Boolean	否	是否报名已满（true|false）
     @property(nonatomic,copy)NSString *activityInfo;//	String	否	活动详情
     @property(nonatomic,copy)NSString *activityBeginJoinTime;//	String	是	活动报名开始时间
     @property(nonatomic)BOOL isFavorite;//	Boolean	否	是否已点赞（true|false）
     @property(nonatomic,copy)NSString *activityEndJoinTime;//	String	是	活动报名结束时间
     @property(nonatomic)BOOL allowJoin;//	Boolean	否	是否允许报名（true|false）
     @property(nonatomic)BOOL allowReview;//	Boolean	否	是否允许评论（true|false）
     @property(nonatomic)BOOL isJoin;//	Boolean	否	是否已报名（true|false）
     */
    ci.reviews = [[dic objectForKey:@"reviews"]intValue];
    ci.isFull = [[dic objectForKey:@"isFull"] boolValue];
    ci.activityInfo = [dic objectForKey:@"activityInfo"];
    ci.activityBeginJoinTime = [dic objectForKey:@"activityBeginJoinTime"];
    ci.isFavorite = [[dic objectForKey:@"isFavorite"] boolValue];
    ci.activityEndJoinTime = [dic objectForKey:@"activityEndJoinTime"];
    ci.allowJoin = [[dic objectForKey:@"allowJoin"] boolValue];
    ci.allowReview = [[dic objectForKey:@"allowReview"] boolValue];
    ci.isJoin = [[dic objectForKey:@"isJoin"] boolValue];
    
    ci.shareUrl = [dic objectForKey:@"shareUrl"];
    return ci;
}

-(ActivityItem *)aClone{
    ActivityItem *ci = [[ActivityItem alloc]init];
    ci.activityId = self.activityId;
    ci.activityTitle = self.activityTitle;
    ci.activityTime = self.activityTime;
    ci.activityPic = self.activityPic;
    ci.favorite = self.favorite;
    ci.activityBeginTime = self.activityBeginTime;
    ci.activityEndTime = self.activityEndTime;
    ci.reviews = self.reviews;
    ci.isFull = self.isFull;
    ci.activityInfo = self.activityInfo;
    ci.activityBeginJoinTime = self.activityBeginJoinTime;
    ci.isFavorite = self.isFavorite;
    ci.activityEndJoinTime = self.activityEndJoinTime;
    ci.allowJoin = self.allowJoin;
    ci.allowReview = self.allowReview;
    ci.isJoin = self.isJoin;
    
    ci.shareUrl = ci.shareUrl;
    return ci;
}
@end
