//
//  GridView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//背景色
@property (strong, nonatomic) UIView *background;
//datasource
@property (strong,nonatomic) NSMutableArray *photoItemsArray;
//UICollectionView
@property (strong, nonatomic) UICollectionView *photoCollectionView;

@end
