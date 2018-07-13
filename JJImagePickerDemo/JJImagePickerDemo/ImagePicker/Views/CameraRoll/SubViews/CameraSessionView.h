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

//-------------------------- topBar ------------------------------------
@interface CameraTopBar : UIView

@property (nonatomic, strong) UIImage *background;

@property (nonatomic, weak) UIButton *backBtn;

@property (nonatomic, weak) UIButton *flashBtn;

@property (nonatomic, weak) UIButton *switchBtn;

@end

//-------------------------- buttomBar ---------------------------------
@interface CameraButtomBar : UIView

//快门
@property (nonatomic, weak) UIButton *shutterBtn;

@end



@interface CameraSessionView : UIView<JJCameraSessionManagerDelegate>

@property (nonatomic, weak) id<JJCameraSessionDelegate> delegate;

@property (nonatomic, strong) CameraSessionManager *captureManager;

@property (nonatomic, strong) CameraButtomBar *buttomBar;

- (void)setTopBarColor:(UIColor *)topBarColor;
- (void)hideFlashButton;
- (void)hideCameraToggleButton;
- (void)hideDismissButton;

@end
