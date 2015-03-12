//
//  HttpService.h
//  Xtisk
//
//  Created by 卢一 on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicDefine.h"
#import "AsyncImgDownLoadRequest.h"
#import "BaseResponse.h"
#import "CategoryItem.h"
#import "JoinInfo.h"
#import "VoyageRequestPar.h"
#import "TicketOrder.h"
@interface HttpService : NSObject
{
    
}
@property(nonatomic,strong)CategoryItem *gCategoryItem;


+(HttpService *)sharedInstance;
+(NSString *)getErrorStrWithCode:(int)code;
#pragma mark - 返回数据处理
-(BaseResponse *)dealResponseData:(NSData *)data;

-(AsyncImgDownLoadRequest *)getImgRequest:(id<AsyncHttpRequestDelegate>)delegate url:(NSString *)str;

-(AsyncHttpRequest *)getRequestUploadImage:(id<AsyncHttpRequestDelegate>)delegate url:(NSString*)urlstring image:(UIImage*)image;


#pragma mark - 4.3.1.1	获取海报
-(AsyncHttpRequest *)getRequestPosterList:(id<AsyncHttpRequestDelegate>)delegate ;
#pragma mark - 4.3.1.2	获取推荐位
-(AsyncHttpRequest *)getRequestRecomList:(id<AsyncHttpRequestDelegate>)delegate;

#pragma mark - 4.3.2.1	获取活动列表 页码，默认为1
-(AsyncHttpRequest *)getRequestActivityList:(id<AsyncHttpRequestDelegate>)delegate pageNo:(int)pageNo pageSize:(int)pageSize;

#pragma mark - 4.3.2.2	获取活动详情
-(AsyncHttpRequest *)getRequestActivityDetail:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId;

#pragma mark - 4.3.2.3	获取活动评论 页码，默认为1
-(AsyncHttpRequest *)getRequestactivityCommentsList:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId pageNo:(int)pageNo pageSize:(int)pageSize;

#pragma mark - 4.3.2.4	评论活动
-(AsyncHttpRequest *)getRequestActivityComments:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId content:(NSString *)content;

#pragma mark - 4.3.2.5	活动点赞/取消点赞
-(AsyncHttpRequest *)getRequestFavoriteActivity:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId ;

#pragma mark - 4.3.2.6	活动报名
-(AsyncHttpRequest *)getRequestJoinActivity:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId  joinInfo:(JoinInfo *)jInfo;
#pragma mark - 4.3.2.7	查看活动报名信息
-(AsyncHttpRequest *)getRequestQueryActivityJoinInfo:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId;
#pragma mark - 4.3.2.8	修改活动报名信息
-(AsyncHttpRequest *)getRequestUpdateActivityJoinInfo:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId  joinInfo:(JoinInfo *)jInfo;
#pragma mark - 4.3.2.9	取消报名
-(AsyncHttpRequest *)getRequestCancelActivityJoin:(id<AsyncHttpRequestDelegate>)delegate activityId:(NSString *)activityId;


#pragma mark - 4.3.3	周边
#pragma mark - 4.3.3.1	获取周边的分类（含根据父分类获取子分类）
-(AsyncHttpRequest *)getRequestCategoryTypeList:(id<AsyncHttpRequestDelegate>)delegate parentCategoryId:(NSString *)parentCategoryId;
#pragma mark - 4.3.3.2	根据分类获取分类下的店家列表
-(AsyncHttpRequest *)getRequestQueryStoreByCategory:(id<AsyncHttpRequestDelegate>)delegate categoryId:(NSString *)categoryId pageNo:(int)pageNo pageSize:(int)pageSize;
#pragma mark - 4.3.3.3	获取店家详情
-(AsyncHttpRequest *)getRequestQueryStoreDetail:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId;
#pragma mark - 4.3.3.4	获取店家菜单列表
-(AsyncHttpRequest *)getRequestQueryStoreMenu:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId;
#pragma mark - 4.3.3.5	店家点赞/取消点赞
-(AsyncHttpRequest *)getRequestFavoriteStore:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId;
#pragma mark - 4.3.3.6	店铺评价
-(AsyncHttpRequest *)getRequestStoreComments:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId content:(NSString *)content;
#pragma mark - 4.3.3.7	获取店铺评价列表
-(AsyncHttpRequest *)getRequestStoreCommentsList:(id<AsyncHttpRequestDelegate>)delegate storeId:(NSString *)storeId pageNo:(int)pageNo pageSize:(int)pageSize;

#pragma mark - 4.3.4	我的
#pragma mark - 4.3.4.1	查看我的船票订单列表


#pragma mark - 4.3.4.4	查看我报名的活动列表
-(AsyncHttpRequest *)getRequestQueryMyActivity:(id<AsyncHttpRequestDelegate>)delegate activityStatus:(int)activityStatus pageNo:(int)pageNo pageSize:(int)pageSize;
#pragma mark - 4.3.4.5	修改密码
-(AsyncHttpRequest *)getRequestUpdateMyPassword:(id<AsyncHttpRequestDelegate>)delegate oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword checkPassword:(NSString *)checkPassword;
#pragma mark - 4.3.4.6	图片上传

#pragma mark - 4.3.4.7	修改个人信息
-(AsyncHttpRequest *)getRequestUpdatePerson:(id<AsyncHttpRequestDelegate>)delegate user:(IUser*)iUser;
#pragma mark - 4.3.4.8	注销
-(AsyncHttpRequest *)getRequestlogout:(id<AsyncHttpRequestDelegate>)delegate;

#pragma mark - 4.3.4.9	登录
-(AsyncHttpRequest *)getRequestLogin:(id<AsyncHttpRequestDelegate>)delegate  name:(NSString *)name psd:(NSString *)psd;
#pragma mark - 4.3.4.10	注册
-(AsyncHttpRequest *)getRequestReg:(id<AsyncHttpRequestDelegate>)delegate  account:(NSString *)account psd:(NSString *)psd authCode:(NSString *)authCode;
#pragma mark - 4.3.4.11	获取/验证短信验证码
-(AsyncHttpRequest *)getRequestSmsCode:(id<AsyncHttpRequestDelegate>)delegate  account:(NSString *)account method:(NSString *)method smsCode:(NSString *)smsCode;
#pragma mark - 4.3.4.12	重置密码
-(AsyncHttpRequest *)getRequestResetPassword:(id<AsyncHttpRequestDelegate>)delegate  phone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode;



#pragma mark - 4.3.4.14	建议反馈
-(AsyncHttpRequest *)getRequestSuggestion :(id<AsyncHttpRequestDelegate>)delegate  content:(NSString *)content;

#pragma mark - 4.3.4.16 删除我的活动
-(AsyncHttpRequest *)getRequestDelMyActivity :(id<AsyncHttpRequestDelegate>)delegate  activityId:(NSString *)activityId;

#pragma mark - 4.3.5	船票
#pragma mark - 4.3.5.1 获取航线列表
-(AsyncHttpRequest *)getRequestQueryShipLine:(id<AsyncHttpRequestDelegate>)delegate;

#pragma mark - 4.3.5.2 获取航程信息
-(AsyncHttpRequest *)getRequestQueryVoyage:(id<AsyncHttpRequestDelegate>)delegate info:(VoyageRequestPar *)par;

#pragma mark - 4.3.5.3 船票下订单
-(AsyncHttpRequest *)getRequestSubmitBooking:(id<AsyncHttpRequestDelegate>)delegate info:(TicketOrder *)order;

#pragma mark - 4.3.6  消息

#pragma mark - 4.3.6.3根据消息id获取消息详情
-(AsyncHttpRequest *)getRequestGetMsgById:(id<AsyncHttpRequestDelegate>)delegate msgId:(NSString *)msgId;

#pragma mark - 4.3.6.4获取用户未读消息
-(AsyncHttpRequest *)getRequestGetUserUnreadMsg:(id<AsyncHttpRequestDelegate>)delegate type:(NSString *)tType;

#pragma mark -  把ios的token发到tms
-(AsyncHttpRequest *)getRequestUploadDeviceId:(id<AsyncHttpRequestDelegate>)delegate token:(NSString *)token;


@end
