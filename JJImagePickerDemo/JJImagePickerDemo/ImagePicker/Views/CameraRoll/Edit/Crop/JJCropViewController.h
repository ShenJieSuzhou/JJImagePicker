//
//  JJCropViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingToolView.h"

#import "TOCropViewControllerTransitioning.h"
#import "TOActivityCroppedImageProvider.h"
#import "UIImage+CropRotate.h"
#import "TOCroppedImageAttributes.h"
#import "TOCropViewConstants.h"
#import "TOCropView.h"

@class JJCropViewController;

@protocol TOCropViewControllerDelegate <NSObject>

- (void)cropViewController:(nonnull JJCropViewController *)cropViewController didCropToImage:(nonnull UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle;

@end


@interface JJCropViewController : UIViewController<PhotoSubToolEditingDelegate, UIViewControllerTransitioningDelegate>
//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;

//裁剪结果代理
@property (nullable, nonatomic, weak) id<TOCropViewControllerDelegate> delegate;

//自定义裁剪比例
@property (nonatomic, assign) CGSize customAspectRatio;

//裁剪比例枚举
@property (nonatomic, assign) TOCropViewControllerAspectRatioPreset aspectRatioPreset;

//工具栏位置
@property (nonatomic, assign) TOCropViewControllerToolbarPosition toolbarPosition;

//工具对象数组
@property (nonatomic, strong) NSMutableArray *optionsAray;

//底部工具
@property (nonatomic, strong) EditingSubToolView *editSubToolView;

//裁剪样式
@property (nonatomic, readonly) TOCropViewCroppingStyle croppingStyle;

//动画
@property (nonatomic, strong) TOCropViewControllerTransitioning *transitionController;
@property (nonatomic, assign) BOOL inTransition;

//初始化
- (instancetype)initWithCroppingStyle:(TOCropViewCroppingStyle)style image:(UIImage *)image;

//设置裁剪比例
- (void)setAspectRatioPreset:(TOCropViewControllerAspectRatioPreset)aspectRatioPreset animated:(BOOL)animated;

@end
