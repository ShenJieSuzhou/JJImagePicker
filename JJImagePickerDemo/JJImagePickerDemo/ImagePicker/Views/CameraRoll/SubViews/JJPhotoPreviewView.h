//
//  JJPhotoPreviewView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJPhoto.h"
//#import "TabBarView.h"

@interface JJPhotoPreviewView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

//dataSource
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* imagesAssetArray;
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* selectedImageAssetArray;
@property (strong, nonatomic) UICollectionView *photoPreviewImage;
@property (assign) NSInteger currentIndex;

/*
 * 初始化数据
 */
- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode;

@end
