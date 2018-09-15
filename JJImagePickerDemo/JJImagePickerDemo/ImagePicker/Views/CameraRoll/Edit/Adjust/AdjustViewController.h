//
//  AdjustViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditingToolView.h"
#import <UIKit/UIKit.h>

@interface AdjustViewController : UIViewController<PhotoSubToolEditingDelegate>

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
@property (nonatomic, strong) UISlider *jjSlider;

- (void)setEditImage:(UIImage *)image;

- (void)setAdjustToolArrays:(NSArray *)tools;

@end
