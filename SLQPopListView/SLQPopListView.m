//
//  SLQPopListView.m
//  SLQPopListView
//
//  Created by Christian on 15/12/28.
//  Copyright © 2015年 slq. All rights reserved.
//
#define ButtonTag 200
#define ButtonHeight 44
#define ButtonNumbersInOnePage 5
#define ButtonMargin 5
#define GetTheNumToShow(para) ((para) < (ButtonNumbersInOnePage)) ? (para) : (ButtonNumbersInOnePage)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "SLQPopListView.h"

@interface SLQPopListView ()
/**数据列表*/
@property (nonatomic, copy) NSArray *titles;
/** 滚动视图*/
@property (nonatomic, strong) UIScrollView *scrollView;
/** 背景*/
@property (nonatomic, strong) UIView *bgView;

@end

@implementation SLQPopListView

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (id)initWithArray:(NSArray *)arr
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.titles = arr;
        [self addChildViews];
    }
    return self;
}


- (void)showInView:(UIView *)targetView
{
    if (self.titles.count == 0) {
        NSLog(@"The array is empty!");
        return ;
    }
    self.hidden = NO;
    [targetView.superview addSubview:self];
    // 添加背景，点击后隐藏视图
    [targetView.superview insertSubview:self.bgView belowSubview:self];
    
    CGFloat height = 0;
    CGFloat anchorPointY = 0;
    // 如果目标控件位于屏幕中间线以下，就从控件顶部弹出，否则就从底部弹出
    if (targetView.center.y > (ScreenHeight / 2.0)) {
        height = CGRectGetMinY(targetView.frame);
        anchorPointY = 1;
    }
    else {
        height = CGRectGetMaxY(targetView.frame);
        anchorPointY = 0;
    }

    self.center = CGPointMake(targetView.frame.size.width/2 + targetView.frame.origin.x, height);
    CGRect rect = self.frame;
    // 如果没有超出最右边屏幕，就左对齐，否则右对齐
    if (CGRectGetMaxX(self.frame) < ScreenWidth) { // 左对齐
        rect.origin.x += fabs((targetView.frame.size.width - self.frame.size.width))/2;
    }
    else { // 右对齐
        rect.origin.x -= fabs((targetView.frame.size.width - self.frame.size.width))/2;
        for (NSInteger i = 0 ; i < self.scrollView.subviews.count ; i ++) {
            UIView *btn = self.scrollView.subviews[i];
            if ([btn isKindOfClass:[UIButton class]]) { // 文字右对齐
                ((UIButton *)btn).titleLabel.textAlignment = NSTextAlignmentRight;
                ((UIButton *)btn).contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            }
        }
    }
    self.frame = rect;
    
    // 创建动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    self.layer.anchorPoint = CGPointMake(0.5,anchorPointY);
    anim.keyPath = @"transform.scale.y";
    anim.fromValue = @(0);
    anim.toValue = @(1);
    anim.repeatCount = 1;
    [self.layer addAnimation:anim forKey:nil];
}

- (void)showInView:(UIView *)targetView withArray:(NSArray *)arr
{
    self.titles = arr;
    [self addChildViews];
    [self showInView:targetView];
}

/// 添加并布局子控件
- (void)addChildViews
{
    if (self.titles.count == 0) {
        NSLog(@"The array is empty!");
        return ;
    }
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    NSInteger count = self.titles.count;
    // 计算文本最大宽度，最大不超过屏幕宽度
    CGFloat maxWidth = 0;
    for (NSInteger i = 0 ; i < count ; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        btn.frame = CGRectMake(2, (ButtonHeight+ButtonMargin) * i, self.frame.size.width - 4, ButtonHeight - 1);
        [btn.titleLabel sizeToFit];
        [btn sizeToFit];
        if (maxWidth < btn.frame.size.width) {
            maxWidth = btn.frame.size.width;
        }
        
        // 找到最大宽度
        if (maxWidth > ScreenWidth) {
            maxWidth = ScreenWidth;
            break;
        }
    }
    
    // 添加子控件
    for (NSInteger i = 0 ; i < count ; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        btn.frame = CGRectMake(2, (ButtonHeight+ButtonMargin) * i, maxWidth + 4, ButtonHeight - 1);
        btn.tag = ButtonTag + i;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.size.height - 1 , maxWidth + 4, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [btn addSubview:line];
        
        [self.scrollView addSubview:btn];
    }
    
    NSInteger showCount = GetTheNumToShow(self.titles.count);
    self.frame = CGRectMake(0, 0, maxWidth + 4, showCount*(ButtonHeight + ButtonMargin));
    
    self.scrollView.frame = CGRectMake(0, 0, maxWidth + 4, showCount*(ButtonHeight + ButtonMargin));
    self.scrollView.contentSize = CGSizeMake(maxWidth + 4, self.titles.count*(ButtonHeight + ButtonMargin));
}

#pragma mark - 懒加载
- (NSArray *)titles
{
    if (!_titles) {
        _titles = [NSArray array];
    }
    return  _titles;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:_scrollView];
    }
    return  _scrollView;
}
#pragma mark - 懒加载
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *bg = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgButton:)];
        [bg addGestureRecognizer:tap];
        _bgView = bg;
    }
    return  _bgView;
}

#pragma mark - 按钮点击

/// 选中某一行
- (void)clickButton:(UIButton *)btn
{
    if (_clicked) {
        self.clicked(btn.tag - ButtonTag,btn.titleLabel.text);
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
    }
}

/// 隐藏视图
- (void)clickBgButton:(UITapGestureRecognizer *)btn
{
    [self removeFromSuperview];
    [self.bgView removeFromSuperview];
}
@end
