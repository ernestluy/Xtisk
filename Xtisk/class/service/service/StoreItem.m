//
//  StoreItem.m
//  Xtisk
//
//  Created by zzt on 15/2/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "StoreItem.h"
#import "PublicDefine.h"
@implementation StoreItem

/*
 {"code":0,"msg":"","data":{"total":1,"storeList":[{"reviews":0,"price":"8","storeName":"餐厅1","favoritePeople":0,"storeMiniPic":"upload/common/2015_03_02/308_qr-code.jpg","keyWords":"炒饭","storeId":166}]}}
 */
+(NSArray *)getStoreItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        StoreItem * ci = [[StoreItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        ci.storeId = [dic objectForKey:@"storeId"];
        ci.storeName = [dic objectForKey:@"storeName"];
        ci.price = [[dic objectForKey:@"price"] doubleValue];
        ci.strPrice = [dic objectForKey:@"price"] ;
        ci.keyWords = [dic objectForKey:@"keyWords"];
        ci.favoritePeople = [[dic objectForKey:@"favoritePeople"]intValue];
        ci.storeMiniPic = [dic objectForKey:@"storeMiniPic"];
        ci.reviews = [[dic objectForKey:@"reviews"] intValue];
        
        ci.storeOpenTime = [dic objectForKey:@"storeOpenTime"];
        ci.storeCloseTime = [dic objectForKey:@"storeCloseTime"];
        ci.storeInfo = [dic objectForKey:@"storeInfo"];
        ci.storePhone = [dic objectForKey:@"storePhone"];
        ci.storeAddress = [dic objectForKey:@"storeAddress"];
        ci.isFavorite = [[dic objectForKey:@"isFavorite"] boolValue];
        
        
        
        [mArr addObject:ci];
    }
    return mArr;
}

+(StoreItem *)getStoreItemWith:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    StoreItem * ci = [[StoreItem alloc]init];
    ci.storeId = [[dic objectForKey:@"storeId"] intValue];
    ci.storeName = [dic objectForKey:@"storeName"];
    ci.price = [[dic objectForKey:@"price"] doubleValue];
    ci.strPrice = [dic objectForKey:@"price"];
    ci.keyWords = [dic objectForKey:@"keyWords"];
    ci.favoritePeople = [[dic objectForKey:@"favoritePeople"]intValue];
    ci.storeMiniPic = [dic objectForKey:@"storeMiniPic"];
    ci.reviews = [[dic objectForKey:@"reviews"]intValue];
    
    ci.storeOpenTime = [dic objectForKey:@"storeOpenTime"];
    ci.storeCloseTime = [dic objectForKey:@"storeCloseTime"];
    ci.storeInfo = [dic objectForKey:@"storeInfo"];
    ci.storePhone = [dic objectForKey:@"storePhone"];
    ci.storeAddress = [dic objectForKey:@"storeAddress"];
    ci.isFavorite = [[dic objectForKey:@"isFavorite"] boolValue];
    
    NSArray *tmpArr = [dic objectForKey:@"recomDishes"];
    if (tmpArr) {
        ci.recomDishes = [MenuItem getMenuItemsWithArr:tmpArr];
    }
    return ci;
}
@end
