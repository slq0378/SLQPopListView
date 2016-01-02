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
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
    for (UIView *subView in self.view.subviews) {
        if (subView.tag == 1314) {
            return;
        }
    }
    SLQPopListView *pop1 = [[SLQPopListView alloc] init];
    pop1.tag = 1314;
    __weak UIButton *weakBtn = self.button;
    pop1.clicked = ^(NSInteger row,NSString *title) {
        [weakBtn setTitle:self.titles[row] forState:UIControlStateNormal];
    };
    [pop1 showInView:btn withArray:self.titles];
}

#pragma mark - 懒加载
- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:@[@"哈哈哈",@"阿拉急哈哈哈哈啦",@"耳机耳机的",@"啦啦啦",@"卡卡卡看看",@"你嘎嘎嘎",@"哈哈哈哈"]];
    }
    return  _titles;
}

@end