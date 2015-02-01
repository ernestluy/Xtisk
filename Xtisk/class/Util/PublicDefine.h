//
//  PublicDefine.h
//  Unicom_BOX
//
//  Created by 兴天科技 on 13-3-12.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEBUG 0
#define kNeedCheckAuthentication 1 // 授权开关

#ifndef UnicomBoxLocalizedStrings
#define UnicomBoxLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"Localizable", nil)
#endif

#ifndef SipLocalizedStrings
#define SipLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"SipLocalizable", nil)
#endif

/////////////////////////////////////////////////////////testflight
//#define kTestFlightTesting          // this line need to be commented when build  for app store 
#define kTestFlightAppToken         @"f10bc386-f4d4-48cd-b68c-5ba316051322"
//#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define NSLog TFLog
#define checkPoint(__VA_ARGS__)     [TestFlight passCheckpoint:UnicomBoxLocalizedStrings(__VA_ARGS__)];
/////////////////////////////////////////////////////////testflight
#define kSendTextResponseTimeInterval 10.0f
#define kSendPictureResponseTimeInterval 30.0f
#define kAnnoucementRequestUriPrefix @"http://%@/outer_toAfficheInfo?loginId=%@&mobileFlag=true"//portal/
#define kIMConversationPageSize 15  //page size  of   message history in conversation view
#define kHeartBeatTimerInterval 30.0f
#define kLoginRequestTimeout 10.0
#define kMeetingRefreshTimeInterval 30.0
#define kConfDataNeedRefresh @"kConfDataNeedRefresh"
#define kGateWay [SettingHelper diaConfServerUrl]
 #define MAX_PACKET_LEN 40000

typedef void(^Block)(void);

// device macros
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] )
#define IS_IPAD   ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] )
#define IS_IPHONE_5_SCREEN [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f
#define IS_IPHONE_4_SCREEN [[UIScreen mainScreen] bounds].size.height >= 480.0f && [[UIScreen mainScreen] bounds].size.height < 568.0f
#define host_urlCTD [NSString stringWithFormat:@"http://%@/uc_vcs/thirdPhone.do?method=makeCallToThirdPhone&userAccount=",kGateWay]

#define  kTitleColor [UIColor colorWithRed:71.0/255 green:94.0/255 blue:136.0/255 alpha:1.0f]
//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]



// Dial related .

#define kDIAL_SERVER @"http://58.254.177.134:9999/uc_vcs/vcs/meetingInterfaceLogin.do?username="
#define kCVS_ACCOUNT @"2012010309"
#define kCVS_PWD    @"888888"

//IM related .
#ifndef IM_SERVER_DEFINE
#define IM_SERVER_ADDRESS @"10.20.11.131"
#define IM_SERVER_GATE_PORT 2084

//IM test user account and pwd .
#define IM_USER_TEST_ACCOUNT @"uctest005"
#define IM_USER_TEST_PWD @"123456"


#define LOGIN_ENCRYPT_KEY @"ABCD1234abcd5678"

#define VIDEO_CONF_HOUR      2
#define VIDEO_CONF_DURATION  60*60*VIDEO_CONF_HOUR
#define IS_LT_VIDEO_VISION   YES
#endif
//Documents 路径
#define PathDocumentsHeadIcon				[NSString stringWithFormat:@"%@%@",NSHomeDirectory(),@"/Documents/headicon"]
//头像路径
#define PathLogo(logo)			[NSString stringWithFormat:@"%@/%@",PathDocumentsHeadIcon,logo]

#define PUBLIC_UCM_END  @"PUBLIC"
#define PRIVATE_UCM_END @"PRIVATE"

#define PUBLIC_UCM_NOTHING @"0"

#define FRIEND_DEFAULT_GROUP_NAME @"未分组"
#define FRIEND_DEFAULT_GROUP_ID @"default"

#define FRIEND_CELL_HEIGHT   50
#define DIAL_CELL_EXPEND_HEIGHT 2*FRIEND_CELL_HEIGHT
#define MAIN_TAB_BAR_HEIGHT  49
#define MAIN_BODY_HEIGHT     460

#define SEARCH_FONT_SIZE  14

#define DATABASE_PATH                   @"ubox"
#define DATABASE_TYPE                   @"db"

#define kDateTimeFormat                 @"yyyy-MM-dd HH:mm:ss"  
#define RecordTimeFormat                @"yyyyMMddHHmmss";

#define USER_CAPACITY_PHONE_CONF_1001 @"10001" //电话会议
#define USER_CAPACITY_VIDEO_CONF_1002 @"10002" //视频会议
#define USER_CAPACITY_MESSAGE_1004    @"10004" //短信
#define USER_CAPACITY_CDT_1005        @"10005" //ctd
#define USER_CAPACITY_VOIP_1006       @"10006" //voip


//@"发送消息",@"回拨呼叫",@"直拨呼叫"
#define STR_CAPACITY_IM      @"发送消息"
#define STR_CAPACITY_CDT     @"回拨呼叫"
#define STR_CAPACITY_VOIP    @"直拨呼叫"
#define STR_PHONE_CALL       @"手机呼叫"
#define STR_VIDEO_CONF       @"视频会议"
#define STR_PHONE_CONF       @"电话会议"
//电话纪录类型
typedef enum {
    CALL_DEFAULT_CALLS =0,//呼出电话
    CALL_COMING_CALLS  =1,//来电电话
}CallPhoneType;
#define STR_DEFAUT_NAME      @"未知的"
#define STR_CANCEL           @"取消"
//------------------------
#define KEY_TEST_LOGIN_INTO @"KEY_TEST_LOGIN_INTO"
#define KEY_IM_LOGOUT_VIDEO_IS_START @"KEY_IM_LOGOUT_VIDEO_IS_START"

#define KIM_LOGIN_OUT_WUNAI @"KIM_LOGIN_OUT_WUNAI"
//------------------------

#define NOTICE_CALL_BACK_NUMBER  1000
#pragma mark -
#define NOTICE_PERSON_A_CONF_START @"您被邀请参加一个视频会议"
#pragma mark -
#define IOS_STATE_BAR_HEIGHT     20
#define NAVIGATIONBAR_HEIGHT     44
//通讯录页签顺序
enum CROP_VIEW_TAG{
    CROP_DEPT_VIEW_TAG= 100,                 //企业通讯录界面
    CROP_FRIEND_VIEW_TAG ,                 //好友界面
    CROP_MOBILE_TAG,                    //手机界面
    CROP_GROUP_TAG,                    //群组界面，暂时还没提供
};

//好友界面列表显示的类型
enum FRIEND_GROUP_ENUM
{
    FRIEND_GROUP_LIST = 0,
    FRIEND_SEARCH_RESULT,
};

typedef enum LT_CODE{
    LT_CODE_SUCCESS = 0, //登录成功 返回token
    LT_CODE_FAILE = -1, //登录失败，不返回token
    LT_CODE_NAME_IS_NULL = 1, //用户名传入为空
    LT_CODE_PWD_IS_NULL = 2, //密码传入为空
    LT_CODE_DATA_NULL = 3,
} LtCode;
typedef enum LT_CREATE_CODE{
    LT_CREATE_CODE_SUCCESS = 1,// 成功
    LT_CREATE_CODE_FAILE = 2,//失败
    LT_CREATE_CODE_EXCEPTION = 0,//网络异常
    //1000 是账号认证失败
}LtCreateCode;

typedef enum {
    VIDEO_ADD_PERSON_START = 0,
    VIDEO_ADD_PERSON_ADD = 1,
}VideoAddPersonType,VIDEO_ADD_PERSON_TYPE;

//1 成功
//0失败
//4015会议ID不存在
typedef enum LT_FINISH_CONF_CODE{
    LT_FINISH_CONF_SUCCESS = 1,
    LT_FINISH_CONF_FAILE   =2,
    LT_FINISH_CONF_EXIST   = 4015,
}LtFinishConfCode;

//进入名片的类型
enum INTO_TYPE{
    INTO_CARD_FROM_DEFAULT = 0,                 //默认
    INTO_CARD_FROM_COMPANY = 1,                 //从企业通讯录进入
    INTO_CARD_FROM_FRIEND  = 2,                  //从好友进入 
    INTO_CARD_FROM_MYSELF  = 3,                  //个人名片类型
    INTO_CARD_FROM_IM,                           //从im进入
};
typedef enum{
    INTO_CONF_WITH_DEFAULT   =0,
    INTO_CONF_WITH_PHONECONF = 1,
    INTO_CONF_WITH_VIDEOCONF = 2,
}IntoConfType;
typedef enum
{
    TKCONTACT_LOGIN                          = 1000,   //登陆
    TKCONTACT_MEETTING                       = 1001,   //开会
    TKCONTACT_DETAILMEETING                  = 1002,   //会议细节
    TKCONTACT_MEMBERSTATE                    = 1003,   //成员状态
    TKCONTACT_ADDMEMBER                      = 1004,   //增加成员
    TKCONTACT_DELMEMBER                      = 1005,   //删除成员
    TKCONTACT_NOTALLOWSPEAKALL               = 1006,   //全部禁言
    TKCONTACT_ALLOWSPEAKALL                  = 1007,   //全部发言
    TKCONTACT_NOTALLOWSPEAKFORONE            = 1008,   //允许单个成员禁言
    TKCONTACT_ALLOWSPEAKFORONE               = 1009,   //允许单个成员发言
    TKCONTACT_REDIAL                         = 1010,   //重拨
    TKCONTACT_MODIFYCALLEDNUM                = 1011,   //修改会议成员号码
    TKCONTACT_HUANGUPFORONE                  = 1012,   //单个成员挂断
    TKCONTACT_CONFERENCEFINISH               = 1013,   //结束会议
    TKCONTACT_ATTENDERMEETINGLIST            = 1014,   //参会人名字列表
    TKCONTACT_ENDMEETINGLIST                 = 1015,   //结束会议列表
    TKCONTACT_OFTENUSINGMEETINGLIST          = 1016,   //常用会议列表
    TKCONTACT_BOOKINGMEETINGLIST             = 1017,   //所有预约会议列表
    TKCONTACT_LOGOUT                         = 1018,   //登出
    TKCONTACT_CTD                            = 1019,   //CTD电话
}RequestType;

#define _NOTHING  (-1)

#define keyMyselfSign @"keyMyselfSign"
#define IDKeyMyselfSign(id)  [NSString stringWithFormat:@"%@%@",keyMyselfSign,id]
#define NOTIFY_SYNC_PUBLIC_CONTACT_OVER_RESP @"SYNC_PUBLIC_CONTACT_OVER_RESP"//通知ui更新数据
#define NOTIFY_SYNC_PRIVATE_CONTACT_OVER_RESP @"NOTIFY_SYNC_PRIVATE_CONTACT_OVER_RESP"//通知ui更新数据
#define NOTIFY_SYNC_USER_LOGO_RESP           @"NOTIFY_SYNC_USER_LOGO_RESP"//通知ui更新头像
#define NOTIFY_IM_SIGN_LOADING_RESP           @"NOTIFY_IM_SIGN_LOADING_RESP"//通知ui更新头像

#define NOTIFY_SYNC_DOWNLOAD_PACKAGES_COUNT           @"NOTIFY_SYNC_DOWNLOAD_PACKAGES_COUNT"

#define NOTIFY_SYNC_GROUP_DATA  @"NOTIFY_SYNC_GROUP_DATA" //通知同步群组、聊天室数据

#define NOTIFY_SYNC_COM_DATA_FIRST_RESP            @"NOTIFY_SYNC_COM_DATA_FIRST_RESP"

 enum OPERATION_TYPE                  // 操作类型
 {
     
     DEFAULT_VALUE						= 0x00000000,					//  默认值
     USER_LOGIN_REQ					    = 0x00003011,	                //  登录
     USER_LOGIN_RESP					    = 0x80003011,	                //  登录应答
     SUBMIT_MYUSERINFO_REQ			    = 0x00003012,	                //  提交本人的企业通讯录信息
     SUBMIT_MYUSERINFO_RESP			    = 0x80003012,	                //  提交本人的企业通讯录信息应答
     SUBMIT_MY_LOGO_REQ                  = 0x00003013,                   //  提交本人在企业通讯录中的头像
     SUBMIT_MY_LOGO_RESP                 = 0x80003013,                   //  提交本人在企业通讯录中的头像应答
     SUBMIT_MYROSTER_LOGO_REQ		    = 0x00003014,	                //  提交本人企业通讯录自定义头像
     SUBMIT_MYROSTER_LOGO_RESP		    = 0x80003014,	                //  提交本人企业通讯录自定义头像应答
     SYNC_USER_LOGO_REQ				    = 0x00003015,	                //  下载指定用户/联系人的自定义头像
     SYNC_USER_LOGO_RESP				    = 0x80003015,	                //  下载指定用户/联系人的自定义头像应答
     SYNC_PUBLIC_CONTACT_REQ             = 0x00003016,                   //  下载企业通讯录
     SYNC_PUBLIC_CONTACT_OVER_RESP       = 0x80003016,                   //  服务器返回下载企业通讯录完成
     SYNC_PUBLIC_ORG_RESP                = 0x80003017,                   //  服务器返回企业通讯录组织
     SYNC_PUBLIC_DEPT_RESP               = 0x80003018,                   //  服务器返回企业通讯录部门
     SYNC_PUBLIC_USER_RESP               = 0x80003019,                   //  服务器返回企业通讯录用户
     SYNC_PUBLIC_ROOTDEPT_RESP           = 0x80003020,                   //  服务器返回企业通讯录一级部门
     SYNC_PUBLIC_MEMBER_RESP             = 0x80003021,                   //  服务器返回企业通讯录部门成员
     SYNC_PUBLIC_ACCOUNT_RESP            = 0x80003022,                   //  服务器返回企业通讯录账号
     SYNC_PUBLIC_NAMECARD_RESP           = 0x80003023,                   //  服务器返回企业通讯录名片
     SYNC_PUBLIC_CONTACTS_RESP           = 0x80003024,                   //  服务器返回企业通讯录联系方式
     SYNC_PUBLIC_ADDRESS_RESP            = 0x80003025,                   //  服务器返回企业通讯录地址信息
     SYNC_PUBLIC_PACKAGETOTAL_RESP       = 0x80003026,                   //  服务器返回企业通讯录总页数 - 全量才有
     
     
     SYNC_PRIVATE_CONTACT_REQ            = 0x00003050,   //下载个人通讯录
     SYNC_PRIVATE_GROUP_RESP	            = 0x80003051,	  //服务器返回个人通讯录分组
     SYNC_PRIVATE_NAMECARD_RESP = 0x80003052,	//服务器返回个人通讯录名片
     SYNC_PRIVATE_ADDRESS_RESP = 0x80003053,	//服务器返回个人通讯录地址
     SYNC_PRIVATE_CONTACTS_RESP = 0x80003054,	//服务器返回个人通讯录联系方式
     SYNC_PRIVATE_MEMBER_RESP = 0x80003055,	//服务器返回个人通讯录分组成员
     SYNC_PRIVATE_CONTACT_OVER_RESP = 0x80003056,	//服务器返回下载个人通讯录完成
     OPERATE_GROUP_REQ = 0x00003100,	    //请求操作个人通讯录分组
     OPERATE_GROUP_RESP = 0x80003100,	//操作个人通讯录分组结果应答
     OPERATE_GROUP_MEMBER_REQ = 0x00003101,	//请求操作个人通讯录分组成员
     OPERATE_GROUP_MEMBER_RESP = 0x80003101,	//操作个人通讯录分组成员结果应答
     OPERATE_MYROSTER_REQ = 0x00003102,	//请求操作个人通讯录名片
     OPERATE_MYROSTER_RESP = 0x80003102,	//操作个人通讯录名片结果应答
     OPERATE_ROSTER_CONTACTS_REQ = 0x00003103,	//请求操作个人通讯录联系方式
     OPERATE_ROSTER_CONTACTS_RESP = 0x80003103,	//操作个人通讯录联系方式结果应答
     OPERATE_ROSTER_ADDRESS_REQ = 0x00003104,	//请求操作个人通讯录地址
     OPERATE_ROSTER_ADDRESS_RESP = 0x80003104,	//操作个人通讯录地址结果应答
      
 };

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
//typedef enum {
//CONTACT_TYPEOfficeTel = 0,
//CONTACT_TYPEOfficeInlineTel = 1,
//CONTACT_TYPEOfficeMobileTel = 2,
//CONTACT_TYPEOfficePager = 3,
//CONTACT_TYPEOfficeFax = 4,
//CONTACT_TYPEHomeTel = 5,
//CONTACT_TYPEHomeFax = 6,
//CONTACT_TYPECarPhone = 7,
//CONTACT_TYPEPrivateMobileTel = 8,
//CONTACT_TYPEImAccount = 9,
//CONTACT_TYPECompanyHomepage = 10,
//CONTACT_TYPEPersonalHomepage = 11,
//CONTACT_TYPECompanyEmail = 12,
//CONTACT_TYPEPersonalEmail = 13,
//} CONTACT_TYPE;

enum OPERATE_MEMBER_TYPE
{
    OPERATE_MEMBER_DELETE      =0,
    OPERATE_MEMBER_ADD         =1,
    OPERATE_MEMBER_MODIFY      =2,
};

/*
* 业务权限
* @author gaoshanjiang
* 10001 ：电话会议
* 10002 ： 视频会议
* 10004 ： 短信
* 10005：  CTD电话
* 10006 ： VOIP电话
*/
typedef enum  {
    UserCapacityVoiceCallConfTag = 10001,
    UserCapacityVideoCallConfTag = 10002,
    UserCapacitySMSTag = 10004,
    UserCapacityCTDCallTag = 10005,
    UserCapacityVoipCallTag = 10006
}UserCapacity;

/**
 *聊天室
 */
typedef enum {
    PRIVATE_GROUP_TYPE_DISCUSSION_ROOM, //聊天室,讨论组
    PRIVATE_GROUP_TYPE_PUBLIC_GROUP// 群组
} PRIVATE_GROUP_TYPE;


typedef enum  {
    MESSAGE_TYPE_SINGLE, //单人
    MESSAGE_TYPE_GROUP_DISCUSSION_ROOM,// 讨论组
    MESSAGE_TYPE_GROUP__PUBLIC // 群组
} MESSAGE_TYPE;

typedef enum  {
    ADD_MESSAGE_TYPE_SINGLE, //单人
    ADD_MESSAGE_TYPE_GROUP_DISCUSSION_ROOM,// 讨论组
} ADD_MESSAGE_TYPE;