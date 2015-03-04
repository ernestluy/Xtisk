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

#import "LYTableView.h"
#import "LYCollectionView.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "BMapKit.h"
#import "SVProgressHUD.h"
#import "BaseResponse.h"
#import "IUser.h"
#import "HttpService.h"
#import "RecommendItem.h"
#import "SettingService.h"
#import "HisLoginAcc.h"
#import "MenuItem.h"
#import "CategoryItem.h"
#import "StoreItem.h"
#import "ServiceItem.h"
#import "ActivityItem.h"
#import "CommentsItem.h"
#import "FavoriteItem.h"
#import "JoinInfo.h"
#import "CTLCustom.h"


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

#define SERVICE_HOME @"116.7.243.122:10080/ipop_tms"//http://ip:port/ipop_tms
#define RESOURSE_HOME @"http://116.7.243.122:10080/ipop_tms/"
 #define MAX_PACKET_LEN 40000

typedef void(^Block)(void);

// device macros
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] )
#define IS_IPAD   ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] )


#define  kTitleColor [UIColor colorWithRed:71.0/255 green:94.0/255 blue:136.0/255 alpha:1.0f]
#define defaultTextColor _rgb2uic(0x333333, 1)
#define defaultTextGrayColor _rgb2uic(0xb0b0b0, 1)  //b0b0b0
#define defaultBorderColor _rgb2uic(0xcfcfcf, 1)
#define defaultSeparatorColor _rgb2uic(0xdadada, 1)

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


#define  randomInt arc4random_uniform(100)
#define int2str(i) [NSString stringWithFormat:@"%d",(i)]
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



#define GuideMark @"GuideMark"

#pragma mark - service str
#define IndexRecomList  @"recomList"
#define IndexPosterList  @"posterList"
#define CategoryRoot  @"CategoryRoot"


#define DefaultPageSize 20
#define DefaultEnableAlhpe 0.5

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
    PrivateEditTextNick,//昵称
    PrivateEditTextSign,//签名
    PrivateEditTextCom,//公司简介
    PrivateEditTextFoodCommend,//店家
    PrivateEditTextAdvise,//建议
    PrivateEditTextActivity //活动评价
} PrivateEditTextType;

typedef enum  {
    PsdSettingReg,
    PsdSettingModify
}PsdSettingType;

typedef enum  {
    ServiceFirst,
    ServiceNode,
    ServiceEnd
} ServiceMenuLevel ;

typedef enum  {
    ActivityStatusOver,//过期
    Activity
}ActivityStatus ;

typedef enum  {
    ResponseCodeSuccess = 0
}ResponseCodeType;

typedef enum  {
    VerifyCodeGet = 0,
    VerifyCodeJudge
}VerifyCodeAction ;

typedef enum  {
    StationOrigin = 0,
    StationDest
}StationSelectType ;

typedef enum  {
    ActivityVcSignUp = 0,
    ActivityVcBrow,
    ActivityVcEdit
}ActivityVcType ;

typedef enum  {
    CommendVcStore = 0,
    CommendVcActivity
}CommendVcType ;


#define IshekouWXAppId     @"wxd930ea5d5a258f4f"
#define IshekouWXAppSecret @"db426a9829e4b49a0dcac7b4162da6b6"
#define UmengAppkey @"5211818556240bc9ee01db2f"
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

#define DefaultCellFont [UIFont systemFontOfSize:15]

#define DefaultImageViewContentMode UIViewContentModeScaleToFill//UIViewContentModeScaleAspectFill//
<<<<<<< HEAD
=======
#define DefaultImageViewInitMode UIViewContentModeCenter//UIViewContentModeScaleToFill//
>>>>>>> 606fa715407fca8f7212294ba2cafd7226e92154

#define DefaultRequestPrompt  @"请求中..."
#define DefaultRequestDonePromptTime 1.1
#define DefaultRequestFaile  @"请求失败"
#define DefaultRequestFaileToAgain  @"请求失败，请重新请求"
#define DefaultRequestException  @"请求异常"
#define GetVerifyCodeWaitingTime 10

#define DefaultImageMinSize 1000

#define XT_CORNER_RADIUS  5
#define XT_CELL_CORNER_RADIUS 8


typedef enum  {
    FlushDirNormal,
    FlushDirUp,
    FlushDirDown
}FlushDirType ;

#define LY_DOWN_FLUSH_HEIGHT 54.0
#define DOWN_DRAG_FLUSH_NORMAL @"上拉可以刷新"
#define DOWN_DRAG_FLUSH_WILL_START @"上拉可以刷新"
#define DOWN_DRAG_FLUSH_DOING @"正在刷新中"

#define RELEASE_DRAG_TO_FLUSH @"松开立即刷新"

#define UP_DRAG_FLUSH_NORMAL @"下拉可以刷新"
#define UP_DRAG_FLUSH_WILL_START @"下拉可以刷新"
#define UP_DRAG_FLUSH_DOING @"正在刷新中"