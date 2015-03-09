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
-(id)init{
    self = [super init];
    self.account = [SettingService sharedInstance].iUser.phone;
    self.isRead = NO;
    self.sid = -1;
    return self;
}

/*
 {
 "id": 858,
 "dateUpdate": "2015-03-06 16:33:52",
 "dateCreate": "2015-03-06 16:33:52",
 "status": "Y",
 "content": "323232",
 "pushStatus": "1",
 "type": "1",
 "sum": 3,
 "success": null,
 "failure": null
 }
 */
+(NSArray *)getPushMessageItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        PushMessageItem * ci = [[PushMessageItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.pid = [[dic objectForKey:@"id"] intValue];
        ci.type = [dic objectForKey:@"type"];
        ci.dateCreate = [dic objectForKey:@"dateCreate"];
        ci.content = [dic objectForKey:@"content"];
        
        
//        ci.account = [dic objectForKey:@"account"];
//        ci.create_date = [dic objectForKey:@"create_date"];
//        ci.server_date = [dic objectForKey:@"server_date"];
        
        
        [mArr addObject:ci];
    }
    return mArr;
}

+(void)setPushMessageItemsIsRead:(BOOL)b arr:(NSArray *)arr{
    if (!arr) {
        return;
    }
    for (int i = 0; i<arr.count;i++) {
        PushMessageItem * ci = [arr objectAtIndex:i];
        ci.isRead = YES;
    }
}
@end
