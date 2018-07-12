//
//  CameraSessionView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraSessionManager.h"

@protocol JJCameraSessionDelegate <NSObject>

- (void)captureImage:(UIImage *)image;

- (void)captureImageWithData:(NSData *)imageData;

@end

@interface CameraSessionView : UIView<JJCameraSessionManagerDelegate>

@property (nonatomic, weak) id<JJCameraSessionDelegate> delegate;

@property (nonatomic, strong) CameraSessionManager *captureManager;
//快门
@property (nonatomic, weak) UIButton *shutterBtn;
//取消
@property (nonatomic, weak) UIButton *cancelBtn;

- (void)setTopBarColor:(UIColor *)topBarColor;
- (void)hideFlashButton;
- (void)hideCameraToggleButton;
- (void)hideDismissButton;

@end
