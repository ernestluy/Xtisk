//
//  MenuItem.h
//  Xtisk
//
//  Created by zzt on 15/2/26.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
//用于http请求的的业务类
@interface MenuItem : NSObject

@property(nonatomic,copy)NSString *menuId;//	String	否	菜品ID
@property(nonatomic,copy)NSString *menuName;//	String	否	菜品名称
@property(nonatomic,copy)NSString *menuUrl;//	String	否	菜品图片URL地址
@property(nonatomic)int recomNumber;//	Int	否	菜品推荐指数(0-5)
@property(nonatomic)float menuPrice;//	Double	否	菜品价格
@property(nonatomic,copy)NSString *strMenuPrice;//	菜品价格


//获取列表
+(NSArray *)getMenuItemsWithArr:(NSArray *)arr;
@end
