//
//  categoryItem.m
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
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
        ci.categoryId = [[dic objectForKey:@"categoryId"] longValue];
        ci.categoryName = [dic objectForKey:@"categoryName"];
        
        NSDictionary *imgDic = [dic objectForKey:@"categoryImageUrl"];
        if (imgDic) {
            ci.categoryImageUrl = [imgDic objectForKey:@"ios"];
        }
        
        NSArray *tmpArr = [dic objectForKey:@"childList"];
        if (tmpArr && [tmpArr isKindOfClass:[NSArray class]]) {
            ci.childList = [CategoryItem getCategoryItemsWithArr:tmpArr];
        }
        [mArr addObject:ci];
    }
    return mArr;
}

+(CategoryItem *)getCategoryItemWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    CategoryItem * ci = [[CategoryItem alloc]init];
    ci.categoryId = [dic objectForKey:@"categoryId"];
    ci.categoryName = [dic objectForKey:@"categoryName"];
    ci.categoryImageUrl = [dic objectForKey:@"categoryImageUrl"];
    NSArray *tmpArr = [dic objectForKey:@"childList"];
    if (tmpArr && [tmpArr isKindOfClass:[NSArray class]]) {
        ci.childList = [CategoryItem getCategoryItemsWithArr:tmpArr];
    }
    return ci;
}


+(CategoryItem *)createRootCategory{
    CategoryItem *item = [[CategoryItem alloc]init];
    item.childList = @[];
    item.categoryName = @"周 边";
    return item;
}
@end
