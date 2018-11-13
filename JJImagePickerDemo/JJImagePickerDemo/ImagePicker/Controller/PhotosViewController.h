//
//  PhotosViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"

@protocol PhotosViewPublishDelegate <NSObject>
- (void)photoViewToPublishCallback:(NSMutableArray *)imagesAsset viewCtrl:(UIViewController *)viewControl;
@end

@interface PhotosViewController : CustomPhotoViewController

@property (nonatomic, weak) id<PhotosViewPublishDelegate> delegate;

//初始化网格图
- (void)setUpGridView:(int)maxNum min:(int)minNum;

- (void)setSelectedPhotos:(NSMutableArray *)selectedImages;

@end
