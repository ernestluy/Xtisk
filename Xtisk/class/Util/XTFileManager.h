//
//  XTFileManager.h
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XTFileManager : NSObject


+(XTFileManager *)shareInstance;


+(BOOL)createDirAtPath:(NSString *)dir;
+(BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;
@end
