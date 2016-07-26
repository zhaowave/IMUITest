//
//  Level2ViewController.h
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/20.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level3ViewController.h"
#import "Level2TableViewCell.h"
#import "SendMessageView.h"
@interface Level2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,SendMessageViewDelegate>
@property UIBarButtonItem *nextLevel;
@property UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *dataArray;
@property UIToolbar *toolBar;
@property UITextField *textField;
@property SendMessageView *sendMessageView;
- (void) onNextLevel;
- (void) onLeftBarButtonItem;
@end
