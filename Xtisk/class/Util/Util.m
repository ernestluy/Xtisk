//
//  Util.m
//  Xtisk
//
//  Created by 卢一 on 15-1-31.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "Util.h"
#import "PublicDefine.h"
@implementation  UIImage (Extras)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    
    UIImage *newImage = nil;
    
    CGFloat targetWidth = targetSize.width;
    
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width  = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if(newImage == nil)
        
        NSLog(@"could not scale image");
    
    return newImage ;
    
}

@end
@implementation Util
+(NSString *)strToUrlStr:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+(NSData *)strToData:(NSString *)str{
    char *cStr = (char *)[str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cStr length:(strlen(cStr))];//+1
    return data;
}
+(NSString*)getJsonStrWithObj:(id)obj{
    NSError *err;
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];
    NSString *str = [[NSString alloc]initWithBytes:[data bytes] length:data.length encoding:NSUTF8StringEncoding];
    return str;
}

+(id)getObjWithJsonStr:(NSString *)jsonStr{
    NSError *err;
    char *buffer = ( char *)[jsonStr cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:buffer length:strlen(buffer)];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    return obj;
}
+(id)getObjWithJsonData:(NSData *)jsonData{
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
    return obj;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}


-(NSString *)getTradeStatus:(int)tag{
    switch (tag) {
        case 0:{
            return @"等待买家付款";
            break;
        }
        case 1:{
            return @"等待卖家发货";
            break;
        }
        case 2:{
            return @"等待买家确认收货";
            break;
        }
        case 3:{
            return @"买家已签收";
            break;
        }
        case 4:{
            return @"交易成功";
            break;
        }
        case 5:{
            return @"待退款审批";
            break;
        }
        case 6:{
            return @"付款以后用户退款成功";
            break;
        }
        case 7:{
            return @"卖家或买家主动关闭交易";
            break;
        }
        case 8:{
            return @"管理员关闭交易";
            break;
        }
        case 9:{
            return @"待授权";
            break;
        }
        case 10:{
            return @"待确认";
            break;
        }
        case 11:{
            return @"订单超时";
            break;
        }
        case 12:{
            return @"货到付款";
            break;
        }
        case 13:{
            return @"已确认";
            break;
        }
        case 14:{
            return @"已付款，购票失败";
            break;
        }
        case 15:{
            return @"已付款，未提票";
            break;
        }
        case 16:{
            return @"已付款，已提票";
            break;
        }
        case 17:{
            return @"付款中";
            break;
        }
        case 18:{
            return @"已消票退款";
            break;
        }
        case 19:{
            return @"已付款，已提票";
            break;
        }
        case 20:{
            return @"已付款，部分提票";
            break;
        }
        case 21:{
            return @"其他";
            break;
        }
        default:
            break;
    }
    return @"";
}

/*
 14:已付款，購票失敗；      已支付
 15:已付款，未提票；        已支付
 16:已付款，已提票           已支付
 17:付款中                        待支付
 18:交易號不存在              已过期
 19:已消票退款                 已支付
 20:已付款，部分提票       已支付
 21:其他                          系统异常
 
 待支付、已支付、已过期、+（待审批、待授权、待确认、系统异常）
 其中括号里的不常见，万一出现，客户端的显示跟 已过期一样显示灰色字
 
 (0：待支付 1：已支付 2：待审批 3：已过期 4：待授权  5：待确认  6：系统异常)
 */


+(CGRect)getFrameWithX:(CGRect)r x:(int)x{
    return CGRectMake(x, r.origin.y, r.size.width, r.size.height);
}

+(CGSize) sizeForString:(NSString *)value fontSize:(float)pFontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:pFontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit;
}


+(UIColor *)getPayStatusColorWith:(int)status{
    if(status == 0){
        return listColorPayIng;
    }else if(status == 1){
        return listColorPayOk;
    }else{
        return listColorPayOver;
    }
    return defaultTextColor;
}

+(NSString *)removeCChar:(NSString *)str{
    if (!str) {
        return nil;
    }
    NSMutableString *mStr = [NSMutableString string];
    for (int i = 0; i<str.length; i++) {
        NSRange range = {i,1};
        NSString *indexStr = [str substringWithRange:range];
        char *strc = (char *)[indexStr UTF8String];
        if (strlen(strc) == 1) {
            [mStr appendString:indexStr];
        }
    }
    return mStr;
    
}

+(NSString *)getTelText:(NSString *)str{
    if (!str) {
        return nil;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    str = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    NSMutableString *mStr = [NSMutableString string];
//    for (int i = 0; i<str.length; i++) {
//        NSRange range = {i,1};
//        NSString *indexStr = [str substringWithRange:range];
//        char *strc = (char *)[indexStr UTF8String];
//        if (strlen(strc) == 1) {
//            [mStr appendString:indexStr];
//        }
//    }
//    return mStr;
    return str;
}


-(int)compare:(NSDate *)fDate mid:(NSDate *)mDate last:(NSDate *)lDate{
    
    
    
    
    return  -1;
}


//手机号码 11位  加0 12为 加86 13位
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (!mobileNum) {
        return NO;
    }
    if (mobileNum.length < 11 || mobileNum.length > 13) {
        return NO;
    }
    if (mobileNum.length == 11) {
        NSString *strIndex = [mobileNum substringToIndex:1];
        if (![strIndex isEqualToString:@"1"]) {
            NSLog(@"11位");
            return NO;
        }
    }
    
    if (mobileNum.length == 12) {
        NSString *strIndex = [mobileNum substringToIndex:2];
        if (![strIndex isEqualToString:@"01"]) {
            NSLog(@"12位");
            return NO;
        }
    }
    
    if (mobileNum.length == 13) {
        NSString *strIndex = [mobileNum substringToIndex:3];
        if (![strIndex isEqualToString:@"861"]) {
            NSLog(@"13位");
            return NO;
        }
    }
    
    return YES;
}

+(void)snsShareInitDataWith:(NSString *)shareText url:(NSString *)tUrl{
    [UMSocialData defaultData].extConfig.wechatSessionData.title = shareText;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = tUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareText;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = tUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.wechatFavoriteData.title = shareText;
    [UMSocialData defaultData].extConfig.wechatFavoriteData.url = tUrl;
    [UMSocialData defaultData].extConfig.wechatFavoriteData.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.sinaData.shareText = shareText;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = tUrl;
    //tencentData
    [UMSocialData defaultData].extConfig.tencentData.shareText = shareText;
    [UMSocialData defaultData].extConfig.tencentData.urlResource.url = tUrl;
    
    [UMSocialData defaultData].extConfig.qzoneData.urlResource.url = tUrl;
    [UMSocialData defaultData].extConfig.qzoneData.title = shareText;
    [UMSocialData defaultData].extConfig.qzoneData.url = tUrl;
    
    
}


@end
