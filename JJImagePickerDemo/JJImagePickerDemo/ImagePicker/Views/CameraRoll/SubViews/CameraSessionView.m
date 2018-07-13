//
//  CameraSessionView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraSessionView.h"

@implementation CameraTopBar
@synthesize background = _background;
@synthesize backBtn = _backBtn;
@synthesize flashBtn = _flashBtn;
@synthesize switchBtn = _switchBtn;

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

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

@implementation CameraButtomBar
@synthesize shutterBtn = _shutterBtn;

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
    //无背景色
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.shutterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shutterBtn setBackgroundColor:[UIColor clearColor]];
    [self.shutterBtn setImage:[UIImage imageNamed:@"oie_transparent-20"] forState:UIControlStateNormal];
    [self.shutterBtn setImage:[UIImage imageNamed:@"oie_transparent-20"] forState:UIControlStateSelected];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        [self.shutterBtn setFrame:CGRectMake(0, 0, 100, 100)];
    }else{
        [self.shutterBtn setFrame:CGRectMake(0, 0, 80, 80)];
    }
    
    [self addSubview:self.shutterBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.shutterBtn setFrame:CGRectMake((self.frame.size.width - self.shutterBtn.frame.size.width)/2, 10, self.shutterBtn.frame.size.width, self.shutterBtn.frame.size.height)];
}

@end



@implementation CameraSessionView
@synthesize captureManager = _captureManager;
@synthesize buttomBar = _buttomBar;

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
    [self setupCaptureManager:RearFacingCamera];
    [self composeInterface];
    [_captureManager.session startRunning];
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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
    }else{
        self.buttomBar = [[CameraButtomBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, 100)];
        [self.buttomBar.shutterBtn addTarget:self action:@selector(clickShutterBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttomBar];
    }
}

//按下快门
- (void)clickShutterBtn:(UIButton *)sender{
    [_captureManager captureStillImage];
}

- (void)setTopBarColor:(UIColor *)topBarColor{
    
}

- (void)hideFlashButton{
    
}

- (void)hideCameraToggleButton{
    
}

- (void)hideDismissButton{
    
}

@end
