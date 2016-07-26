//
//  Level3ViewController.m
//  Exercise1
//
//  Created by kfzxbj001 on 16/6/21.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "Level3ViewController.h"

@interface Level3ViewController ()

@end

@implementation Level3ViewController

- (id) initWithUserName:(NSString*)name {
    self = [super init];
    if (self) {
        _userName = [[UILabel alloc] init];
        _userName.text = name;
        _userName.textAlignment = 1;
        _userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:26];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:247/255.0f green:49/255.0f blue:28/255.0f alpha:1.0]];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
   // self.navigationController.navigationBar.barTintColor = ;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftBarButtonItem)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UILabel *itemTitle = [[UILabel alloc] init];
    [itemTitle setTextColor:[UIColor whiteColor]];
    itemTitle.text = @"详情";
    self.navigationItem.titleView = itemTitle;
    [itemTitle sizeToFit];
    
    //self.navigationItem.title = @"详情";
    //[self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    _bakToRootViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bakToRootViewBtn.layer setCornerRadius:9];
    _bakToRootViewBtn.frame = CGRectMake(0, 400, self.view.frame.size.width, 40);
    [_bakToRootViewBtn setTitle:@"返回列表" forState:UIControlStateNormal];
    [_bakToRootViewBtn setBackgroundColor:[UIColor redColor]];
    [_bakToRootViewBtn addTarget:self action:@selector(onBakToRootViewBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 50, 180, 100, 100)];
    _headImageView.backgroundColor = [UIColor clearColor];
    _headImageView.image = [UIImage imageNamed:_userName.text];
    
    _userName.frame = CGRectMake(self.view.frame.size.width/2 - 100, 100, 200, 50);
    [self.view addSubview:_headImageView];
    [self.view addSubview:_userName];
    [self.view addSubview:_bakToRootViewBtn];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[_bakToRootViewBtn.];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onBakToRootViewBtn {
    //NSLog(@"%@",self.navigationController.viewControllers);
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0
                                                    ] animated:YES];
    
}
- (void) onLeftBarButtonItem {
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
