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
#define kDATABASE_REAL_PATH [NSString stringWithFormat:@"%@/Documents/%@.%@",NSHomeDirectory(),DATABASE_PATH,DATABASE_TYPE]

@interface DBManager : NSObject

//初始化数据库
+ (BOOL) initDB;
+ (BOOL) checkDocumentDir;
+ (NSString *) getDocumentDir;

+ (BOOL) queryWithSql:(NSString*) sql inDBOfPath:(NSString*) dbPath;

+ (int) updateWithSqls:(NSArray*) sqls inDBOfPath:(NSString*) dbPath;
@end

