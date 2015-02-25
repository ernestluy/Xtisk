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
#import "Util.h"
#import "XTFileManager.h"
#import "UMSocial.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "BMapKit.h"
#import "SVProgressHUD.h"

BMKMapManager* _mapManager;

#define kNeedCheckAuthentication 1 // 授权开关

#ifndef UnicomBoxLocalizedStrings
#define UnicomBoxLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"Localizable", nil)
#endif

#ifndef SipLocalizedStrings
#define SipLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"SipLocalizable", nil)
#endif

#define SERVICE_HOME @"192.168.1.1:8080"
 #define MAX_PACKET_LEN 40000

typedef void(^Block)(void);

// device macros
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] )
#define IS_IPAD   ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] )


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

#define XT_SHOWALERT(CONTENT) [[[UIAlertView alloc]initWithTitle:@"提示" message:(CONTENT) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]show]
#define LyRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


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
#define PathDocFile(tpath)      [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),tpath]


#define SEARCH_FONT_SIZE  14

#define DEFAULT_CELL_HEIGHT 44.0

#define COMMEND_CELL_HEIGHT 120.0

#define DATABASE_PATH                   @"xt"
#define DATABASE_TYPE                   @"db"

#define kDateTimeFormat                 @"yyyy-MM-dd HH:mm:ss"  
#define RecordTimeFormat                @"yyyyMMddHHmmss";






#define _NOTHING  (-1)

#define keyMyselfSign @"keyMyselfSign"


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

typedef enum {
    XtServiceTicket =0,
    XtServiceNear,
    XtServiceParkActivities
}XtServiceType;

typedef enum  {
    PrivateEditTextSign,
    PrivateEditTextCom,
    PrivateEditTextFoodCommend,
    PrivateEditTextAdvise
} PrivateEditTextType;

typedef enum  {
    PsdSettingReg,
    PsdSettingModify
}PsdSettingType;

typedef enum  {
    ServiceFirst,
    ServiceSecond,
    ServiceThird,
    ServiceForth
} ServiceMenuLevel ;

#define IshekouWXAppId     @"wxd930ea5d5a258f4f"
#define IshekouWXAppSecret @"db426a9829e4b49a0dcac7b4162da6b6"
#define UmengAppkey @"5211818556240bc9ee01db2f"
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

#define DefaultCellFont [UIFont systemFontOfSize:15]


#define XT_CORNER_RADIUS  5
#define XT_CELL_CORNER_RADIUS 8
#define LY_DOWN_FLUSH_HEIGHT 64.0
#define DOWN_DRAG_FLUSH_NORMAL @"上拉刷新"
#define DOWN_DRAG_FLUSH_WILL_START @"上拉刷新"
#define DOWN_DRAG_FLUSH_DOING @"正在刷新中"

#define RELEASE_DRAG_TO_FLUSH @"松开开始刷新"

#define UP_DRAG_FLUSH_NORMAL @"下拉刷新"
#define UP_DRAG_FLUSH_WILL_START @"下拉刷新"
#define UP_DRAG_FLUSH_DOING @"正在刷新中"