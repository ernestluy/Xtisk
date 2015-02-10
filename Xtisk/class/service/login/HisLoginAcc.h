//
//  HisLoginAcc.h
//  ;
//
//  Created by zzt on 15/2/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HisLoginAcc : NSObject


@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *psd;
@property(nonatomic,retain)UIImage *headerIcon;
@property(nonatomic)BOOL isRmbPsd;
@property(nonatomic,copy)NSString *imgPath;

+(void)saveAccLoginInfo:(HisLoginAcc*)la;
+(NSArray *)getAllAccLoginInfo;

+(NSDictionary *)dictionaryFormatWith:(HisLoginAcc *)la;
+(HisLoginAcc *)hisLoginAccFormatWith:(NSDictionary *)dic;


+(void)saveLastAccLoginInfo:(HisLoginAcc*)la;
+(HisLoginAcc *)getLastAccLoginInfo;
@end
