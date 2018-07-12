//
//  CameraSessionView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJCameraSessionDelegate <NSObject>

- (void)captureImage:(UIImage *)image;

- (void)captureImageWithData:(NSData *)imageData;

@end

@interface CameraSessionView : UIView

@property (nonatomic, weak) id<JJCameraSessionDelegate> delegate;

- (void)setTopBarColor:(UIColor *)topBarColor;
- (void)hideFlashButton;
- (void)hideCameraToggleButton;
- (void)hideDismissButton;

@end
