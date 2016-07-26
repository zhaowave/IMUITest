//
//  WecomeViewController.m
//  Exercise1
//
//  Created by ccis on 16/6/23.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "WecomeViewController.h"

@interface WecomeViewController ()

@end

@implementation WecomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    _scrollView.frame = self.view.frame;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen.png"]];
    imageView1.frame = CGRectMake(0.0, 0.0f,self.view.frame.size.width, self.view.frame.size.height);
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen.png"]];
    imageView2.frame = CGRectMake(self.view.frame.size.width, 0.0f,self.view.frame.size.width, self.view.frame.size.height);
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen.png"]];
    imageView3.frame = CGRectMake(self.view.frame.size.width*2, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [_scrollView addSubview:imageView1];
    [_scrollView addSubview:imageView2];
    [_scrollView addSubview:imageView3];
    
    UIButton *welcome = [UIButton buttonWithType:UIButtonTypeCustom];
    [welcome setBackgroundColor:[UIColor greenColor]];
    [welcome.layer setCornerRadius:10];
    welcome.frame = CGRectMake(100, 400, 200, 50);
    [welcome setTitle:@"Welcome!" forState:UIControlStateNormal];
    [welcome addTarget:self action:@selector(onWelcome) forControlEvents:UIControlEventTouchUpInside];
    imageView3.userInteractionEnabled = YES;
    [imageView3 addSubview:welcome];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 550, 400, 30)];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControl];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x/self.view.frame.size.width;
}

- (void) pageChanged {
    [UIView animateWithDuration:0.3f animations:^{
        int whichPage = (int)_pageControl.currentPage;
        _scrollView.contentOffset = CGPointMake(self.view.frame.size.width*whichPage, 0.0f);
    }];
}

- (void) onWelcome {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationMain" object:nil];
    //ViewController *viewController = [[ViewController alloc] init];
    //self.navigationController.navigationBar.hidden = NO;
    //[self.navigationController pushViewController:viewController animated:YES];
}


@end
