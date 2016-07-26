//
//  Level2TableViewCell.h
//  Exercise1
//
//  Created by ccis on 16/6/27.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Level2TableViewCell : UITableViewCell
@property (strong, nonatomic ) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *backgroundImageOflabel;
- (void) labelHeightByString:(NSString *) string;
@end
