//
//  StoreItem.h
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreItem : NSObject
@property(nonatomic,copy)NSString *storeId;//	String	否	店铺ID
@property(nonatomic,copy)NSString *storeName;//	String	否	店铺名称
@property(nonatomic,copy)NSString *keyWords;//	String	否	关键字
@property(nonatomic)double price;//	Double	否	起送价格
@property(nonatomic,copy)NSString *strPrice;//	Double	否	起送价格
@property(nonatomic)int favoritePeople;//	Int	否	点赞人数
@property(nonatomic,copy)NSString *storeMiniPic;//	String	否	店铺缩略图URL地址


@property(nonatomic,copy)NSString *storeOpenTime;//	String	否	每天营业开始时间
@property(nonatomic,copy)NSString *storeCloseTime;//	String	否	每天营业结束时间
@property(nonatomic,copy)NSString *storeInfo;//	String	否	店铺介绍
@property(nonatomic,copy)NSString *storePhone;//	String	否	店铺电话
@property(nonatomic,copy)NSString *storeAddress;//	String	否	店铺地址
@property(nonatomic)BOOL isFavorite;//	Boolean	否	是否已点赞（true|false）

//recomDishes	Json Array	否	推荐菜品信息列表
+(NSArray *)getStoreItemsWithArr:(NSArray *)arr;
@end
