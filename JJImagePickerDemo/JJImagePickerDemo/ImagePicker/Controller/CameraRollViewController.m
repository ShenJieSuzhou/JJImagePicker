//
//  CameraRollViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraRollViewController.h"
#import "CameraSessionView.h"
#import "SnapshotPreviewView.h"
#import "PhotoEditingViewController.h"
#import <Photos/Photos.h>


@interface CameraRollViewController ()<JJCameraSessionDelegate>
@property (nonatomic, strong) CameraSessionView *cameraView;
@property (nonatomic, strong) SnapshotPreviewView *snapShotView;
@property (nonatomic, strong) PhotoEditingViewController *photoEditingView;


@end

@implementation CameraRollViewController

@synthesize cameraView = _cameraView;
@synthesize snapShotView = _snapShotView;
@synthesize photoEditingView = _photoEditingView;

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

#pragma mark - JJCameraSessionDelegate
//取消拍照
- (void)captureImageCancel{    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)captureImageFinished:(UIImage *)image{
    if(!image){
        return;
    }
        
    [self.snapShotView setImage:image];
    [self.view addSubview:self.snapShotView];
}

//懒加载
- (SnapshotPreviewView *)snapShotView{
    if(!_snapShotView){
         _snapShotView = [[SnapshotPreviewView alloc] initWithFrame:self.view.frame];
        [_snapShotView.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_snapShotView.useBtn addTarget:self action:@selector(useBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_snapShotView.editBtn addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
    }
   
    return _snapShotView;
}

- (PhotoEditingViewController *)photoEditingView{
    if(!_photoEditingView){
        _photoEditingView = [[PhotoEditingViewController alloc] init];
    }
    return _photoEditingView;
}

//取消选用该照片
- (void)cancelBtnClick:(UIButton *)sender{
    [self.snapShotView removeFromSuperview];
}

//编辑照片
- (void)editImage:(UIButton *)sender{
    UIImage *photoImage = self.snapShotView.snapShot;
//    __weak typeof(self) weakSelf = self;
//    [self presentViewController:self.photoEditingView animated:YES completion:^{
//        [weakSelf.photoEditingView setEditImage:photoImage];
//    }];
    [self.photoEditingView setEditImage:photoImage];
    [self.navigationController pushViewController:self.photoEditingView animated:YES];
}

//使用该照片，并存入相册
- (void)useBtnClick:(UIButton *)sender{

    UIImage *photoImage = self.snapShotView.snapShot;
    //保存至相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:photoImage];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if(!error){
            NSLog(@"success = %d", success);
        }else{
            NSLog(@"%@", error);
        }
    }];
}

@end
