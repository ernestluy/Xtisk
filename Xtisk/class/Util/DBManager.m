//
//  DBManager.m
//  ImApp
//
//  Created by li rui on 12-10-9.
//  Copyright (c) 2012年 zte. All rights reserved.
//

#import "DBManager.h"
#import "PublicDefine.h"
@interface FMDatabase (Execute)

-(BOOL)executeSqlWithSQLFilePath:(NSString *)sqlFilePath;
@end
@implementation FMDatabase(Execute)
//SQLITE_API int sqlite3_exec(
//                            sqlite3*,                                  /* An open database */
//                            const char *sql,                           /* SQL to be evaluated */
//                            int (*callback)(void*,int,char**,char**),  /* Callback function */
//                            void *,                                    /* 1st argument to callback */
//                            char **errmsg                              /* Error msg written here */
//                            );
-(BOOL)executeSqlWithSQLFilePath:(NSString *)sqlFilePath{
    NSString  *sql=[[NSString alloc]initWithContentsOfFile:sqlFilePath encoding:NSUTF8StringEncoding error:NULL];
    
    int err = sqlite3_exec(_db,[sql cStringUsingEncoding:NSUTF8StringEncoding],NULL,NULL,NULL  );
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }
    
    return YES;
}
@end
/*
 对性能的测试：
 插入50万条数据（两列）时间：7.5秒
 删除10万条数据（两列）时间：0.4秒
 */

@implementation DBManager

static NSString* documentDir = nil;

+ (BOOL) initDB{
    NSLog(@"kDATABASE_REAL_PATH is %@",kDATABASE_REAL_PATH);
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:kDATABASE_REAL_PATH];
    if(fileExists) return YES;
    
    FMDatabase* tempDB = [FMDatabase databaseWithPath:kDATABASE_REAL_PATH];
    
    if([tempDB open]){ // create database file if not exists.
        //execute database sql file .
       [tempDB executeSqlWithSQLFilePath: [[NSBundle mainBundle]pathForResource:DATABASE_PATH ofType:@"sql"]];
        [tempDB close];
        return YES;
    }
    return NO;
}

+ (BOOL) checkDocumentDir{
    if(!documentDir){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentDir = [paths objectAtIndex:0];
    }
    if (documentDir) {
        return YES;
    }else{
        return NO;
    }
    return YES;//(BOOL)documentDir;
}

+ (NSString *) getDocumentDir{
    NSString *str = documentDir;
    return str;
}

+ (BOOL) createDBWithName:(NSString*) dbName{
    if(![self checkDocumentDir]){
        return FALSE;
    }
    
    return TRUE;
}

+ (BOOL) queryWithSql:(NSString*) sql inDBOfPath:(NSString*) dbPath{
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        //NSLog(@"the query sql is %@",sql);
        FMResultSet * rs = [db executeQuery:sql];
        if([rs next])
        {
            [db close];
            return TRUE;
        }
    }
    return FALSE;
}

+ (int) updateWithSqls:(NSArray*) sqls inDBOfPath:(NSString*) dbPath{
    FMDatabaseQueue* myQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    FMDatabase* myDB = [FMDatabase databaseWithPath:dbPath];
    
    if(!myQueue || !myDB){
        return FALSE;
    }
    
    __block int successCount = 0;
    
    [myQueue inTransaction:^(FMDatabase* myDB, BOOL* rollback){
        int count = (int)[sqls count];
        NSString* sql;
        for(int i = 0; i < count; i++){
            sql = [sqls objectAtIndex:i];
            if(sql){
                if([myDB executeUpdate:sql]){
                    successCount++;
                }
            }
        }
    }];
    
    return successCount;
}

@end
