//
//  TabBarView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJTabBarViewDelegate<NSObject>


@end


@interface TabBarView : UIView
//编辑按钮
@property (strong, nonatomic) UIButton *editBtn;
//预览按钮
@property (strong, nonatomic) UIButton *previewBtn;
//完成按钮
@property (strong, nonatomic) UIButton *finishBtn;
//选择图片的数量
@property (strong, nonatomic) UILabel *selectedNum;
//画廊view
@property (strong, nonatomic) UIView *gallaryView;

- (void)setEditBtnHidden:(BOOL) hidden;

- (void)setPreViewBtnHidden:(BOOL) hidden;

- (void)setSelectedLabelHidden:(BOOL) hidden;

@end
