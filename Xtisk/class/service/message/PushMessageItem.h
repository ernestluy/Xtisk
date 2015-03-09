//
//  PushMessageItem.h
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PushMessageItem : NSObject
/*
 _id					 INTEGER primary key autoincrement,
 msgType              varchar(10),
 productId			 varchar(10),
 msgText              varchar(500),
 account              varchar(40),
 create_date          varchar(20),
 server_date          varchar(40)
 */
/*
 id	Long	否	消息id
 dateCreate	String	否	发送消息时间
 content	String	否	消息内容
 type	String	否	消息类型：1 ：i蛇口 2：园区活动 3： 船票
 */
@property(nonatomic)int sid;
@property(nonatomic)int pid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *loc_create_date;
@property(nonatomic,copy)NSString *dateCreate;
@property(nonatomic)BOOL isRead;
//@property(nonatomic,copy)NSString *serviceTitle;

@property(nonatomic)CGSize tSize;


+(NSArray *)getPushMessageItemsWithArr:(NSArray *)arr;

+(void)setPushMessageItemsIsRead:(BOOL)b arr:(NSArray *)arr;
@end
