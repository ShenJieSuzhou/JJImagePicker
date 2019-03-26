//
//  HomeDetailsViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomPhotoViewController.h"
#import "CustomNewsBanner.h"
#import "HomeCubeModel.h"

@interface HomeDetailsViewController : CustomPhotoViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CustomNewsBannerDelegate>

- (void)setWorksInfo:(HomeCubeModel *)detailInfo;

@end

