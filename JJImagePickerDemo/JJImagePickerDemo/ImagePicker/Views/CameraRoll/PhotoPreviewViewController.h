//
//  PhotoPreviewViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
#import "JJPhotoPreviewView.h"
#import "JJPhoto.h"

@interface PhotoPreviewViewController : CustomPhotoViewController
//预览图展示view
@property (strong, nonatomic) JJPhotoPreviewView *photoPreviewView;
//dataSource
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* imagesAssetArray;
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* selectedImageAssetArray;

@property (assign) NSInteger currentIndex;
@property (assign) BOOL singleCheckMode;
@property (assign) BOOL previewSelectedMode;

//底部tabbarView


/**
 *  初始化展示数据并刷新 UI
 *
 *  @param imageAssetArray         包含所有需要展示的图片的数组
 *  @param selectedImageAssetArray 包含所有需要展示的图片中已经被选中的图片的数组
 *  @param currentImageIndex       当前展示的图片在 imageAssetArray 的索引
 *  @param singleCheckMode         是否为单选模式，如果是单选模式，则不显示 checkbox
 */
- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                                 selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                       currentImageIndex:(NSInteger)currentImageIndex
                                         singleCheckMode:(BOOL)singleCheckMode;

/*
 * 初始化已选图片预览 UI
 * @param selectedImageAssetArray 包含所有需要展示的图片中已经被选中的图片的数组
 * @param currentImageIndex       当前展示的图片在 imageAssetArray 的索引
 */
- (void)initImagePickerPreviewWithSelectedImages:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                               currentImageIndex:(NSInteger)currentImageIndex;

- (void)refreshImagePreview;

@end
