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
#import "TicketSerivice.h"
#import "VoyageRequestPar.h"
#import "PushMessageItem.h"
#import "ShipLineItem.h"
#import "MyActivity.h"
#import "VoyageItem.h"
#import "SeatRankPrice.h"
#import "TicketOrder.h"
#import "TicketInfoItem.h"
#import "TicketOrderListItem.h"
#import "MyTicketItem.h"
#import "MyTicketOrderDetail.h"
#import "TicketOrderListItem.h"
#import "TicketTradeInfo.h"
#import "MsgPlaySound.h"
#import "LogUtil.h"
BMKMapManager* _mapManager;

#define kNeedCheckAuthentication 1 // 授权开关

#define authorityTicket  NO

#ifndef UnicomBoxLocalizedStrings
#define UnicomBoxLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"Localizable", nil)
#endif

#ifndef SipLocalizedStrings
#define SipLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"SipLocalizable", nil)
#endif

#define SERVICE_DIS  0

#if SERVICE_DIS
  #define SERVICE_HOME @"tms.ishekou.com"
#else
  #define SERVICE_HOME @"116.7.243.122:10080"

#endif
/*
 测试机后台
 http://116.7.243.122:10080/
 正是环境
 http://tms.ishekou.com/
 */
//#define SERVICE_HOME @"tms.ishekou.com"//@"116.7.243.122:10080/ipop_tms"//http://ip:port/ipop_tms
#define RESOURSE_HOME [NSString stringWithFormat:@"http://%@/",SERVICE_HOME]
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

#define  MainTintColor _rgb2uic(0x0095f1, 1)

#define XT_SHOWALERT(CONTENT) [[[UIAlertView alloc]initWithTitle:@"提示" message:(CONTENT) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]show]
#define LyRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define NUMBERS @"0123456789.\n"
#define OneDaySeconds 24*3600

#define  randomInt arc4random_uniform(100)
#define int2str(i) [NSString stringWithFormat:@"%d",(i)]
//Documents 路径
#define PathDocumentsHeadIcon				[NSString stringWithFormat:@"%@%@",NSHomeDirectory(),@"/Documents/headicon"]
//头像路径
#define PathLogo(logo)			[NSString stringWithFormat:@"%@/%@",PathDocumentsHeadIcon,logo]
//#define PathTmpFile(tpath)		[NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),tpath]
#define PathTmpFile(tpath)		[NSString stringWithFormat:@"%@/%@",tPathTmpDir,tpath]
#define PathDocFile(tpath)      [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),tpath]

#define tPathTmpDir             [NSString stringWithFormat:@"%@/Documents/tmp",NSHomeDirectory()]

#define PathCacheFile(tpath)		[NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),tpath]

#define SEARCH_FONT_SIZE  14

#define DEFAULT_CELL_HEIGHT 44.0

#define COMMEND_CELL_HEIGHT 110.0

#define DATABASE_PATH                   @"xt"
#define DATABASE_TYPE                   @"db"

#define kDateTimeFormat                 @"yyyy-MM-dd HH:mm:ss"  
#define RecordTimeFormat                @"yyyyMMddHHmmss";

#define kCellDefault @"kCellDefault"

#define GuideMark @"GuideMark"

#pragma mark - service str
#define IndexRecomList  @"recomList"
#define IndexPosterList  @"posterList"
#define CategoryRoot  @"CategoryRoot"

#define ShipLineList @"shipLineList"

#define DefaultMsgPageSize 20

#define DefaultPageSize 20
#define DefaultEnableAlhpe 0.5

#define _NOTHING  (-1)

#define keyMyselfSign @"keyMyselfSign"

#define kPushMessageReceiveRemote @"kPushMessageReceiveRemote"
#define kPushMessageFlush @"kPushMessageFlush"
#define kTicketOrderGeneration    @"kTicketOrderGeneration"
#define kLogout    @"kLogout"

#define kDeviceToken    @"kDeviceToken"


typedef enum {
    TAB_BAR_INDEX = 0,
    TAB_BAR_MSG,
    TAB_BAR_SERVICE,
    TAB_BAR_MORE,
}TabBarIndex;

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

typedef enum  {
    TicketVoyageStepFirst = 0,
    TicketVoyageStepSecond
}TicketVoyageStepType ;

typedef enum  {
    TicketOrderDetailDelfault = 0,
    TicketOrderDetailSeq,
    TicketOrderDetailHis
}TicketOrderDetailAction ;


#define IshekouWXAppId     @"wxe3a03153f3712ed6"//@"wxd930ea5d5a258f4f"
#define IshekouWXAppSecret @"38d5dfc8128939d2f6deaa22b0382e53"//@"db426a9829e4b49a0dcac7b4162da6b6"
#define UmengAppkey @"5211818556240bc9ee01db2f"
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

#define DefaultCellFont [UIFont systemFontOfSize:15]

#define DefaultImageViewContentMode UIViewContentModeScaleToFill//UIViewContentModeScaleAspectFill//
#define DefaultImageViewInitMode    UIViewContentModeCenter//UIViewContentModeScaleToFill//


#define DefaultRequestPrompt  @"请求中..."
#define DefaultRequestDonePromptTime 1.5
#define DefaultRequestFaile  @"请求失败"
#define DefaultRequestFaileToAgain  @"请求失败，请重新请求"
#define DefaultRequestException  @"请求异常"
#define GetVerifyCodeWaitingTime 60

#define DefaultImageMinSize 1000

#define XT_CORNER_RADIUS  3
#define XT_CELL_CORNER_RADIUS 5



typedef enum  {
    FlushDirNormal,
    FlushDirUp,
    FlushDirDown
}FlushDirType ;

#define LY_DOWN_FLUSH_HEIGHT 54.0
#define DOWN_DRAG_FLUSH_NORMAL @"上拉可以加载"
#define DOWN_DRAG_FLUSH_WILL_START @"上拉可以加载"
#define DOWN_DRAG_FLUSH_DOING @"正在加载中"
#define DOWN_RELEASE_DRAG_TO_FLUSH @"松开立即加载"

#define RELEASE_DRAG_TO_FLUSH @"松开立即刷新"

#define UP_DRAG_FLUSH_NORMAL @"下拉可以刷新"
#define UP_DRAG_FLUSH_WILL_START @"下拉可以刷新"
#define UP_DRAG_FLUSH_DOING @"正在刷新中"

#define iMinIndex 16


//uppay
#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80
#define kCellHeight_Normal  50
#define kCellHeight_Manual  145

#define kVCTitle          @"商户测试"
#define kBtnFirstTitle    @"获取订单，开始测试"
#define kWaiting          @"正在获取TN,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"

//success、fail、cancel
#define PaySuccess @"success"
#define PayFail    @"fail"
#define PayCancel  @"cancel"

#define kMode_Development             @"01"
#define kMode_Product                 @"00"


#define AcStatusIng     @"进行中"
#define AcStatusEnd     @"已结束"
#define AcStatusNoBegin @"未开始"

#define listColorIng     _rgb2uic(0xe24242, 1)
#define listColorEnd     _rgb2uic(0xb0b0b0, 1)
#define listColorNoBegin _rgb2uic(0x2bf147, 1)

//f54d12
#define listColorPayIng     _rgb2uic(0xf54d12, 1)
#define listColorPayOk     _rgb2uic(0x4ad02a, 1)
#define listColorPayOver     _rgb2uic(0xa9a9a9, 1)

#define tagWaitToPay  0
#define tagHaveToPay  1





