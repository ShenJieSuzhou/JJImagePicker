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

@class JJPhotoPreviewView;
@protocol JJPhotoPreviewDelegate<NSObject>

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView didScrollToIndex:(NSUInteger)index;

@end



@interface JJPhotoPreviewView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//dataSource
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* imagesAssetArray;
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* selectedImageAssetArray;
@property (strong, nonatomic) UICollectionView *photoPreviewImage;
@property (strong, nonatomic) JJPreviewViewCollectionLayout *layout;
@property (strong, nonatomic) id<JJPhotoPreviewDelegate> mDelegate;
@property (assign) NSInteger currentIndex;
@property (assign) NSInteger previousScrollIndex;

/*
 * 初始化数据
 */
- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode;
///*
// * 初始化 已选的预览图数据
// */
//- (void)initImagePickerPreviewWithSelectedImages:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
//                               currentImageIndex:(NSInteger)currentImageIndex;

@end
