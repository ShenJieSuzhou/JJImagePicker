//
//  JJImageViewPicker.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJImageViewPicker.h"
#import "PhotosViewController.h"

@implementation JJImageViewPicker

+ (void)showTheActionsheet:(UIViewController *)viewController{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出相册选择器
        PhotosViewController *photosView = [[PhotosViewController alloc] init];
        //获取相机胶卷的图片
        
        [viewController presentViewController:photosView animated:YES completion:^{
            
        }];
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
