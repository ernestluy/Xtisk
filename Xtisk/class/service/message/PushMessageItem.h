//
//  PushMessageItem.h
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property(nonatomic)int _id;
@property(nonatomic,copy)NSString *msgType;
@property(nonatomic,copy)NSString *serviceTitle;
@property(nonatomic,copy)NSString *productId;
@property(nonatomic,copy)NSString *msgText;
@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *server_date;
//@property(nonatomic,copy)NSString *serviceTitle;



+(NSString *)getInsertSqlWithItem:(PushMessageItem *)item;

+(NSArray *)getInsertSqlsWithArr:(NSArray *)arr;
@end
