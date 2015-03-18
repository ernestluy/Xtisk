//
//  CommentsItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
//活动评价、店铺评价 公用
@interface CommentsItem : NSObject
@property(nonatomic,copy)NSString *commentsId;//String	否	评论ID
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *commentsTime;//	String	否	评论时间，格式：yyyy-MM-dd HH:mm
@property(nonatomic,copy)NSString *activityId;//	String	否	评论所属活动ID
@property(nonatomic,copy)NSString *storeId;//	String	否	评论所属店铺ID
@property(nonatomic,copy)NSString *userName;//	String	否	评论者账号
+(NSArray *)getCommentsItemsWithArr:(NSArray *)arr;

-(int)getCellHeight;
@end
