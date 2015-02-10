//
//  HisLoginAcc.m
//  Xtisk
//
//  Created by zzt on 15/2/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "HisLoginAcc.h"
#define kHisLoginAcc @"kHisLoginAcc"
#define kLastHisLoginAcc @"kLastHisLoginAcc"
@implementation HisLoginAcc
-(id)init{
    self = [super init];
    self.account  = @"";
    self.psd = @"";
    self.isRmbPsd = NO;
    self.imgPath = @"";
    
    return self;
}

+(void)saveAccLoginInfo:(HisLoginAcc*)la{
    NSArray *arr = [HisLoginAcc getAllAccLoginInfo];
    NSMutableArray *mArr = [NSMutableArray array];
    if (arr) {
        [mArr addObjectsFromArray:arr];
    }
    [mArr addObject:[HisLoginAcc dictionaryFormatWith:la]];
    [[NSUserDefaults standardUserDefaults] setObject:mArr forKey:kHisLoginAcc];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(NSArray *)getAllAccLoginInfo{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kHisLoginAcc];
}

+(NSDictionary *)dictionaryFormatWith:(HisLoginAcc *)la{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setObject:la.account forKey:@"account"];
    [mDic setObject:la.psd forKey:@"psd"];
    [mDic setObject:[NSNumber numberWithBool:la.isRmbPsd] forKey:@"isRmbPsd"];
    [mDic setObject:la.imgPath forKey:@"imgPath"];
    return mDic;
}
+(HisLoginAcc *)hisLoginAccFormatWith:(NSDictionary *)dic{
    HisLoginAcc *la = [[HisLoginAcc alloc]init];
    la.account = [dic objectForKey:@"account"];
    la.psd = [dic objectForKey:@"psd"];
    la.isRmbPsd = [[dic objectForKey:@"isRmbPsd"] boolValue];
    la.imgPath = [dic objectForKey:@"imgPath"];
    
    return la;
}

+(void)saveLastAccLoginInfo:(HisLoginAcc*)la{
    NSDictionary *dic = [HisLoginAcc dictionaryFormatWith:la];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kLastHisLoginAcc];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(HisLoginAcc *)getLastAccLoginInfo{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLastHisLoginAcc];;
    HisLoginAcc *la = [HisLoginAcc hisLoginAccFormatWith:dic];
    return la;
}

@end
