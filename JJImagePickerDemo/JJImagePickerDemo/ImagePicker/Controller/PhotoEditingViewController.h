//
//  PhotoEditingViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
#import "EditingToolView.h"
#import "JJCropViewController.h"
#import "FilterViewController.h"
#import "AdjustViewController.h"
#import "StickerViewController.h"
#import "JJTagCategoryView.h"
#import "ScrawlViewController.h"
#import "WordsBrushViewController.h"

typedef enum : NSUInteger {
    PAGE_GALLARY,
    PAGE_PUBLISH,
} PARENT_PAGE;

@class PhotoEditingViewController;
@protocol AdjustImageFinishedDelegate <NSObject>

- (void)AdjustImageFinished:(UIViewController *)viewController image:(UIImage *)image;

@end

//typedef void(^AdjustViewFinishCallBack)(UIImage *adjustImage, UIViewController *viewController);

@interface PhotoEditingViewController : CustomPhotoViewController<PhotoEditingDelegate,TOCropViewControllerDelegate,JJFilterDelegate,JJStickDelegate,JJTagCategoryDelegate,JJWordsDelegate,AdjustmentDelegate>

@property (nonatomic, weak) id<AdjustImageFinishedDelegate> delegate;

//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//预览image
@property (nonatomic, strong) UIImage *preImage;
//工具烂
@property (nonatomic, strong) EditingToolView *editToolView;
//编辑工具数据
@property (nonatomic, strong) NSDictionary *editData;
//调整数据
@property (nonatomic, strong) AdjustModel *pAdjustModel;

@property (nonatomic, assign) CGRect croppedFrame;

@property (nonatomic, assign) NSInteger angle;

@property (assign) PARENT_PAGE parentPage;

//@property (nonatomic, weak) AdjustViewFinishCallBack adjustViewBlock;

/*
 * @brief 设置要编辑的图
 * @param image 初始化图
 */
- (void)setEditImage:(UIImage *)image;

- (void)setPageJumpFrom:(PARENT_PAGE)page;

@end
