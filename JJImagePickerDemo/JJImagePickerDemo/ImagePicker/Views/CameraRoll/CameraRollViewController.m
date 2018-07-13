//
//  CameraRollViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraRollViewController.h"
#import "CameraSessionView.h"


@interface CameraRollViewController ()

////捕获设备，前置摄像头，后置摄像头
//@property (nonatomic, strong) AVCaptureDevice *device;
//
////输入设备
//@property (nonatomic, strong) AVCaptureDeviceInput *input;
//
////启动摄像头捕获输入
//@property (nonatomic, strong) AVCaptureMetadataOutput *output;
//
////照片输出流
//@property (nonatomic, strong) AVCapturePhotoOutput *imageOutput;
//
//@property (nonatomic, strong) AVCaptureSession *session;
//
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//
////------------------------  UI -------------------------
////拍照按钮
//@property (nonatomic, weak) UIButton *photoButton;
////闪光灯按钮
////@property (nonatomic)
////聚焦
//@property (nonatomic, weak) UIView *focusView;
////是否开启闪光灯
//@property (assign) BOOL isflashOn;

@property (nonatomic, strong) CameraSessionView *cameraView;



@end

@implementation CameraRollViewController

@synthesize cameraView = _cameraView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_cameraView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
