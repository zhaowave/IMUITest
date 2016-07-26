//
//  AppDelegate.h
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/20.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "WecomeViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
- (void) notificationRun;
@end

