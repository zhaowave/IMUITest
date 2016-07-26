//
//  ContactTableViewCell.m
//  Exercise1
//
//  Created by ccis on 16/6/27.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "ContactTableViewCell.h"
#define CONTACT_CELL_HEIGHT 60

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, CONTACT_CELL_HEIGHT);
        
        //head image setting
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _headImageView.layer.cornerRadius = 20.0f;
        [_headImageView.layer setMasksToBounds:YES];
        
        //name label setting
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, [UIScreen mainScreen].bounds.size.width - 60-30, CONTACT_CELL_HEIGHT)];
        _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        //[UIFont boldSystemFontOfSize:<#(CGFloat)#>];
        
        [self.contentView addSubview:_headImageView];
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
@end
