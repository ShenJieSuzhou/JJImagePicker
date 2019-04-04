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

//@protocol HomeDetailsChangeDelegate <NSObject>
//
//- (void)likeChangeCallback:(BOOL)like index:(NSIndexPath *)indexPath;
//
//- (void)focusChangeCallback:(BOOL)focus index:(NSIndexPath *)indexPath;
//
//@end

@interface HomeDetailsViewController : CustomPhotoViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CustomNewsBannerDelegate>

//@property (weak, nonatomic) id<HomeDetailsChangeDelegate> delegate;

- (void)setWorksInfo:(HomeCubeModel *)detailInfo index:(NSIndexPath *)indexPath;

@end

