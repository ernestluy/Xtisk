
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
    
    
    
    
    HttpRequestType_Img_LoadDown,
    
}HttpRequestType;

// HTTP返回类型
typedef enum HttpResponseType{
    HttpResponseTypeFinished = 0,	//请求完成
    HttpResponseTypeFailed			//请求失败
}HttpResponseType;



