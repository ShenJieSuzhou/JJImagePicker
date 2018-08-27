//
//  FilterViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingToolView.h"


@interface FilterViewController : UIViewController<PhotoSubToolEditingDelegate>

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;

//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;

//底部工具
@property (nonatomic, strong) EditingSubToolView *filterView;

/*
 * 设置需要添加滤镜的图片
 */
- (void)setEditImage:(UIImage *)image;

@end
