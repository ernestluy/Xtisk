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


+(NSData *)strToData:(NSString *)str;

+(NSString*)getJsonStrWithObj:(id)obj;

+(id)getObjWithJsonStr:(NSString *)jsonStr;
+(id)getObjWithJsonData:(NSData *)jsonData;
@end
