//
//  ViewController.m
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/20.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.toolbar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:247/255.0f green:49/255.0f blue:28/255.0f alpha:1.0]];
    //编辑按钮
    //[self.navigationItem setRightBarButtonItem:self.editButtonItem]; //编辑按钮
    //self.title = @"Data";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //_tableView.backgroundColor = [UIColor whiteColor];
    //_tableView.separatorColor = [UIColor blueColor];
    //[_tableView setEditing:YES animated:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataArray = [[NSMutableArray alloc] init];

    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44+10+5, [[UIScreen mainScreen] bounds].size.width, 40)];
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.showsCancelButton = NO;
    _searchBar.delegate = self;
    _searchBar.placeholder = @"key word";
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.searchBar.hidden = NO;
    
    
    
    _tableView.tableHeaderView = _searchBar;

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"data" ofType:@"plist"];
    _dataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    //从数据库获取原始数据
    /*
    CellInfoDB *dbManager = [[CellInfoDB alloc] init];
    for (int i=0; i<5; i++) {
        NSString *queryKey = [NSString stringWithFormat:@"%d",i];
        CellInfo *info = [dbManager findByTitle:queryKey];
        [_dataArray addObject:info];
    }
    */
    
    /*
    从data.plist文件读取数据到array
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"data" ofType:@"plist"];
    _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    */
    //CellInfoDB *dbManager = [[CellInfoDB alloc] init];
   // [dbManager initData]; 已经加入原始数据50条
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }else{
        return _dataDict.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //+1 for add a cell
    if (tableView == _searchDisplayController.searchResultsTableView) {
        [self searchWithString:_searchDisplayController.searchBar.text];
                return _searchReturnArray.count;
    }else {
        if (section == 0) {
            return [[_dataDict objectForKey:@"array0"] count];
        }else {
            return [[_dataDict objectForKey:@"array1"] count];
        }
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    static NSString *CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    NSInteger row = [indexPath row];
    
    //true if add
    BOOL b_add = (row == _dataArray.count);

    //CellInfo *info = [self.dataArray objectAtIndex:row];
    if(!b_add){
        cell.textLabel.text = [_dataArray objectAtIndex:row];//info.title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)row];//info.title;
    
            //设置单元格的图标`
        if (row>0&&row<7) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)row]];
            cell.imageView.image = image;
        }else {
            cell.imageView.image = nil;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {//the cell to be added
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"contactCell";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (tableView == _searchDisplayController.searchResultsTableView) {
        cell.nameLabel.text = [_searchReturnArray objectAtIndex:row];
        cell.headImageView.image = [UIImage imageNamed:cell.nameLabel.text];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        _dataArray = [_dataDict objectForKey:[NSString stringWithFormat:@"array%ld",(long)section]];
        if (section == 0) {
            cell.nameLabel.text = [_dataArray objectAtIndex:row];
            cell.headImageView.image = [UIImage imageNamed:cell.nameLabel.text];
        }else {
            BOOL b_add = (row == _dataArray.count);
            if(!b_add){
                cell.nameLabel.text = [_dataArray objectAtIndex:row];
                //设置单元格的图标
                UIImage *image = [UIImage imageNamed:cell.nameLabel.text];
                cell.headImageView.image = image;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else {//the cell to be added
                cell.nameLabel.text = @"";
                cell.headImageView.image = nil;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    //[_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    ContactTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    Level2ViewController *lv2ViewController = [[Level2ViewController alloc] init];
    
    lv2ViewController.title = cell.nameLabel.text;
    [self.navigationController pushViewController:lv2ViewController animated:YES];
    /*
     测试 UIAlertController的使用
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"caution!" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok");
        Level2ViewController *lv2ViewController = [[Level2ViewController alloc] init];
        lv2ViewController.title = [NSString stringWithFormat:@"%ld",(long)row];
        [self.navigationController pushViewController:lv2ViewController animated:NO];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:^{
        ;
    }];
     */
    
}
//set cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 60.0;
}
//设置不同行的编辑样式 delete or insert or none
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath; {
    if (indexPath.row == _dataArray.count) {
        return UITableViewCellEditingStyleInsert;
    } else return UITableViewCellEditingStyleDelete;
}

//commit editing
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //delete one row
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [_dataArray insertObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] atIndex:[_dataArray count]];
        [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView reloadData];
    
}
//选中是否高亮
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == _dataArray.count) {
        return NO;
    }
    else
        return YES;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [NSString stringWithFormat:@"Manager (%lu)",[[_dataDict objectForKey:[NSString stringWithFormat:@"array%ld",(long)section]] count]];
    }
    return [NSString stringWithFormat:@"Other (%lu)",[[_dataDict objectForKey:[NSString stringWithFormat:@"array%ld",(long)section]] count]];
}
/*
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (tableView != _searchDisplayController.searchResultsTableView) {
        if (section == 0) {
            return  @"array 1 footer";
        }
        return @"array 1 footer";
    }
    return @"";
}
*/
//editable

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:YES];
    [_tableView setEditing:editing animated:YES];
}

//search UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString {
    [self searchWithString:searchString];
    NSLog(@"%@",_searchReturnArray);
    return YES;
}

- (void) searchWithString:(NSString*)searchString {
    if (searchString.length == 0) {//查询全部数据
        _searchReturnArray = [NSMutableArray arrayWithArray:_dataArray];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchString];
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSArray *arr in _dataDict) {
        [tmpArray addObjectsFromArray:[_dataDict[arr] filteredArrayUsingPredicate:predicate]];
    }
    _searchReturnArray = [NSMutableArray arrayWithArray:tmpArray];
}
/*
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@",searchText);
    NSLog(@"display delegate %@",searchText);
    if (searchText.length == 0) {//查询全部数据
        _searchReturnArray = [NSMutableArray arrayWithArray:_dataArray];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    NSArray *tmp = [_dataArray filteredArrayUsingPredicate:predicate];
    _searchReturnArray = [NSMutableArray arrayWithArray:tmp];
    [_tableView reloadData];
}*/
@end
