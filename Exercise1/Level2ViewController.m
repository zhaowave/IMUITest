//
//  Level2ViewController.m
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/20.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "Level2ViewController.h"

@interface Level2ViewController ()

@end

@implementation Level2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *itemTitle = [[UILabel alloc] init];
    [itemTitle setTextColor:[UIColor whiteColor]];
    itemTitle.text = self.title;
    self.navigationItem.titleView = itemTitle;
    [itemTitle sizeToFit];
    

// self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    
    //键盘相关
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //textfield
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];

    
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<8; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:247/255.0f green:49/255.0f blue:28/255.0f alpha:1.0]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+70, self.view.frame.size.width, self.view.frame.size.height-40-70) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc] init];
    gesture.delegate = self;
    gesture.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:gesture];
    
    
    _nextLevel = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStylePlain target:self action:@selector(onNextLevel)];
    _nextLevel.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:_nextLevel];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftBarButtonItem)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 40, [[UIScreen mainScreen] bounds].size.width,40)];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_toolBar.frame.origin.x+10, _toolBar.frame.origin.y+5, [[UIScreen mainScreen] bounds].size.width-20,30)];
    _textField.backgroundColor = [UIColor lightGrayColor];
    _textField.delegate = self;
    //设置返回按钮类型
    _textField.keyboardType = UIKeyboardTypeNamePhonePad;
    _textField.returnKeyType = UIReturnKeySend;
    _textField.layer.borderColor = [[UIColor grayColor] CGColor];
    _textField.layer.borderWidth = 1.0f;
    _textField.placeholder = @"input some character";
    
    _sendMessageView = [[SendMessageView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 40, [[UIScreen mainScreen] bounds].size.width,40)];
    _sendMessageView.messageField.delegate = self;
    //代理实先的方式 有问题
    
    //_sendMessageView.delegate = self;
    [_sendMessageView.sendButton addTarget:self action:@selector(onSendmessage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_sendMessageView];
    [self.view addSubview:_tableView];
    
    //将原有的工具栏 ＋ 输入框，改为重写的 sendMessageView
    //[self.view addSubview:_toolBar];
    //[self.view addSubview:_textField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) onNextLevel {
    Level3ViewController *lv3ViewController = [[Level3ViewController alloc] initWithUserName:self.title];
    lv3ViewController.title = self.title;
    [self.navigationController pushViewController:lv3ViewController animated:YES];
}

- (void) onLeftBarButtonItem {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"number of row in section %lu",_dataArray.count);
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Lv2CellID = @"lv2CellID";
    NSInteger row = indexPath.row;
    Level2TableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:Lv2CellID];
    if (cell == nil) {
        cell = [[Level2TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Lv2CellID];
    }
    cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.title]];
    NSString *tmpText = [_dataArray objectAtIndex:row];
    [cell labelHeightByString:tmpText];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSString *tmpText = [_dataArray objectAtIndex:row];
    CGSize size = [tmpText sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(280, 9999.0f) lineBreakMode:NSLineBreakByCharWrapping];
    //NSLog(@"height for row at index path %f",size.height);
    return size.height + 40;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}// became first responder

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _sendMessageView.sendButton.backgroundColor = [UIColor grayColor];;
    [textField resignFirstResponder];
    if([textField.text isEqualToString:@""]){
        return YES;
    }
    [_dataArray addObject:textField.text];
    [textField setText:@""];
    
    [_tableView reloadData];
    
    NSInteger row = _dataArray.count - 1;
    if (row >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    return YES;
}

//发送按钮点击的响应函数
- (void)onSendmessage {
    [self textFieldShouldReturn:_sendMessageView.messageField];
}

//notification
- (void)keyboardWillShow:(NSNotification *)nofification
{
    NSDictionary *info = [nofification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    double keyBoardHeight = rect.size.height;
    //NSLog(@"keyboard height %lf",keyBoardHeight);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, -1*keyBoardHeight, self.view.frame.size.width, self.view.frame.size.height);
        //_tableView.frame = CGRectMake(0, 260, _tableView.frame.size.width, _tableView.frame.size.height);
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)nofification
{
   // NSLog(@"keyboard will hide");
    [UIView animateWithDuration:0.3 animations:^{
       self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //_tableView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height);
    }];
}
//监测 textfield 中的字符变化情况，改变发送按钮的颜色， 回调函数
- (void) textChange {
    if (_sendMessageView.messageField.text.length != 0) {
        _sendMessageView.sendButton.backgroundColor = [UIColor redColor];
    }
}

// 暂时没用
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_sendMessageView.messageField resignFirstResponder];
}

//实现 触摸 屏幕 隐藏键盘
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //[_tableView endEditing:YES];
    [_sendMessageView.messageField resignFirstResponder];
    return YES;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
