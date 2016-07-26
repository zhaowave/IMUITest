//
//  ViewController.h
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/20.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level2ViewController.h"
#import "ContactTableViewCell.h"
#import "CellInfoDB.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;
@property (retain, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dataDict;

@property (strong,nonatomic) NSMutableArray *searchReturnArray;
- (void) searchWithString:(NSString*)searchString;
@end

