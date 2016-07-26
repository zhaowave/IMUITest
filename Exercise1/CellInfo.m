//
//  CellInfo.m
//  Exercise1
//
//  Created by ccis on 16/6/23.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "CellInfo.h"

@implementation CellInfo
- (id) init {
    self = [super init];
    if (self) {
        
        _title = @"default title";
        _detail = @"default detail";
    }
    return  self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@  detail:%@",_title,_detail];
}

@end
