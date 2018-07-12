//
//  CameraSessionView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraSessionView.h"

@implementation CameraSessionView
@synthesize captureManager = _captureManager;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    
    
}

-(void)setupCaptureManager:(CameraType)camera {
    
    _captureManager = [CameraSessionManager getInstance];
//    //删除已经存在的input
//    AVCaptureInput *currentCameraInput = [sessionManager.session.inputs objectAtIndex:0];
//    [sessionManager.session removeInput:currentCameraInput];
    [_captureManager.session beginConfiguration];
    
    if(_captureManager){
        //config
        [_captureManager setDelegate:self];
        [_captureManager initiateCaptureSessionForCamera:camera];
        [_captureManager addStillImageOutput];
        [_captureManager addVideoPreviewLayer];
        [self.captureManager.session commitConfiguration];
        
        //preview layer setup
        CGRect layerRect = self.layer.bounds;
        [_captureManager.previewLayer setBounds:layerRect];
        [_captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
        
        //apply animation effect to the camera's preview layer
        CATransition *applicationLoadViewIn = [CATransition animation];
        [applicationLoadViewIn setDuration:0.6];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [_captureManager.previewLayer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
        
        [self.layer addSublayer:_captureManager.previewLayer];
    }
}

-(void)composeInterface {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
    }else{
        
    }
}

@end
