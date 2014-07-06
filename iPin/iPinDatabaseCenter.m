//
//  iPinDatabaseCenter.m
//  iPin
//
//  Created by 刘亦辰 on 14-7-6.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinDatabaseCenter.h"

@implementation iPinDatabaseCenter

static iPinDatabaseCenter *sharedSingleton = nil;

+ (iPinDatabaseCenter *) sharedInstance
{
    if (sharedSingleton == nil)
    {
        sharedSingleton = [[iPinDatabaseCenter alloc] init];
    }
    
    return sharedSingleton;
}

- (void)openDatabase
{
    if(database==nil)
    {
        NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"iPin"];
        sqlite3_open([databaseFilePath UTF8String], &database);
    }
}

- (void)closeDatabase
{
    if(database!=nil)
    {
        sqlite3_close(database);
        database=nil;
    }
}

- (sqlite3 *)getDatabase
{
    return database;
}
@end
