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

- (void)PhotoEditShowSubEditTool:(UICollectionView *)collectionV Index:(NSInteger)index array:(NSArray *)array;

- (void)PhotoEditSubEditToolDismiss;

- (void)PhotoEditSubEditToolConfirm;

@end

@protocol PhotoSubToolEditingDelegate <NSObject>

- (void)PhotoEditSubEditToolDismiss;

- (void)PhotoEditSubEditToolConfirm;

@end

//编辑工具栏cell
@interface EditingToolCell : UICollectionViewCell

//icon asset
@property (strong, nonatomic) UIImage *editImage;

@property (strong, nonatomic) UIImage *editImageSel;
//title
@property (strong, nonatomic) NSString *editTitle;
//button
//@property (strong, nonatomic) UIButton *editBtn;
@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UIImageView *iconV;

@end

//编辑工具栏
@interface EditingToolView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//tool asset
@property (strong, nonatomic) NSMutableArray *toolArray;

//UICollectionView
@property (strong, nonatomic) UICollectionView *toolCollectionView;

//delegate
@property (weak, nonatomic) id<PhotoEditingDelegate> delegate;

@end

//编辑工具栏
@interface EditingSubToolView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *subToolArray;
@property (strong, nonatomic) UICollectionView *subToolCollectionView;

//UIButton
@property (strong, nonatomic) UIButton *cancel;
@property (strong, nonatomic) UIButton *confirm;
@property (strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) id<PhotoSubToolEditingDelegate> delegate;

@end

@interface PhotoEditingViewController : CustomPhotoViewController<PhotoEditingDelegate,PhotoSubToolEditingDelegate>

@property (nonatomic, weak) id<PhotoEditingDelegate> delegate;

//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//预览image
@property (nonatomic, strong) UIImage *preImage;
//工具烂
@property (nonatomic, strong) EditingToolView *editToolView;

@property (nonatomic, strong) EditingSubToolView *editSubToolView;

//编辑工具数据
@property (nonatomic, strong) NSDictionary *editData;

/*
 * @brief 设置要编辑的图
 * @param image 初始化图
 */
- (void)setEditImage:(UIImage *)image;


@end
