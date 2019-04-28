//
//  CropAvaterViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/28.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOCropViewControllerTransitioning.h"
#import "TOActivityCroppedImageProvider.h"
#import "UIImage+CropRotate.h"
#import "TOCroppedImageAttributes.h"
#import "TOCropViewConstants.h"
#import "TOCropView.h"


@class CropAvaterViewController;

@protocol CropAvaterDelegate <NSObject>
- (void)cropAvater:(nonnull CropAvaterViewController *)cropViewController didCropToImage:(nonnull UIImage *)image;
@end


@interface CropAvaterViewController : UIViewController<UIViewControllerTransitioningDelegate>

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;

//裁剪结果代理
@property (nullable, nonatomic, weak) id<CropAvaterDelegate> delegate;

//裁剪比例枚举
@property (nonatomic, assign) TOCropViewControllerAspectRatioPreset aspectRatioPreset;

//工具栏位置
@property (nonatomic, assign) TOCropViewControllerToolbarPosition toolbarPosition;

//自定义裁剪比例
@property (nonatomic, assign) CGSize customAspectRatio;

//裁剪样式
@property (nonatomic, readonly) TOCropViewCroppingStyle croppingStyle;

//动画
@property (nonatomic, strong) TOCropViewControllerTransitioning *transitionController;
@property (nonatomic, assign) BOOL inTransition;

//底部完成取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *finishBtn;

//初始化
- (instancetype)initWithCroppingStyle:(TOCropViewCroppingStyle)style image:(UIImage *)image;

//设置裁剪比例
- (void)setAspectRatioPreset:(TOCropViewControllerAspectRatioPreset)aspectRatioPreset animated:(BOOL)animated;

@end


