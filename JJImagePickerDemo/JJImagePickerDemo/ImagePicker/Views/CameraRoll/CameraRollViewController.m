//
//  CameraRollViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraRollViewController.h"
#import "CameraSessionView.h"


@interface CameraRollViewController ()<JJCameraSessionDelegate>
@property (nonatomic, strong) CameraSessionView *cameraView;



@end

@implementation CameraRollViewController

@synthesize cameraView = _cameraView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.bounds];
    _cameraView.delegate = self;
    [self.view addSubview:_cameraView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//取消拍照
- (void)captureImageCancel{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
