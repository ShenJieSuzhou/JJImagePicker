//
//  GridView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJPhotoAlbum.h"

@protocol JJImagePickerViewControllerDelegate <NSObject>


@end


@interface GridView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//背景色
@property (strong, nonatomic) UIView *background;
//datasource
@property (strong, nonatomic) NSMutableArray<JJPhoto *>* imagesAssetArray;
@property (strong, nonatomic) JJPhotoAlbum *photoAlbum;
@property (strong, nonatomic) NSMutableArray<JJPhoto *> *selectedImageAssetArray;

//UICollectionView
@property (strong, nonatomic) UICollectionView *photoCollectionView;

/*
 * 刷新照片
 */
- (void)refreshPhotoAsset:(JJPhotoAlbum *)album;

@end
