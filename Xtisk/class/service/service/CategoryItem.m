//
//  categoryItem.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CategoryItem.h"

@implementation CategoryItem

+(NSArray *)getCategoryItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        CategoryItem * ci = [[CategoryItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.categoryId = [dic objectForKey:@"categoryId"];
        ci.categoryName = [dic objectForKey:@"categoryName"];
        ci.categoryImageUrl = [dic objectForKey:@"categoryImageUrl"];
        [mArr addObject:ci];
    }
    return mArr;
}
@end
