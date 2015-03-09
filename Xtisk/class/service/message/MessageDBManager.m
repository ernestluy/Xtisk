//
//  MessageDBManager.m
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MessageDBManager.h"


@implementation DBManager(MessageDBManager)





+(int)executeSqlsWithArray:(NSArray *)sqlArr{
    return [DBManager updateWithSqls:sqlArr inDBOfPath:kDATABASE_REAL_PATH];
}


#pragma mark - PushMessageItem
+(PushMessageItem *)queryPushMessageItemWithId:(NSString *)pId{
    NSString *sql = [NSString stringWithFormat:@"select * from push_msg where  n.user_id = push_msg.productId = '%@'",pId];
    //NSLog(@"sql:%@",sql);
    FMDatabase* myDB = [FMDatabase databaseWithPath:kDATABASE_REAL_PATH];
    FMResultSet *rs = nil;
    if ([myDB open]) {
        /*
         _id					 INTEGER primary key autoincrement,
         msgType              varchar(10),
         productId			 varchar(10),
         msgText              varchar(500),
         account              varchar(40),
         create_date          varchar(20),
         server_date          varchar(40)
         */
        rs = [myDB executeQuery:sql];
        if (rs) {
            if ([rs next]) {
                PushMessageItem *pi = [[PushMessageItem alloc] init];
                pi.sid = [rs intForColumn:@"sid"];
                pi.pid = [rs intForColumn:@"pid"];
                pi.type = [rs stringForColumn:@"type"];
                pi.content = [rs stringForColumn:@"content"];
                pi.account = [rs stringForColumn:@"account"];
                pi.loc_create_date = [rs stringForColumn:@"loc_create_date"];
                pi.dateCreate = [rs stringForColumn:@"dateCreate"];
                pi.isRead = [rs intForColumn:@"isRead"];
                [rs close];
                [myDB close];
                return pi;
            }
            
        }
        [myDB close];
    }else{
        NSLog(@"queryPushMessageItemWithId open faile");
    }
    return nil;
}

+(NSString *)getInsertSqlWithPushMessageItem:(PushMessageItem *)item{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:kDateTimeFormat];
    }
    if (nil == item.dateCreate) {
        item.dateCreate = [dateFormatter stringFromDate:[NSDate date]];
    }
    if (nil == item.loc_create_date) {
        item.loc_create_date = [dateFormatter stringFromDate:[NSDate date]];
    }
    NSString *sql = [NSString stringWithFormat:@"insert into push_msg(pid,type,content,account,loc_create_date,dateCreate,isRead) values(%d,'%@','%@','%@','%@','%@',%d)",item.pid,item.type,item.content,item.account,item.loc_create_date,item.dateCreate,item.isRead];
    return sql;
}

+(NSArray *)getInsertPushMessageItemsSqlsWithArr:(NSArray *)arr{
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (int i = 0; i<arr.count; i++) {
        PushMessageItem *item = [arr objectAtIndex:i];
        [mArr addObject:[DBManager getInsertSqlWithPushMessageItem:item]];
    }
    return mArr;
}

+(int)insertPushMessageItems:(NSArray *)arr{
    if (arr == nil || arr.count == 0) {
        return 0;
    }
    NSArray *sqlsArr = [DBManager getInsertPushMessageItemsSqlsWithArr:arr];
    int intOk = [DBManager executeSqlsWithArray:sqlsArr];
    return intOk;
}

+(NSArray *)queryPushMessageItemWithAccount:(NSString *)account{
    if (!account || account.length == 0) {
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from push_msg where account='%@' order by dateCreate asc",account];
    NSMutableArray *mArr = [NSMutableArray array];
    FMDatabase* myDB = [FMDatabase databaseWithPath:kDATABASE_REAL_PATH];
    FMResultSet *rs = nil;
    if ([myDB open]) {
        
        rs = [myDB executeQuery:sql];
        if (rs) {
            while ([rs next]) {
                PushMessageItem *pi = [[PushMessageItem alloc] init];
                pi.sid = [rs intForColumn:@"sid"];
                pi.pid = [rs intForColumn:@"pid"];
                pi.type = [rs stringForColumn:@"type"];
                pi.content = [rs stringForColumn:@"content"];
                pi.account = [rs stringForColumn:@"account"];
                pi.loc_create_date = [rs stringForColumn:@"loc_create_date"];
                pi.dateCreate = [rs stringForColumn:@"dateCreate"];
                pi.isRead = [rs intForColumn:@"isRead"];
                [mArr addObject:pi];
            }
            
        }
        [myDB close];
    }else{
        NSLog(@"queryPushMessageItemWithAccount open faile");
    }
    return mArr;
}

/*
 @"select * from (select *from im_chat_message where conversationId=? order by id desc limit limit ?,? ) t order by t.id asc;
 */
+(NSArray *)queryRecentMessagesWithSid:(int)sid account:(NSString *)account{
//    #define DefaultPageSize 20
    
    if (!account || account.length == 0) {
        return nil;
    }
    if (sid == -1) {
        sid = 10000000;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select * from (select * from push_msg where account='%@' and sid<%d order by dateCreate desc limit %d) order by dateCreate asc",account,sid,DefaultMsgPageSize];
    NSMutableArray *mArr = [NSMutableArray array];
    FMDatabase* myDB = [FMDatabase databaseWithPath:kDATABASE_REAL_PATH];
    FMResultSet *rs = nil;
    if ([myDB open]) {
        
        rs = [myDB executeQuery:sql];
        if (rs) {
            while ([rs next]) {
                PushMessageItem *pi = [[PushMessageItem alloc] init];
                pi.sid = [rs intForColumn:@"sid"];
                pi.pid = [rs intForColumn:@"pid"];
                pi.type = [rs stringForColumn:@"type"];
                pi.content = [rs stringForColumn:@"content"];
                pi.account = [rs stringForColumn:@"account"];
                pi.loc_create_date = [rs stringForColumn:@"loc_create_date"];
                pi.dateCreate = [rs stringForColumn:@"dateCreate"];
                pi.isRead = [rs intForColumn:@"isRead"];
                [mArr addObject:pi];
            }
            
        }
        [myDB close];
    }else{
        NSLog(@"queryPushMessageItemWithAccount open faile");
    }
    return mArr;
    
   
}


+(int)queryCountUnReadMsgWithAccount:(NSString *)account{
    int count=0;
    NSString *sql=[NSString stringWithFormat:@"select count(1) count from push_msg where account='%@' and isRead = 0",account];
    FMDatabase * db = [FMDatabase databaseWithPath:kDATABASE_REAL_PATH];
    if ([db open]) {
        FMResultSet * rs = [db executeQuery:sql];
        if([rs next])
        {
            count= [rs intForColumn:@"count"];
        }
        
        [rs close];
    }
    [db close];
    return count;
}

+(BOOL)updateMsgIsReadWithAccount:(NSString *)account{
   
    NSString *sql=[NSString stringWithFormat: @"update   push_msg  set isRead= 1 where account='%@'",account];
    
    BOOL ret=  [DBManager updateWithSql:sql inDBOfPath:kDATABASE_REAL_PATH];
    if(!ret) return NO;
    
    return ret;
}
@end