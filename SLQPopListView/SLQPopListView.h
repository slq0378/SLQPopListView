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
 *  在目标视图中显示
 *
 *  @param targetView 目标视图
 *  @param arr        文本数组
 */
- (void)showInView:(UIView *)targetView withArray:(NSArray *)arr;
@end
