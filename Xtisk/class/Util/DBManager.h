//
//  DBManager.h
//  ImApp
//
//  Created by li rui on 12-10-9.
//  Copyright (c) 2012年 zte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#define  kDBPATH_IN_DOCUMENT YES
#define kDATABASE_REAL_PATH kDBPATH_IN_DOCUMENT?([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@.%@",DATABASE_PATH,DATABASE_TYPE]) :([[NSBundle mainBundle] pathForResource:DATABASE_PATH ofType:DATABASE_TYPE])

@interface DBManager : NSObject

//初始化数据库
+ (BOOL) initDB;
+ (BOOL) checkDocumentDir;
+ (NSString *) getDocumentDir;


@end

