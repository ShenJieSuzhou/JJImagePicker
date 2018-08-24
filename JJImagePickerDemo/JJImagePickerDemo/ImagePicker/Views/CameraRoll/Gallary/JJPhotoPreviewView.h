//
//  JJPhotoPreviewView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJPhoto.h"
#import "JJPreviewViewCollectionLayout.h"
#import "JJPreviewViewCollectionCell.h"
#import "GlobalDefine.h"

@class JJPhotoPreviewView;
@protocol JJPhotoPreviewDelegate<NSObject>

- (NSUInteger)numberOfImagesInImagePreviewView:(JJPhotoPreviewView *)imagePreviewView;

- (JJAssetSubType)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView assetTypeAtIndex:(NSUInteger)index;

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView didScrollToIndex:(NSUInteger)index;

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView renderCell:(JJPreviewViewCollectionCell *)cell atIndex:(NSUInteger)index;

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView didHideNaviBarAndToolBar:(BOOL)didHide;

@end



@interface JJPhotoPreviewView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, videoPlayerButtonDelegate>

@property (strong, nonatomic) UICollectionView *photoPreviewImage;
@property (strong, nonatomic) JJPreviewViewCollectionLayout *layout;
@property (strong, nonatomic) id<JJPhotoPreviewDelegate> mDelegate;
@property (assign) NSInteger currentIndex;
@property (assign) NSInteger previousScrollIndex;

///*
// * 初始化 已选的预览图数据
// */
//- (void)initImagePickerPreviewWithSelectedImages:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
//                               currentImageIndex:(NSInteger)currentImageIndex;

@end
