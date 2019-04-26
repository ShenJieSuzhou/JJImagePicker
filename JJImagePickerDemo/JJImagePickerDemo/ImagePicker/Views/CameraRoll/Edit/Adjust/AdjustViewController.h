//
//  AdjustViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EditingToolView.h"
#import "CustomSlider.h"
#import "AdjustModel.h"
#import <GPUImage/GPUImage.h>

@class AdjustViewController;
@protocol AdjustmentDelegate <NSObject>
- (void)AdjustView:(AdjustViewController *)view didFinished:(UIImage *)result model:(AdjustModel *)model;
- (void)AdjustView:(AdjustViewController *)view didCancel:(BOOL) isCancel;
@end

@interface AdjustViewController : UIViewController<PhotoSubToolEditingDelegate,CustomSliderDelegate>

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;
//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//底部工具
@property (nonatomic, strong) EditingSubToolView *adjustView;
//工具
@property (nonatomic, copy) NSArray *adToolArrays;
//UISlide 通用
@property (nonatomic, strong) CustomSlider *jjSlider;

//美白效果 磨皮与提亮
@property (nonatomic, strong) CustomSlider *smoothSlider;
@property (nonatomic, strong) CustomSlider *brightSlider;
@property (strong, nonatomic) GPUImageFilterGroup *groupFilter;
@property (strong, nonatomic) GPUImageBilateralFilter *bilateralFilter;
@property (strong, nonatomic) GPUImageBrightnessFilter *brightnessFilter;
@property (strong, nonatomic) GPUImagePicture *staticPicture;

//调整的类型
@property (assign) PhotoEditAdjustTYPE jjAdjustType;
//图片调整数值
@property (strong, nonatomic) AdjustModel *adjustModel;

@property (weak, nonatomic) id<AdjustmentDelegate> mDelegate;

- (void)setEditImage:(UIImage *)image;

- (void)setSlideValue:(AdjustModel *)model;

- (void)setAdjustToolArrays:(NSArray *)tools;

@end
