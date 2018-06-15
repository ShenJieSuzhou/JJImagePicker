//
//  GridView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJPhotoAlbum.h"
@class GridView;
@protocol JJImagePickerViewControllerDelegate <NSObject>
- (void)JJImagePickerViewController:(GridView *)gridView selectAtIndex:(NSIndexPath *)indexath;

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

//是否允许选择多张
@property (assign) BOOL isAllowedMutipleSelect;

//允许选择的最大张数
@property (assign) NSUInteger maxSeledtedNum;

//预览图回调
@property (strong, nonatomic) id<JJImagePickerViewControllerDelegate> mDelegate;

/*
 * 刷新照片
 * @param album 相簿
 */
- (void)refreshPhotoAsset:(JJPhotoAlbum *)album;

@end
