//
//  MessageDBManager.h
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "PublicDefine.h"
@interface DBManager(MessageDBManager)


+(int)executeSqlsWithArray:(NSArray *)sqlArr;

#pragma mark - PushMessageItem
+(PushMessageItem *)queryPushMessageItemWithId:(NSString *)pId;
+(PushMessageItem *)queryPushMessageItemLastOneWithAccount:(NSString *)accoutn;
+(NSString *)getInsertSqlWithPushMessageItem:(PushMessageItem *)item;
+(NSArray *)getInsertPushMessageItemsSqlsWithArr:(NSArray *)arr;
+(int)insertPushMessageItems:(NSArray *)arr;
+(NSArray *)queryPushMessageItemWithAccount:(NSString *)account;
+(NSArray *)queryRecentMessagesWithSid:(int)sid account:(NSString *)account;

+(int)queryCountUnReadMsgWithAccount:(NSString *)account;
+(BOOL)updateMsgIsReadWithAccount:(NSString *)account;
@end
