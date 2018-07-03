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
#import "InterestingViewController.h"

@class PhotoPreviewViewController;
@protocol PhotoPreviewViewControllerDelegate<NSObject>

/// 已经选中图片
- (void)imagePickerPreviewViewController:(PhotoPreviewViewController *)previewViewController didCheckImageAtIndex:(NSInteger)index;

/// 已经取消选中图片
- (void)imagePickerPreviewViewController:(PhotoPreviewViewController *)previewViewController didUncheckImageAtIndex:(NSInteger)index;

@end

@interface PhotoPreviewViewController : CustomPhotoViewController<JJPhotoPreviewDelegate>
//预览图展示view
@property (strong, nonatomic) JJPhotoPreviewView *photoPreviewView;

//dataSource
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* imagesAssetArray;
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* selectedImageAssetArray;

@property (strong, nonatomic) id<PhotoPreviewViewControllerDelegate> mDelegate;
@property (assign) NSInteger currentIndex;
@property (assign) BOOL singleCheckMode;
@property (assign) BOOL previewSelectedMode;
//允许选择的最大张数
@property (assign) NSUInteger maxSelectedNum;
// 最少需要选择的图片数
@property (assign) NSUInteger minSelectedNum;
// 选择图片超出最大图片限制数提示
@property (nonatomic, copy) NSString *alertTitleWhenPhotoExceedMaxCount;

@property (strong, nonatomic) UIButton *checkBox;

@property (nonatomic, strong) InterestingViewController *interestingViewController;


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
//- (void)initImagePickerPreviewWithSelectedImages:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
//                               currentImageIndex:(NSInteger)currentImageIndex;

- (void)refreshImagePreview;

@end
