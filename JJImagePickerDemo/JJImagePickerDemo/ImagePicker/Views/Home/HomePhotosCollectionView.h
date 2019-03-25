//
//  HomePhotosCollectionView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePhotosCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *sepearateL;

@end


@interface HomePhotosCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *photosCollection;

@property (strong, nonatomic) NSMutableArray *photosArray;

@end


