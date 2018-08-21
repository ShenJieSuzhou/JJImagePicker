//
//  PhotoEditingViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
#import "EditingToolView.h"
#import "JJCropViewController.h"


@interface PhotoEditingViewController : CustomPhotoViewController<PhotoEditingDelegate,TOCropViewControllerDelegate>

@property (nonatomic, weak) id<PhotoEditingDelegate> delegate;

//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//预览image
@property (nonatomic, strong) UIImage *preImage;
//工具烂
@property (nonatomic, strong) EditingToolView *editToolView;

//编辑工具数据
@property (nonatomic, strong) NSDictionary *editData;

@property (nonatomic, assign) CGRect croppedFrame;

@property (nonatomic, assign) NSInteger angle;

/*
 * @brief 设置要编辑的图
 * @param image 初始化图
 */
- (void)setEditImage:(UIImage *)image;


@end
