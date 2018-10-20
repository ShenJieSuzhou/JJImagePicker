//
//  BrushPaneView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrushPaneView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
//颜色选择容器
@property (strong, nonatomic) UICollectionView *colorCollectionView;
//颜色数组
@property (strong, nonatomic) NSMutableArray *colorArray;

@end


