//
//  JJImageViewPicker.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJImageViewPicker.h"
#import "PhotosViewController.h"
#import "JJImageManager.h"
#import "CameraRollViewController.h"

@implementation JJImageViewPicker

+ (void)showTheActionsheet:(UIViewController *)viewController{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出相机 📷
        CameraRollViewController *cameraView = [[CameraRollViewController alloc] init];
        [viewController presentViewController:cameraView animated:YES completion:^{
            
        }];
    }];

    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([JJImageManager requestAlbumPemission] == JJPHAuthorizationStatusNotAuthorized){
            //如果没有获取访问权限，或者访问权限已被明确静止，则显示提示语，引导用户开启授权
            NSLog(@"请在设备的\"设置-隐私-照片\"选项中，允许访问你的手机相册");
        }else{
            //弹出相册选择器
            PhotosViewController *photosView = [[PhotosViewController alloc] init];
            //获取相机胶卷的图片
            [viewController presentViewController:photosView animated:YES completion:^{
                
            }];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:camera];
    [actionSheet addAction:album];
    [actionSheet addAction:cancel];
    
    [viewController presentViewController:actionSheet animated:YES completion:^{
        
    }];
}



@end
