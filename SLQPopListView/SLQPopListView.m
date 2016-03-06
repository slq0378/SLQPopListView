//
//  SLQPopListView.m
//  SLQPopListView
//
//  Created by Christian on 15/12/28.
//  Copyright © 2015年 slq. All rights reserved.
//
#define ButtonTag 200
#define ButtonHeight 44
#define PopViewLeastWidth 80
#define ButtonNumbersInOnePage 5
#define ButtonMargin 5
#define GetTheNumToShow(para) ((para) < (ButtonNumbersInOnePage)) ? (para) : (ButtonNumbersInOnePage)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "SLQPopListView.h"

@interface SLQPopListView ()
/**数据列表*/
@property (nonatomic, copy) NSArray *titles;
/**图片数据列表*/
@property (nonatomic, copy) NSArray *images;
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

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titles imageArray:(NSArray *)images
{
    if (self = [super initWithFrame:frame] ) {
        if (titles.count == 0 || images.count == 0 || titles.count != images.count) {
            NSLog(@"The array is empty or not equal!");
            return self;
        }
        self.hidden = YES;
        self.titles = titles;
        self.images = images;
        [self addChildViews];
        // 将self 添加到window
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [[UIApplication sharedApplication].keyWindow insertSubview:self.bgView belowSubview:self];
        
        CGFloat anchorPointY = 0;
        CGRect rect = self.frame;
        // 如果目标控件位于屏幕中间线以下，就从控件顶部弹出，否则就从底部弹出
        if (frame.origin.y > (ScreenHeight / 2.0)) {
            rect.origin.y -= self.frame.size.height;
            anchorPointY = 0;
        }
        else {
            rect.origin.y += frame.size.height;
            anchorPointY = 1;
        }
        
        // 如果没有超出最右边屏幕，就左对齐，否则右对齐
        if (self.center.x < ScreenWidth) { // 左对齐
            rect.origin.x = self.frame.origin.x;
        }
        else { // 右对齐
            rect.origin.x -= fabs((frame.size.width - self.frame.size.width))/2;
            for (NSInteger i = 0 ; i < self.scrollView.subviews.count ; i ++) {
                UIView *btn = self.scrollView.subviews[i];
                if ([btn isKindOfClass:[UIButton class]]) { // 文字右对齐
                    ((UIButton *)btn).titleLabel.textAlignment = NSTextAlignmentRight;
                    ((UIButton *)btn).contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                }
            }
        }
        self.frame = rect;
        
//        // 创建动画
//        CABasicAnimation *anim = [CABasicAnimation animation];
//        self.layer.anchorPoint = CGPointMake(0.5,anchorPointY);
//        anim.keyPath = @"transform.scale.y";
//        anim.fromValue = @(0);
//        anim.toValue = @(1);
//        anim.repeatCount = 1;
//        [self.layer addAnimation:anim forKey:nil];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect )frame withTitleArray:(NSArray *)arr
{
    if (self = [super initWithFrame:frame] ) {
        if (arr.count == 0) {
            NSLog(@"The array is empty!");
            return self;
        }
        self.hidden = YES;
        self.titles = arr;
        [self addChildViews];
        // 将self 添加到window
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [[UIApplication sharedApplication].keyWindow insertSubview:self.bgView belowSubview:self];
     
        CGFloat anchorPointY = 0;
        CGRect rect = self.frame;
        // 如果目标控件位于屏幕中间线以下，就从控件顶部弹出，否则就从底部弹出
        if (frame.origin.y > (ScreenHeight / 2.0)) {
            rect.origin.y -= self.frame.size.height;
            anchorPointY = 0;
        }
        else {
            rect.origin.y += frame.size.height;
            anchorPointY = 1;
        }
        
        // 如果没有超出最右边屏幕，就左对齐，否则右对齐
        if (self.center.x < ScreenWidth) { // 左对齐
            rect.origin.x = self.frame.origin.x;
        }
        else { // 右对齐
            rect.origin.x -= fabs((frame.size.width - self.frame.size.width))/2;
//            for (NSInteger i = 0 ; i < self.scrollView.subviews.count ; i ++) {
//                UIView *btn = self.scrollView.subviews[i];
//                if ([btn isKindOfClass:[UIButton class]]) { // 文字右对齐
//                    ((UIButton *)btn).titleLabel.textAlignment = NSTextAlignmentRight;
//                    ((UIButton *)btn).contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//                }
//            }
        }
        self.frame = rect;

//        // 创建动画
//        CABasicAnimation *anim = [CABasicAnimation animation];
//        self.layer.anchorPoint = CGPointMake(0.5,anchorPointY);
//        anim.keyPath = @"transform.scale.y";
//        anim.fromValue = @(0);
//        anim.toValue = @(1);
//        anim.repeatCount = 1;
//        [self.layer addAnimation:anim forKey:nil];
        


    }
    return self;
}

- (void)showInView:(UIView *)targetView
{
    self.hidden = NO;
    CGRect rect =  [targetView convertRect:targetView.bounds toView:[UIApplication sharedApplication].keyWindow];
    rect.size.height = self.frame.size.height;
    rect.size.width = self.frame.size.width;
    
    CGFloat anchorPointY = 0;
    // 如果目标控件位于屏幕中间线以下，就从控件顶部弹出，否则就从底部弹出
    if (rect.origin.y > (ScreenHeight / 2.0)) {
        rect.origin.y -= self.frame.size.height;
        anchorPointY = 0.3;
    }
    else {
        rect.origin.y += targetView.frame.size.height;
        anchorPointY = 0;
    }
    
    // 如果没有超出最右边屏幕，就左对齐，否则右对齐
    if (CGRectGetMaxX(self.frame) < ScreenWidth) { // 左对齐
        rect.origin.x = self.frame.origin.x;
    }
    else { // 右对齐
        rect.origin.x = ScreenWidth - self.frame.size.width;
//        for (NSInteger i = 0 ; i < self.scrollView.subviews.count ; i ++) {
//            UIView *btn = self.scrollView.subviews[i];
//            if ([btn isKindOfClass:[UIButton class]]) { // 文字右对齐
//                ((UIButton *)btn).titleLabel.textAlignment = NSTextAlignmentRight;
//                ((UIButton *)btn).contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            }
//        }
    }
    self.frame = rect;

    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];

}


/// 添加并布局子控件
- (void)addChildViews
{
    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
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
        if (self.images.count > 0) {
            
            [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        }
        
        [btn.titleLabel sizeToFit];
        [btn sizeToFit];
        if (maxWidth < btn.frame.size.width) {
            maxWidth = btn.frame.size.width;
        }
    }
    if (maxWidth < PopViewLeastWidth)
    {
        maxWidth = PopViewLeastWidth;
    }else if(maxWidth > ScreenWidth)
    {
        maxWidth = ScreenWidth;
    }
    
//    maxWidth = self.frame.size.width;
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
        if (self.images.count > 0 ) {
            [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(2, btn.frame.size.height - 1 , maxWidth - 4, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [btn addSubview:line];
        
        [self.scrollView addSubview:btn];

        if (self.images.count > 0) {
            [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        }
   
    }
    
    NSInteger showCount = GetTheNumToShow(self.titles.count);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, maxWidth + 4, showCount*(ButtonHeight + ButtonMargin));
    
    self.scrollView.frame = CGRectMake(0, 0, maxWidth + 4, showCount*(ButtonHeight + ButtonMargin));
    self.scrollView.contentSize = CGSizeMake(maxWidth + 4, self.titles.count*(ButtonHeight + ButtonMargin));
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [((UIButton *)subView) setBackgroundColor:backgroundColor];
        }
    }
}

- (void)setTitleColor:(UIColor *)color
{
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [((UIButton *)subView) setTitleColor:color forState:UIControlStateNormal];
        }
    }
}



#pragma mark - 懒加载
- (NSArray *)titles
{
    if (!_titles) {
        _titles = [NSArray array];
    }
    return  _titles;
}
- (NSArray *)images
{
    if (!_images) {
        _images = [NSArray array];
    }
    return  _images;
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
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgButton:)];
        [bg addGestureRecognizer:pan];
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
