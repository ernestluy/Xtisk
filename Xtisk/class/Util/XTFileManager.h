//
//  XTFileManager.h
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XTFileManager : NSObject


+(XTFileManager *)shareInstance;

+(BOOL)isExistFile:(NSString *)file;
+(BOOL)createDirAtPath:(NSString *)dir;
+(BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;
+(UIImage *)getTmpFolderFileWithPath:(NSString *)path;
+(UIImage *)getTmpFolderFileWithUrlPath:(NSString *)path;
+(void)saveTmpFolderFileWithUrlPath:(NSString *)path with:(UIImage *)img;
@end
