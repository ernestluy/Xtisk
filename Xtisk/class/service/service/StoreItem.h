//
//  StoreItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//
/*
 {
 "storeName": "餐厅1",
 "storeInfo": "介绍",
 "storeMiniPic": "upload/common/2015_03_02/308_qr-code.jpg",
 "storeAddress": "地址2",
 "storePhone": "15208376070",
 "recomDishes": [
 {
 "recomNumber": "5",
 "menuUrl": "upload/common/2015_03_02/388_2.png",
 "menuPrice": 40,
 "menuId": 185,
 "menuName": "酱鸭子"
 }
 ],
 "storeOpenTime": "06:00",
 "price": "8",
 "favoritePeople": 0,
 "isFavorite": false,
 "keyWords": "炒饭",
 "storeCloseTime": "18:00",
 "storeId": 166
 }
 */
#import <Foundation/Foundation.h>

@interface StoreItem : NSObject
//列表获取的信息
@property(nonatomic)int storeId;//	String	否	店铺ID
@property(nonatomic,copy)NSString *storeName;//	String	否	店铺名称
@property(nonatomic,copy)NSString *keyWords;//	String	否	关键字
@property(nonatomic)double price;//	Double	否	起送价格
@property(nonatomic,copy)NSString *strPrice;//	Double	否	起送价格
@property(nonatomic)int favoritePeople;//	Int	否	点赞人数
@property(nonatomic,copy)NSString *storeMiniPic;//	String	否	店铺缩略图URL地址
@property(nonatomic)int reviews;//	评论数

//详情
@property(nonatomic,copy)NSString *storeOpenTime;//	String	否	每天营业开始时间
@property(nonatomic,copy)NSString *storeCloseTime;//	String	否	每天营业结束时间
@property(nonatomic,copy)NSString *storeInfo;//	String	否	店铺介绍
@property(nonatomic,copy)NSString *storePhone;//	String	否	店铺电话
@property(nonatomic,copy)NSString *storeAddress;//	String	否	店铺地址
@property(nonatomic)BOOL isFavorite;//	Boolean	否	是否已点赞（true|false）

@property(nonatomic)float longitude;//	经度
@property(nonatomic)float latitude;//	纬度

@property(nonatomic,copy)NSArray *recomDishes;//	Json Array	否	推荐菜品信息列表

//获取商家列表
+(NSArray *)getStoreItemsWithArr:(NSArray *)arr;

//获取商家详情
+(StoreItem *)getStoreItemWith:(NSDictionary *)dic;
@end
