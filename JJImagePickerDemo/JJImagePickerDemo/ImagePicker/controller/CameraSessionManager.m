//
//  CameraSessionManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraSessionManager.h"


@implementation CameraSessionManager

+ (CameraSessionManager *)getInstance{
    static CameraSessionManager *m_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[CameraSessionManager alloc] init];
        m_instance.session = [[AVCaptureSession alloc] init];
        m_instance.session.sessionPreset = AVCaptureSessionPresetHigh;
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
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    [self getOrientationAdaptedCaptureConnection];
    
    [self.session addOutput:self.stillImageOutput];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
        [device lockForConfiguration:nil];
        [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [device unlockForConfiguration];
    }
}

- (void)captureStillImage{
    AVCaptureConnection *videoConnection = [self getOrientationAdaptedCaptureConnection];
    if(videoConnection){
        [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
           
            CFDictionaryRef exifAttachments = CMGetAttachment(imageDataSampleBuffer, kCGImagePropertyExifDictionary, NULL);
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            
            [self setStillImage:image];
            [self setStillImageData:imageData];
            
            //回调
            
        }];
    }
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device hasTorch]){
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}


- (AVCaptureConnection *)getOrientationAdaptedCaptureConnection{
    
    AVCaptureConnection *videoConnection = nil;
    
    for(AVCaptureConnection *connection in [_stillImageOutput connections]){
        for(AVCaptureInputPort *port in [connection inputPorts]){
            if([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                [self assignVideoOrienationForVideoConnection:videoConnection];
                break;
            }
        }
        if(videoConnection){
            [self assignVideoOrienationForVideoConnection:videoConnection];
        }
    }
    
    return videoConnection;
}

- (void)assignVideoOrienationForVideoConnection:(AVCaptureConnection *)videoConnection
{
    AVCaptureVideoOrientation newOrientation;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
            newOrientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            newOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            newOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            newOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            newOrientation = AVCaptureVideoOrientationPortrait;
    }
    [videoConnection setVideoOrientation: newOrientation];
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


@end
