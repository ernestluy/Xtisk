//
//  XTFileManager.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
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
        b = [XTFileManager writeImage:[UIImage imageNamed:@"1-1.jpg"] toFileAtPath:PathTmpFile(@"1-1.jpg")];
        NSLog(@"b:%d",b);
    }
    return self;
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

@end
