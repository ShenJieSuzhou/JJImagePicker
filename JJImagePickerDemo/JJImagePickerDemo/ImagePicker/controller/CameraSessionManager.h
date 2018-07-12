//
//  CameraSessionManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(BOOL, CameraType){
    FrontFacingCamera,
    RearFacingCamera
};


@protocol JJCameraSessionManagerDelegate <NSObject>


@end

@interface CameraSessionManager : NSObject

@property (nonatomic, weak) id<JJCameraSessionManagerDelegate> delegate;
//相机设备
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
//预览图层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//用于捕捉视频和音频,协调视频和音频的输入和输出流
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;

@property (nonatomic, strong) UIImage *stillImage;

@property (nonatomic, strong) NSData *stillImageData;

@property (nonatomic, assign) BOOL enableTorch;

+ (CameraSessionManager *)getInstance;

- (void)addStillImageOutput;

- (void)captureStillImage;

- (void)addVideoPreviewLayer;

- (void)initiateCaptureSessionForCamera:(CameraType)cameraType;

- (void)stop;

@end
