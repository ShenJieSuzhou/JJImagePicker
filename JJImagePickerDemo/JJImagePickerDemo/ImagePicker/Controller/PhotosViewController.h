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

//是否是从publishview加载的
- (void)setJumpViewFlag:(BOOL)isPublish;

- (void)setSelectedPhotos:(NSMutableArray *)selectedImages;

@end
