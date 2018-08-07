//
//  PhotoEditingViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"

@protocol PhotoEditingDelegate <NSObject>

- (void)PhotoEditingFinished:(UIImage *)image;

@end

//编辑工具栏cell
@interface EditingToolCell : UICollectionViewCell

//icon asset
@property (strong, nonatomic) UIImage *editImage;

@property (strong, nonatomic) UIImage *editImageSel;
//title
@property (strong, nonatomic) NSString *editTitle;
//button
@property (strong, nonatomic) UIButton *editBtn;

@end

//编辑工具栏
@interface EditingToolView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//tool asset
@property (strong, nonatomic) NSMutableArray *toolArray;

//UICollectionView
@property (strong, nonatomic) UICollectionView *toolCollectionView;

@end

//编辑工具栏
@interface EditingSubToolView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *subToolArray;
@property (strong, nonatomic) UICollectionView *subToolCollectionView;
//UIButton
@property (strong, nonatomic) UIButton *cancel;
@property (strong, nonatomic) UIButton *confirm;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@interface PhotoEditingViewController : CustomPhotoViewController

@property (nonatomic, weak) id<PhotoEditingDelegate> delegate;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//预览image
@property (nonatomic, strong) UIImage *preImage;
//工具烂
@property (nonatomic, strong) EditingToolView *editToolView;
//编辑工具数据
@property (nonatomic, strong) NSDictionary *editData;

/*
 * @brief 设置要编辑的图
 * @param image 初始化图
 */
- (void)setEditImage:(UIImage *)image;


@end
