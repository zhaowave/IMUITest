//
//  Level3ViewController.h
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/21.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Level3ViewController : UIViewController
@property UIButton *bakToRootViewBtn;
@property UILabel *userName;
@property UIImageView *headImageView;
- (void) onBakToRootViewBtn;
- (void) onLeftBarButtonItem;
- (id) initWithUserName:(NSString*)name;
@end
