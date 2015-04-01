//
//  CommentsItem.m
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CommentsItem.h"
#import <UIKit/UIKit.h>
#import "PublicDefine.h"
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
        //userImg
        ci.userImg = [dic objectForKey:@"userImg"];
        [mArr addObject:ci];
    }
    return mArr;
}

-(int)getCellHeight{
    if (!self.content) {
        return 110;
    }
    int startY = 52;
    CGSize size = [Util sizeForString:self.content fontSize:12 andWidth:274];
    int allHeight = startY + size.height;
    if (allHeight < 110) {
        return 110;
    }
    return size.height + startY + 16;
}
@end
