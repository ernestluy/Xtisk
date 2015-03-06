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


+(PushMessageItem *)queryPushMessageItemWithId:(NSString *)pId;
+(int)executeSqlsWithArray:(NSArray *)sqlArr;
+(NSString *)getInsertSqlWithItem:(PushMessageItem *)item;

+(NSArray *)getInsertSqlsWithArr:(NSArray *)arr;
@end
