//
//  MenuItem.m
//  Xtisk
//
//  Created by zzt on 15/2/26.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem


+(NSArray *)getMenuItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        MenuItem * ci = [[MenuItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.menuId = [dic objectForKey:@"menuId"];
        ci.menuName = [dic objectForKey:@"menuName"];
        ci.menuUrl = [dic objectForKey:@"menuUrl"];
        ci.recomNumber = [[dic objectForKey:@"recomNumber"]intValue];
        ci.menuPrice = [[dic objectForKey:@"menuPrice"] floatValue];
        ci.strMenuPrice = [[dic objectForKey:@"menuPrice"] stringValue];
        
        [mArr addObject:ci];
    }
    return mArr;
}
@end
