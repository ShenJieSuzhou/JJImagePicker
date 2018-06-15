//
//  JJPhotoPreviewView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJPhoto.h"

@interface JJPhotoPreviewView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//dataSource
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* imagesAssetArray;
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* selectedImageAssetArray;


@property (strong, nonatomic) UICollectionView *photoPreviewView;

/*
 * 初始化数据
 */
- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode;

@end
