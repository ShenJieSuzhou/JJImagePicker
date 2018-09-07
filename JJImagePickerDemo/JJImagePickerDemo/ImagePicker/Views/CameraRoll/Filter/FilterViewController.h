//
//  FilterViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingToolView.h"

@class FilterViewController;
@protocol JJFilterDelegate <NSObject>

- (void)filterViewController:(nonnull FilterViewController *)filterViewController didAddFilterToImage:(nonnull UIImage *)image;

@end

@interface FilterViewController : UIViewController<PhotoSubToolEditingDelegate>

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;
//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//底部工具
@property (nonatomic, strong) EditingSubToolView *filterView;
//代理
@property (nonatomic, weak) id<JJFilterDelegate> delegate;

/*
 * 设置需要添加滤镜的图片
 */
- (void)setEditImage:(UIImage *)image;

@end
