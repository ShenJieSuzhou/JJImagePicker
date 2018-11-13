//
//  CameraPhotoViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraPhotoViewController.h"
#import "PhotosViewController.h"
#import "JJImageManager.h"
#import "CameraRollViewController.h"
#import "GlobalDefine.h"

#define CP_BTN_HEIGHT 80.0f
#define CP_BTN_WIDTH self.view.frame.size.width / 2
#define CP_SCREEN_WIDTH self.view.frame.size.width
#define CP_SCREEN_HEIGHT self.view.frame.size.height

@interface CameraPhotoViewController ()

@property (strong, nonatomic) UIButton *albumBtn;
@property (strong, nonatomic) UIButton *cameraBtn;
@property (strong, nonatomic) UIButton *closeBtn;

@end

@implementation CameraPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupUI];
}

- (void)setupUI{
    self.albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.albumBtn setBackgroundColor:[UIColor redColor]];
    [self.albumBtn setTitle:@"相册" forState:UIControlStateNormal];
    [self.albumBtn setFrame:CGRectMake((CP_SCREEN_WIDTH - CP_BTN_WIDTH)/2, 100, CP_BTN_WIDTH, CP_BTN_HEIGHT)];
    [self.albumBtn addTarget:self action:@selector(clickAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.albumBtn];
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cameraBtn setBackgroundColor:[UIColor blueColor]];
    [self.cameraBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [self.cameraBtn setFrame:CGRectMake((CP_SCREEN_WIDTH - CP_BTN_WIDTH)/2, 250, CP_BTN_WIDTH, CP_BTN_HEIGHT)];
    [self.cameraBtn addTarget:self action:@selector(clickCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraBtn];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundColor:[UIColor grayColor]];
    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBtn setFrame:CGRectMake(0, CP_SCREEN_HEIGHT - CP_BTN_HEIGHT, CP_SCREEN_WIDTH, CP_BTN_HEIGHT)];
    [self.closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBtn];
}

- (void)clickAlbum:(UIButton *)sender{
    if([JJImageManager requestAlbumPemission] == JJPHAuthorizationStatusNotAuthorized){
        //如果没有获取访问权限，或者访问权限已被明确静止，则显示提示语，引导用户开启授权
        NSLog(@"请在设备的\"设置-隐私-照片\"选项中，允许访问你的手机相册");
    }else{
        //弹出相册选择器
        PhotosViewController *photosView = [[PhotosViewController alloc] init];
        [photosView setUpGridView:JJ_MAX_PHOTO_NUM min:0];
        //获取相机胶卷的图片
        [self presentViewController:photosView animated:YES completion:^{

        }];
    }
}

- (void)clickCamera:(UIButton *)sender{
    //弹出相机 📷
    CameraRollViewController *cameraView = [[CameraRollViewController alloc] init];
    [self presentViewController:cameraView animated:YES completion:^{

    }];
}

- (void)closeView:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
