//
//  FavoriteItem.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteItem : NSObject
@property(nonatomic)int favoritePeople;//	Int	否	感兴趣人数
@property(nonatomic)BOOL isFavorite;//	Boolean	否	是否已感兴趣(true|false)，如果已经点赞，调用该接口就变为未点赞，反之变为已点赞。

+(FavoriteItem *)getFavoriteItemWithDic:(NSDictionary *)dic;
@end
