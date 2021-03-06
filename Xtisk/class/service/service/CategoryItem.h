//
//  categoryItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject
@property(nonatomic)long categoryId;//	String	否	分类编号
@property(nonatomic,copy)NSString *categoryName;//	String	否	分类名称
@property(nonatomic,copy)NSString *categoryImageUrl;//	String	是	分类图像URL
@property(nonatomic,strong)NSArray *childList;//	Json Array	是	该分类的子分类，若分类下面还有子分类，则子分类的内容结构同父分类内容结构

@property(nonatomic)BOOL valid;

+(NSArray *)getCategoryItemsWithArr:(NSArray *)arr;
+(CategoryItem *)getCategoryItemWithDic:(NSDictionary *)dic;
+(CategoryItem *)createRootCategory;
@end
