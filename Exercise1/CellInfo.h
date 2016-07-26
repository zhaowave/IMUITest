//
//  CellInfo.h
//  Exercise1
//
//  Created by ccis on 16/6/23.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellInfo : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;

- (id) init;
- (void)dealloc;
- (NSString *)description;
@end
