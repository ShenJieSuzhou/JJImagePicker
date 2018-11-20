//
//  WorksView.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WorksView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UIButton *publishBtn;

@property (strong, nonatomic) UILabel *tips;

@property (strong, nonatomic) UICollectionView *worksCollection;

@property (strong, nonatomic) NSMutableArray *worksArray;

@end
