
#import <Foundation/Foundation.h>
#import "AsyncHttpRequest.h"



#define IsRPorTPAPI								@"isrportp"
/*********************************************************************
 RP
 *********************************************************************/

//【登陆】登出
#define WEB_Logout                              @"WEB_LogoutAPI"

// HTTP请求类型
typedef enum HttpRequestType{
    
#pragma mark -
#pragma mark RPHttpRequestType
    
    //【交易】请求sessionID
    HttpRequestType_XT_LOGIN = 0,
    HttpRequestType_XT_REG,
    HttpRequestType_XT_GETSMSCODE,
    HttpRequestType_XT_RESETPSD,
    HttpRequestType_XT_SUGGESTION,
    HttpRequestType_XT_UPDATEPERSON,
    HttpRequestType_XT_LOGOUT,
    
    HttpRequestType_XT_POSTERLIST,
    HttpRequestType_XT_RECOMMENDLIST,
    HttpRequestType_XT_ACTIVITYLIST,
    HttpRequestType_XT_ACTIVITYDETAIL,
    HttpRequestType_XT_ACTIVITYCOMMENTSLIST,
    HttpRequestType_XT_ACTIVITYCOMMENTS,
    HttpRequestType_XT_FAVORITEACTIVITY,//此处有一样的，待定
    
    HttpRequestType_XT_JOINACTIVITY,
    HttpRequestType_XT_QUERYACTIVITYJOININFO,
    HttpRequestType_XT_UPDATEACTIVITYJOININFO,
    HttpRequestType_XT_CANCELACTIVITYJOIN,
    
    HttpRequestType_XT_QUERYCATEGORY,
    HttpRequestType_XT_QUERYSTOREBYCATEGORY,//此处接口不健全，需要注意
    HttpRequestType_XT_QUERYSTOREDETAIL,
    HttpRequestType_XT_QUERYSTOREMENU,
    HttpRequestType_XT_FAVORITESTORE,
    HttpRequestType_XT_STORECOMMENTS,
    HttpRequestType_XT_STORECOMMENTSLIST,
    HttpRequestType_XT_QUERYMYACTIVITY,
    HttpRequestType_XT_UPDATEMYPASSWORD,
    
    HttpRequestType_Img_LoadDown,
    
}HttpRequestType;

// HTTP返回类型
typedef enum HttpResponseType{
    HttpResponseTypeFinished = 0,	//请求完成
    HttpResponseTypeFailed			//请求失败
}HttpResponseType;



