//
//  XTFileManager.m
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "XTFileManager.h"
#import "PublicDefine.h"
@implementation XTFileManager

+(XTFileManager *)shareInstance{
    static XTFileManager *instance = nil;
    if (instance == nil) {
        @synchronized(self){
            if (instance == nil) {
                instance = [[XTFileManager alloc]init];
            }
        }
    }
    return instance;
}
-(id)init{
    self = [super init];
    if (self) {
        NSString *imageDir = PathDocumentsHeadIcon;
//        NSString *tmpDir = PathTmpFile(@"header.png");

        BOOL b = [XTFileManager createDirAtPath:imageDir];
//        b = [XTFileManager writeImage:[UIImage imageNamed:@"1-1.jpg"] toFileAtPath:PathTmpFile(@"1-1.jpg")];
        
        b = [XTFileManager createDirAtPath:tPathTmpDir];
        NSLog(@"b:%d",b);
    }
    return self;
}
+(BOOL)isExistFile:(NSString *)file{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:file isDirectory:&isDir];
    if (existed) {
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)createDirAtPath:(NSString *)dir{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dir isDirectory:&isDir];
    if (existed) {
        return YES;
    }
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return isDir;
}

+(BOOL)deleteFileAtPath:(NSString *)filePath{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager removeItemAtPath:filePath error:&error] != YES){
        
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        return NO;
    }
    return YES;
}

+(BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath
{
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return NO;
    //NSLog(@"aPath:%@",aPath);
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        if ([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(image);
        }
        else
        {
            imageData = UIImageJPEGRepresentation(image, 0);
        }
        
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    
    return NO;
}

+(UIImage *)getTmpFolderFileWithPath:(NSString *)path{
    if (path == nil) {
        return nil;
    }
    NSString *tp = PathTmpFile(path);
    return [UIImage imageWithContentsOfFile:tp];
}
+(UIImage *)getTmpFolderFileWithUrlPath:(NSString *)path{
    if (path == nil) {
        return nil;
    }
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *tp = PathTmpFile(path);
    return [UIImage imageWithContentsOfFile:tp];
}

+(void)saveTmpFolderFileWithUrlPath:(NSString *)path with:(UIImage *)img{
    if (!img) {
        return;
    }
    if (path == nil) {
        return;
    }
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *tp = PathTmpFile(path);
    [XTFileManager writeImage:img toFileAtPath:tp];
}

+(UIImage *)getCacheFolderFileWithUrlPath:(NSString *)path{
    if (path == nil) {
        return nil;
    }
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *tp = PathCacheFile(path);
    return [UIImage imageWithContentsOfFile:tp];
}

+(void)saveCacheFolderFileWithUrlPath:(NSString *)path with:(UIImage *)img{
    if (!img || !path) {
        return;
    }
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *tp = PathCacheFile(path);
    [XTFileManager writeImage:img toFileAtPath:tp];
}



+(UIImage *)getDocFolderFileWithUrlPath:(NSString *)path{
    if (path == nil) {
        return nil;
    }
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *tp = PathDocFile(path);
    return [UIImage imageWithContentsOfFile:tp];
}
+(void)saveDocFolderFileWithUrlPath:(NSString *)path with:(UIImage *)img{
    if (!img || !path) {
        return;
    }
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *tp = PathDocFile(path);
    [XTFileManager writeImage:img toFileAtPath:tp];
}

@end
