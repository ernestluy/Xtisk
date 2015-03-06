//
//  MessageDBManager.m
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MessageDBManager.h"


@implementation DBManager(MessageDBManager)



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
                pi._id = [rs intForColumn:@"_id"];
                pi.msgType = [rs stringForColumn:@"msgType"];
                pi.productId = [rs stringForColumn:@"productId"];
                pi.msgText = [rs stringForColumn:@"msgText"];
                pi.account = [rs stringForColumn:@"account"];
                pi.create_date = [rs stringForColumn:@"create_date"];
                pi.server_date = [rs stringForColumn:@"server_date"];
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

+(int)executeSqlsWithArray:(NSArray *)sqlArr{
    return [DBManager updateWithSqls:sqlArr inDBOfPath:kDATABASE_REAL_PATH];
}

@end