//
//  PhotosViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"


@interface PhotosViewController : CustomPhotoViewController

- (void)setSelectedPhotos:(NSMutableArray *)selectedImages;

@end
