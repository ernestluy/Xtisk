//
//  PosterItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PosterItem : NSObject
@property(nonatomic,copy)NSString *posterTitle;
@property(nonatomic,copy)NSString *posterPic;
@property(nonatomic,copy)NSString *posterUrl;


+(void)savePosterData:(NSArray *)arr;
+(NSArray *)getPosterData;
+(NSArray *)getPosterItemsWithArr:(NSArray *)arr;
+(PosterItem *)getPosterItemWithDic:(NSDictionary *)dic;
@end
