//
//  StickerViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingToolView.h"
#import "StickerCollectionView.h"

@class StickerViewController;
@protocol JJStickDelegate <NSObject>
- (void)stickerViewController:(nonnull StickerViewController *)viewController didAddStickerToImage:(nonnull UIImage *)image;
@end

@interface StickerViewController : UIViewController<PhotoSubToolEditingDelegate,JJStickSelectedDelegate>

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;
//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//底部工具
@property (nonatomic, strong) EditingSubToolView *stickerListView;
//sticker 数组
@property (nonatomic, strong) NSMutableArray *stickerArrays;
//代理
@property (nonatomic, weak) id<JJStickDelegate> delegate;


- (void)setEditImage:(UIImage *)image;

- (void)setAdjustToolArrays:(NSMutableArray *)arrays;

@end
