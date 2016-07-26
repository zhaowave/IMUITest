//
//  CellInfoDB.m
//  Exercise1
//
//  Created by ccis on 16/6/23.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "CellInfoDB.h"



@implementation CellInfoDB

- (NSString *) dbFilePath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:CELLINFODBNAME];
    return filePath;
}
//if ok return 1;if error return -1
- (int) createCellInfoTable {
    NSString *filePath = [self dbFilePath];
    if (sqlite3_open(filePath.UTF8String, &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"open failed!");
        return -1;
    }else {  //create table
        NSString *sql = @"CREATE TABLE IF NOT EXISTS cellinfo(title Text,detail Text,id INTEGER PRIMARY KEY AUTOINCREMENT);";
        NSLog(@"%@",sql);
        if (sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"sqlite execute failed");
            return -1;
        }
        sqlite3_close(db);
    }
    return 1;
}
- (int) addCellInfoByTitle:(NSString*)title andDetail:(NSString *) detail {
    NSString *filePath = [self dbFilePath];
    if (sqlite3_open(filePath.UTF8String, &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"open failed!");
        return -1;
    }else {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO cellinfo(title,detail) VALUES(\'%@\',\'%@\')",title,detail];
        NSLog(@"%@",sql);
        if (sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"insert failed!");
            return -1;
        }
        sqlite3_close(db);
        return 1;
    }
}
- (CellInfo *) findByTitle:(NSString *)title {
    NSString *filePath = [self dbFilePath];
    if (sqlite3_open(filePath.UTF8String, &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"open failed!");
        return nil;
    }else {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM cellinfo WHERE title=\'%@\'",title];
        NSLog(@"%@",sql);
        sqlite3_stmt *statement;
        sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *title = sqlite3_column_text(statement, 0);
            const unsigned char *detail = sqlite3_column_text(statement, 1);
            CellInfo *ret = [[CellInfo alloc] init];
            ret.title = [NSString stringWithUTF8String:(char*)title];
            ret.detail = [NSString stringWithUTF8String:(char*)detail];
            return ret;
        }
    }
    return nil;
}

- (int) initData {
    [self createCellInfoTable];
    for (int i = 0; i<50 ;i++) {
        NSString *title = [NSString stringWithFormat:@"%d",i];
        NSString *detail = [NSString  stringWithFormat:@"第%d行",i];
        [self addCellInfoByTitle:title andDetail:detail];
    }
    return 1;
}

@end
