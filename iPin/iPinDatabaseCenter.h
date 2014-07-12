//
//  iPinDatabaseCenter.h
//  iPin
//
//  Created by 刘亦辰 on 14-7-6.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface iPinDatabaseCenter : NSObject
{
    sqlite3 *database;
}

+ (iPinDatabaseCenter *)sharedInstance;
- (void)openDatabase;
- (void)closeDatabase;
- (sqlite3 *)getDatabase;
- (int)execSQL:(NSString *)sqlCmd;
- (int)execSQL:(NSString *)sqlCmd forResult:(sqlite3_stmt *)statement;
@end

