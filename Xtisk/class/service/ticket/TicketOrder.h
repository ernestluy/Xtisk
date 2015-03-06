//
//  TicketOrder.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketOrder : NSObject


@property(nonatomic,copy)NSString *name;//	String	否	用户姓名
@property(nonatomic,copy)NSString *email;//	String	否	用户邮箱
@property(nonatomic,copy)NSString *address;//	String	否	用户地址
@property(nonatomic,copy)NSString *phone;//	String	否	电话号码
@property(nonatomic,copy)NSString *cardNum;//	String	否	提票验证码，3位数字
@property(nonatomic,copy)NSString *lang;//	String	否	语言，C:简体中文 T:繁体中文 E:英文
@property(nonatomic)float total_fee;//	Double	否	总费用
@property(nonatomic)float discount_fee;//	Double	是	优惠金额
@property(nonatomic,copy)NSString *tickets;//	String	否	票信息,多张票组成Json Array,转换成字符串，如：{“tickets”:[{ “seatrank_id”:””,… },
//{“seatrank_id”:””,…}]
//}
//@property(nonatomic,copy)NSString *serviceTitle;
//@property(nonatomic,copy)NSString *serviceTitle;
//@property(nonatomic,copy)NSString *serviceTitle;
//@property(nonatomic,copy)NSString *serviceTitle;

@end
