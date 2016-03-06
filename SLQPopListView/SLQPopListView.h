//
//  SLQPopListView.h
//  SLQPopListView
//
//  Created by Christian on 15/12/28.
//  Copyright © 2015年 slq. All rights reserved.
//

#import <UIKit/UIKit.h>
/// 按钮点击block定义
typedef void (^PopListViewDidClickButton)(NSInteger row,NSString *title);

@interface SLQPopListView : UIView
@property (nonatomic, copy) PopListViewDidClickButton clicked;

/**
 *  初始化视图，带有图片
 *
 *  @param frame  指定位置，要弹出的控件
 *  @param titles 标题数组
 *  @param images 配图数组，这个两个数组要保持一致
 *
 *  @return 对象
 */
- (instancetype)initWithFrame:(CGRect )frame withTitleArray:(NSArray *)titles imageArray:(NSArray *)images;
/**
 *  初始化视图，只有标题
 *
 *  @param frame 弹出控件的frame
 *  @param arr   标题数组
 *
 *  @return 对象
 */
- (instancetype)initWithFrame:(CGRect )frame withTitleArray:(NSArray *)arr;
/**
 *  在目标视图中显示
 *
 *  @param targetView 目标视图
 */
- (void)showInView:(UIView *)targetView;
- (void)setTitleColor:(UIColor *)color;

@end
