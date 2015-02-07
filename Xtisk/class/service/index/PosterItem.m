//
//  PosterItem.m
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "PosterItem.h"
#import "XTFileManager.h"
#import "PublicDefine.h"
#define POSTER_PLIST_NAME @"index_poster.plist"
#define kPosterPlist @"kPoster"
@implementation PosterItem

+(void)savePosterData:(NSArray *)arr{
    if (!arr) {
        return;
    }
    
    [arr writeToFile:PathDocFile(POSTER_PLIST_NAME) atomically:YES];
}
+(NSArray *)getPosterData{
//    NSString *tp = PathDocFile(POSTER_PLIST_NAME);
    BOOL b = [XTFileManager isExistFile:PathDocFile(POSTER_PLIST_NAME)];
    if (b) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:PathDocFile(POSTER_PLIST_NAME)];
        return arr;
    }else{
        return nil;
    }
    return nil;
}
+(NSArray *)getPosterItemsWithArr:(NSArray *)arr{
    if (!arr) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i<arr.count;i++) {
        PosterItem * pi = [[PosterItem alloc]init];
        NSDictionary *dic = [arr objectAtIndex:i];
        pi.posterTitle = [dic objectForKey:@"posterTitle"];
        pi.posterPic = [dic objectForKey:@"posterPic"];
        pi.posterUrl = [dic objectForKey:@"posterUrl"];
        [mArr addObject:pi];
    }
    return mArr;
}
+(PosterItem *)getPosterItemWithDic:(NSDictionary *)dic{
    return nil;
}
@end
