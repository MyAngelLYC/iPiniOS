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

- (void)initDatabase
{
    //打开数据库文件，第一次打开的时候可能不在Document文件目录中
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"iPin.sqlite"];
    sqlite3_open([databaseFilePath UTF8String], &database);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:databaseFilePath])
    {
        //NSString *defaultDBPath=[[NSBundle mainBundle] pathForResource:@"iPin" ofType:@"sqlite"];
        //[fileManager copyItemAtPath:defaultDBPath toPath:databaseFilePath error:nil];
        NSLog(@"Database file does not exist!");
    }
    
    //构造数据库结构
    NSString *sqlCmd=@"create table if not exists loginUser (ID varchar(9),username nvarchar(20),password varchar(32),sex varchar(10),telephone varchar(11),auth varchar(1),StudentID varchar(9),PersonID varchar(6),autoLogin int(1))";
    [self execSQL:sqlCmd];
    sqlCmd=@"create table if not exists info (GroupID varchar(9),info_userID varchar(9),info_username nvarchar(20),info_sex int(1),info_from nvarchar(20),info_to nvarchar(20),info_date varchar(20),info_detail nvarchar(300),info_time varchar(20),memberCount int(1),telephone varchar(11))";
    [self execSQL:sqlCmd];
    sqlCmd=@"create table if not exists nearby (nearby_ID varchar(9),nearby_username nvarchar(20),nearby_sex int(1),nearby_telephone varchar(11),nearby_distance varchar(5),nearby_destination nvarchar(20))";
    [self execSQL:sqlCmd];
    [self closeDatabase];
}

- (void)openDatabase
{
    if(database==nil)
    {
        NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"iPin.sqlite"];
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

- (int)execSQL:(NSString *)sqlCmd
{
    [self openDatabase];
    int result=sqlite3_exec(database, [sqlCmd UTF8String], NULL, NULL, NULL);
    [self closeDatabase];
    return result;
}

@end
