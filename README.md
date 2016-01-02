# SLQPopListView

## 弹出列表
- 在控件上添加一个UIView，点击弹出列表框，选择数据
- 通过自定义View来实现

## 效果图
![](SLQPopListViewDemo/PopListView.gif)

## 使用方式
- 包含头文件

```objc
    SLQPopListView *pop1 = [[SLQPopListView alloc] init];
    __weak UIButton *weakBtn = self.button;
    pop1.clicked = ^(NSInteger row,NSString *title) {
        [weakBtn setTitle:self.titles[row] forState:UIControlStateNormal];
    };
    [pop1 showInView:btn withArray:self.titles];
```
