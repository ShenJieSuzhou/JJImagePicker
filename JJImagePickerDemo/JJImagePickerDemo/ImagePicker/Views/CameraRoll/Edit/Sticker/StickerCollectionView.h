//
//  StickerCollectionView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//  创建视图用于显示贴纸图片集合

#import <UIKit/UIKit.h>

@interface StickerCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *stickerCollection;

@property (nonatomic, strong) NSMutableArray *stickerArray;

- (void)setStickers:(NSMutableArray *)array;

/*
 * @brief 刷新贴纸
 */
- (void)refreshTheSticker;


@end
