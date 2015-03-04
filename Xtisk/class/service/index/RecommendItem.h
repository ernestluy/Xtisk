//
//  RecommendItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendItem : NSObject

@property(nonatomic,copy)NSString *recomPic;
@property(nonatomic,copy)NSString *recomUrl;
+(NSArray *)getRecommendItemsWithArr:(NSArray *)arr;
@end
