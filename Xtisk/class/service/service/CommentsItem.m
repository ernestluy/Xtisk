//
//  CommentsItem.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CommentsItem.h"

@implementation CommentsItem


+(NSArray *)getCommentsItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        CommentsItem * ci = [[CommentsItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.commentsId = [dic objectForKey:@"commentsId"];
        ci.content = [dic objectForKey:@"content"];
        ci.commentsTime = [dic objectForKey:@"commentsTime"];
        ci.activityId = [dic objectForKey:@"activityId"];
        ci.activityId = [dic objectForKey:@"storeId"];
        ci.userName = [dic objectForKey:@"userName"];
        [mArr addObject:ci];
    }
    return mArr;
}
@end
