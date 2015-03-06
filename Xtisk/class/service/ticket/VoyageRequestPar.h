//
//  VoyageRequestPar.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoyageRequestPar : NSObject

@property(nonatomic,copy)NSString *sailDate;//	String	否	开航日期，日期格式为:yyyy-mm-dd
@property(nonatomic,copy)NSString *sailDateReturn;//	String	是	回程日期，日期格式为：yyyy-mm-dd
@property(nonatomic,copy)NSString *fromPortCode;//	String	否	始发港代码
@property(nonatomic,copy)NSString *toPortCode;//	String	否	目的港代码
@property(nonatomic,copy)NSString *fromPortCodeReturn;//	String	是	回程始发港代码
@property(nonatomic,copy)NSString *toPortCodeReturn;//	String	是	回程目的港代码
@property(nonatomic,copy)NSString *currencyCode;//	String	否	货币代码，HKD:港币  RMB:人民币 MOP:澳门币
@property(nonatomic,copy)NSString *isRoundtrip;//	String	否	是否双程，1:是 0:否
@property(nonatomic,copy)NSString *lang;//	String	否	语言类型，C:简体中文 T:繁体中文 E:英文
//@property(nonatomic,copy)NSString *serviceTitle;
@end
