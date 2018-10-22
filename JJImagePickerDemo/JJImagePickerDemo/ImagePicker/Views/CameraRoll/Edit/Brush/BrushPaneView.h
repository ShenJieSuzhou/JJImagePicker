//
//  BrushPaneView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrushPaneView : UIView

//颜色数组
@property (strong, nonatomic) NSArray *colorArray;
//左右滚动
@property (strong, nonatomic) UIScrollView *colorScrollView;
//当前选中的按钮
@property (strong, nonatomic) UIButton *currentButton;
@end


