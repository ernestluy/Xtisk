//
//  RecommendItem.m
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "RecommendItem.h"

@implementation RecommendItem

+(NSArray *)getRecommendItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        RecommendItem * pi = [[RecommendItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        pi.recomPic = [dic objectForKey:@"recomPic"];
        pi.recomUrl = [dic objectForKey:@"recomUrl"];
        [mArr addObject:pi];
    }
    return mArr;
}
@end
