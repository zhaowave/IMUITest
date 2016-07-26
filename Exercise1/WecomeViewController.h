//
//  WecomeViewController.h
//  Exercise1
//
//  Created by ccis on 16/6/23.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface WecomeViewController : UIViewController<UIScrollViewDelegate>
@property UIScrollView *scrollView;
@property UIPageControl *pageControl;
- (void) pageChanged;
- (void) onWelcome;
@end
