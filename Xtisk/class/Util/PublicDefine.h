//
//  PublicDefine.h
//  Unicom_BOX
//
//  Created by 兴天科技 on 13-3-12.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorTools.h"
#import "AsyncHttpRequest.h"
#import "HttpPublic.h"
#import "UcmDefine.h"
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
#define PathTmpFile(tpath)			[NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),tpath]

#define PUBLIC_UCM_END  @"PUBLIC"
#define PRIVATE_UCM_END @"PRIVATE"

#define PUBLIC_UCM_NOTHING @"0"

#define FRIEND_DEFAULT_GROUP_NAME @"未分组"
#define FRIEND_DEFAULT_GROUP_ID @"default"



#define SEARCH_FONT_SIZE  14

#define DATABASE_PATH                   @"xt"
#define DATABASE_TYPE                   @"db"

#define kDateTimeFormat                 @"yyyy-MM-dd HH:mm:ss"  
#define RecordTimeFormat                @"yyyyMMddHHmmss";

#define USER_CAPACITY_PHONE_CONF_1001 @"10001" //电话会议
#define USER_CAPACITY_VIDEO_CONF_1002 @"10002" //视频会议
#define USER_CAPACITY_MESSAGE_1004    @"10004" //短信
#define USER_CAPACITY_CDT_1005        @"10005" //ctd
#define USER_CAPACITY_VOIP_1006       @"10006" //voip




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

typedef enum  {
    MESSAGE_TYPE_SINGLE, //单人
    MESSAGE_TYPE_GROUP_DISCUSSION_ROOM,// 讨论组
    MESSAGE_TYPE_GROUP__PUBLIC // 群组
} MESSAGE_TYPE;

typedef enum  {
    ADD_MESSAGE_TYPE_SINGLE, //单人
    ADD_MESSAGE_TYPE_GROUP_DISCUSSION_ROOM,// 讨论组
} ADD_MESSAGE_TYPE;

//搜索方向（单程、往返）
typedef enum  {
    TICKET_QUERY_ONE = 0,
    TICKET_QUERY_RETURN
} TicketQueryDirType;
