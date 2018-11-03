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
//UISlide
@property (nonatomic, strong) CustomSlider *jjSlider;
//hash 存放保存的参数值
@property (nonatomic, strong) NSMutableDictionary *adjustHashMap;
//调整的类型
@property (assign) PhotoEditAdjustTYPE jjAdjustType;
//图片调整数值
@property (strong, nonatomic) AdjustModel *adjustModel;

- (void)setEditImage:(UIImage *)image;

- (void)setSlideValue:(AdjustModel *)model;

- (void)setAdjustToolArrays:(NSArray *)tools;

@end
