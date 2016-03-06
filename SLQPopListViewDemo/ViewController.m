//
//  ViewController.m
//  SLQPopListViewDemo
//
//  Created by Christian on 16/1/3.
//  Copyright © 2016年 slq. All rights reserved.
//

#import "ViewController.h"
#import "SLQPopListView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@property (nonatomic, strong) UIScrollView *scrollView;
/**数据列表*/
@property (nonatomic, strong) NSMutableArray *titles;
@end


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 44)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button = btn;
    [self.scrollView addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 100, 44)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    self.button1 = btn1;
    [self.scrollView addSubview:btn1];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(250, 100, 100, 44)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
    self.button2 = btn2;
    [self.scrollView addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 44)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick3:) forControlEvents:UIControlEventTouchUpInside];
    self.button3 = btn3;
    [self.scrollView addSubview:btn3];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
}

- (void)btnClick1:(UIButton *)btn
{
    for (UIView *subView in self.scrollView.subviews) {
        if (subView.tag == 1314) {
            return;
        }
    }
    SLQPopListView *pop1 = [[SLQPopListView alloc] initWithFrame:CGRectMake(btn.frame.origin.x, CGRectGetMaxY(btn.frame) - self.scrollView.contentOffset.y, 0, 0) withTitleArray:self.titles];
    pop1.tag = 1314;
    __weak UIButton *weakBtn = self.button1;
    pop1.clicked = ^(NSInteger row,NSString *title) {
        [weakBtn setTitle:self.titles[row] forState:UIControlStateNormal];
    };
    
    [pop1 showInView:btn];
}

- (void)btnClick2:(UIButton *)btn
{
    for (UIView *subView in self.scrollView.subviews) {
        if (subView.tag == 1314) {
            return;
        }
    }
    SLQPopListView *pop1 = [[SLQPopListView alloc] initWithFrame:CGRectMake(btn.frame.origin.x , CGRectGetMaxY(btn.frame) - self.scrollView.contentOffset.y, 0, 0) withTitleArray:self.titles];
    pop1.tag = 1314;
    __weak UIButton *weakBtn = self.button2;
    pop1.clicked = ^(NSInteger row,NSString *title) {
        [weakBtn setTitle:self.titles[row] forState:UIControlStateNormal];
    };
    [pop1 showInView:btn];
}

- (void)btnClick3:(UIButton *)btn
{
    for (UIView *subView in self.scrollView.subviews) {
        if (subView.tag == 1314) {
            return;
        }
    }
    SLQPopListView *pop1 = [[SLQPopListView alloc] initWithFrame:CGRectMake(btn.frame.origin.x , CGRectGetMaxY(btn.frame) - self.scrollView.contentOffset.y, 0, 0) withTitleArray:self.titles];
    pop1.tag = 1314;
    __weak UIButton *weakBtn = self.button3;
    pop1.clicked = ^(NSInteger row,NSString *title) {
        [weakBtn setTitle:self.titles[row] forState:UIControlStateNormal];
    };
    [pop1 showInView:btn ];
}

- (void)btnClick:(UIButton *)btn
{
    for (UIView *subView in self.scrollView.subviews) {
        if (subView.tag == 1314) {
            return;
        }
    }
        NSLog(@"%.2f",self.scrollView.contentOffset.y);
    SLQPopListView *pop1 = [[SLQPopListView alloc] initWithFrame:CGRectMake(btn.frame.origin.x, CGRectGetMaxY(btn.frame) -self.scrollView.contentOffset.y, 0, 0) withTitleArray:self.titles];
    pop1.tag = 1314;
    __weak UIButton *weakBtn = self.button;
    pop1.clicked = ^(NSInteger row,NSString *title) {
        [weakBtn setTitle:self.titles[row] forState:UIControlStateNormal];
    };
    [pop1 showInView:btn];
}

#pragma mark - 懒加载
- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:@[@"哈哈哈",@"阿拉急哈哈哈哈啦",@"耳机耳机的",@"啦啦啦",@"卡卡卡看看",@"你嘎嘎嘎",@"哈哈哈哈"]];
    }
    return  _titles;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_scrollView];
    }
    return  _scrollView;
}

@end