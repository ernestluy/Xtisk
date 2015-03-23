//
//  Util.h
//  Xtisk
//
//  Created by 卢一 on 15-1-31.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage (Extras)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
@end
@interface Util : NSObject

+(NSString *)strToUrlStr:(NSString *)str;

+(NSData *)strToData:(NSString *)str;

+(NSString*)getJsonStrWithObj:(id)obj;

+(id)getObjWithJsonStr:(NSString *)jsonStr;
+(id)getObjWithJsonData:(NSData *)jsonData;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

-(NSString *)getTradeStatus:(int)tag;

+(CGRect)getFrameWithX:(CGRect)r x:(int)x;

+(CGSize) sizeForString:(NSString *)value fontSize:(float)pFontSize andWidth:(float)width;


+(UIColor *)getPayStatusColorWith:(int)status;

+(NSString *)removeCChar:(NSString *)str;


-(int)compare:(NSDate *)fDate mid:(NSDate *)mDate last:(NSDate *)lDate;

@end
