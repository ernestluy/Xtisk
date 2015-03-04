//
//  FavoriteItem.m
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FavoriteItem.h"

@implementation FavoriteItem

+(FavoriteItem *)getFavoriteItemWithDic:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    
    FavoriteItem *fi = [[FavoriteItem alloc]init];
    fi.favoritePeople = [[dic objectForKey:@"favoritePeople"] intValue];
    fi.isFavorite = [[dic objectForKey:@"isFavorite"] boolValue];
    
    return fi;
}
@end
