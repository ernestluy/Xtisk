//
//  PushMessageItem.m
//  Xtisk
//
//  Created by zzt on 15/3/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "PushMessageItem.h"
#import "PublicDefine.h"
@implementation PushMessageItem

/*
 _id					 INTEGER primary key autoincrement,
 msgType              varchar(10),
 productId			 varchar(10),
 msgText              varchar(500),
 account              varchar(40),
 create_date          varchar(20),
 server_date          varchar(40)
 */
+(NSString *)getInsertSqlWithItem:(PushMessageItem *)item{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:kDateTimeFormat];
    }
    if (nil == item.server_date) {
        item.server_date = [dateFormatter stringFromDate:[NSDate date]];
    }
    if (nil == item.create_date) {
        item.create_date = [dateFormatter stringFromDate:[NSDate date]];
    }
    NSString *sql = [NSString stringWithFormat:@"insert into push_msg(msgType,productId,msgText,account,create_date,server_date) values('%@','%@','%@','%@','%@','%@')",item.msgType,item.msgType,item.msgType,item.msgType,item.create_date,item.server_date];
    return sql;
}

+(NSArray *)getInsertSqlsWithArr:(NSArray *)arr{
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (int i = 0; i<mArr.count; i++) {
        PushMessageItem *item = [mArr objectAtIndex:i];
        [mArr addObject:[PushMessageItem getInsertSqlWithItem:item]];
    }
    return mArr;
}
@end
