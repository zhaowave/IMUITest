//
//  Level2TableViewCell.m
//  Exercise1
//
//  Created by ccis on 16/6/27.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "Level2TableViewCell.h"

@implementation Level2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    _headImageView.layer.cornerRadius = 20.0f;
    [_headImageView.layer setMasksToBounds:YES];
    
    _label = [[UILabel alloc] initWithFrame:self.frame];
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:16];
    _label.numberOfLines = 0;
    _label.textAlignment = 0;
    
    UIImage *image = [UIImage imageNamed:@"bubble.png"];
    _backgroundImageOflabel = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)]];
    //_backgroundImageOflabel = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(100, 100, 100, 100)]];
  //  UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    [self.contentView addSubview:_headImageView];
    [self.contentView addSubview:_backgroundImageOflabel];
    [self.contentView addSubview:_label];
    return self;
    
}

- (void) labelHeightByString:(NSString *) string {
    NSDictionary *attrs = @{NSFontAttributeName: self.label.font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    _backgroundImageOflabel.frame = CGRectMake(50, 0, rect.size.width+45, rect.size.height+30);//_label.frame;
    self.label.frame = CGRectMake(_backgroundImageOflabel.frame.origin.x + 30, _backgroundImageOflabel.frame.origin.y + 10, rect.size.width, rect.size.height);
    _label.text = string;
}
@end
