//
//  CellInfoDB.h
//  Exercise1
//
//  Created by ccis on 16/6/23.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellInfo.h"
#import "sqlite3.h"

#define CELLINFODBNAME @"cellinfo.sqlite3"
@interface CellInfoDB : NSObject {
    sqlite3 *db;
}
- (NSString *) dbFilePath;
- (int) createCellInfoTable;
- (int) addCellInfoByTitle:(NSString*)title andDetail:(NSString *) detail;
- (CellInfo *) findByTitle:(NSString *)title;
- (int) initData;
@end
