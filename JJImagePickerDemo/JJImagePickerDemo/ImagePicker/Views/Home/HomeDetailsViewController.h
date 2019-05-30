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
#import "reportView.h"

@interface HomeDetailsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CustomNewsBannerDelegate, reportViewDelegate>

- (void)setWorksInfo:(HomeCubeModel *)detailInfo index:(NSIndexPath *)indexPath;

@end

