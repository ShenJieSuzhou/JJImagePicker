//
//  CameraSessionManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraSessionManager.h"


@implementation CameraSessionManager
@synthesize delegate = _delegate;
@synthesize captureDevice = _captureDevice;
@synthesize previewLayer = _previewLayer;
@synthesize session = _session;
@synthesize stillImageOutput = _stillImageOutput;

static CameraSessionManager *m_instance = nil;

+ (CameraSessionManager *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[CameraSessionManager alloc] init];
    });
    
    return m_instance;
}

- (void)addVideoPreviewLayer{
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

- (void)initiateCaptureSessionForCamera:(CameraType)cameraType{
    //初始化摄像头
    for (AVCaptureDevice *device in AVCaptureDevice.devices) {
        if([device hasMediaType:AVMediaTypeVideo]){
            switch (cameraType) {
                case FrontFacingCamera:
                    if([device position] == AVCaptureDevicePositionFront){
                        _captureDevice = device;
                    }
                    break;
                case RearFacingCamera:
                    if([device position] == AVCaptureDevicePositionBack){
                        _captureDevice = device;
                    }
                    break;
            }
        }
    }
    
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    NSError *error = nil;
    BOOL deviceAvailability = YES;
    
    AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    
    if(!error && [_session canAddInput:cameraDeviceInput]){
        [_session addInput:cameraDeviceInput];
    }else{
        deviceAvailability = NO;
    }
    
    //回调
}


- (void)addStillImageOutput{
    self.stillImageOutput = [AVCapturePhotoOutput new];
    
    if(![self.session canAddOutput:self.stillImageOutput]){
        return;
    }
    
    [self.session addOutput:self.stillImageOutput];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
        [device lockForConfiguration:nil];
        [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [device unlockForConfiguration];
    }
}

- (void)captureStillImage{
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}


- (void)stop{
    [self.session stopRunning];

    if(self.session.inputs.count > 0){
        AVCaptureInput *input = [self.session.inputs objectAtIndex:0];
        [self.session removeInput:input];
    }

    if(self.session.outputs.count > 0){
        AVCaptureVideoDataOutput *output = [self.session.outputs objectAtIndex:0];
        [self.session removeOutput:output];
    }
}

- (void)dealloc{
    [self stop];
}

#pragma mark -AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error{
    
    NSData *imageData = photo.fileDataRepresentation;
    UIImage *image = [UIImage imageWithData:imageData];
    
    if(error){
        [_delegate captureOutputWithError:error];
        return;
    }
    
    [_delegate captureOutputDidFinish:image];
}

@end
