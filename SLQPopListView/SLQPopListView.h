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


- (instancetype)initWithFrame:(CGRect )frame withArray:(NSArray *)arr;

/**
 *  在目标视图中显示
 *
 *  @param targetView 目标视图
 *  @param offset     偏移量，如果是scrollView的话，一定要传入y方向的偏移量
 */
- (void)showInView:(UIView *)targetView offset:(CGPoint)offset;
@end
