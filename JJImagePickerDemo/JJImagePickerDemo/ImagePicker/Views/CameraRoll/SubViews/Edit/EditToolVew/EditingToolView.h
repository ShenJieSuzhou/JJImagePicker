//
//  EditingToolView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOCropViewConstants.h"

typedef enum : NSUInteger {
    JJAspectRatioPresetSquare,
    JJAspectRatioPreset3x2,
    JJAspectRatioPreset5x3,
    JJAspectRatioPreset4x3,
    JJAspectRatioPreset5x4,
    JJAspectRatioPreset7x5,
    JJAspectRatioPreset16x9,
    JJRotateViewClockwise
} PhotoEditSubTools;

@protocol PhotoEditingDelegate <NSObject>

- (void)PhotoEditingFinished:(UIImage *)image;

- (void)PhotoEditShowSubEditTool:(UICollectionView *)collectionV Index:(NSInteger)index array:(NSArray *)array;

- (void)PhotoEditSubEditToolDismiss;

- (void)PhotoEditSubEditToolConfirm;

@end

@protocol PhotoSubToolEditingDelegate <NSObject>

- (void)PhotoEditSubEditToolDismiss;

- (void)PhotoEditSubEditToolConfirm;

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV Tools:(PhotoEditSubTools)tool;

@end


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






