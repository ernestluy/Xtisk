//
//  UcmDefine.h
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

enum UCM_SYNC_ERROR_CODE{
    UCM_SUCCESS	= 0x00000000,   //操作成功
    
    UCM_RESULT = 0x00000001,
    
    INVALID_INPUT = 0x80000001,   //输入内容错误
    
    TOKEN_EXPIRED = 0x80000002,   //令牌无效或已过期
    
    ACCESS_DENIED = 0x80000003,   //拒绝访问（权限不足）
    
    SERVER_NOT_READY = 0x80000004,   //服务器未就绪
    
    INTERNAL_ERROR = 0x80000005,   //服务器内部错误
    
    RECORD_NOT_FOUND = 0x80000006,  //记录不存在
    
    ORG_DUPLICATE_CODE = 0x80001001,   //组织代码重复
    
    LOGIN_ID_ERROR = 0x80002001,   //登录帐号无效
    
    LOGIN_PASSWORD_ERROR = 0x80002002,   //登录密码无效
    
    LOGIN_ACCOUNT_DISABLED = 0x80002003,   //登录帐号已被禁用
    
    USER_DUPLICATE_LOGIN_ID	= 0x80002004,   //用户登录帐号重复
    
    INVALID_CURRENT_PASSWORD = 0x80002005,   //当前密码不正确
    
    INVALID_NEW_PASSWORD = 0x80002006,    //新密码无效
};

enum CONTACT_TYPE_GUI                       // 联系方式类型
{
    OFFICE_TEL                          = 0,                            // 办公电话（如：26775067）
    OFFICE_INLINE_TEL                   = 1,                           // 办公内线电话（如：5067）
    OFFICE_MOBILE_TEL                   = 2,                            // 办公移动电话
    OFFICE_PAGER                        = 3,                            // 办公传呼机
    OFFICE_FAX                          = 4,                            // 办公传真
    HOME_TEL                            = 5,                           // 家庭电话
    HOME_FAX                            = 6,                            // 家庭传真
    CAR_PHONE                           = 7,                            // 车载电话
    PRIVATE_MOBILE_TEL                  = 8,                            // 私人移动电话
    IM_ACCOUNT                          = 9,                           // 即时通讯帐号
    COMPANY_HOMEPAGE                    = 10,                           // 公司主页
    PERSONAL_HOMEPAGE                   = 11,                           // 个人主页
    COMPANY_EMAIL                       = 12,                           // 公司电子信箱
    PERSONAL_EMAIL                      = 13,                           // 个人电子信箱
};
