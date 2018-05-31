//
//  ImageManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

//请求相册权限
+ (void)requestAlbumPemission{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status == PHAuthorizationStatusNotDetermined){
            
        }else if(status == PHAuthorizationStatusRestricted){
            
        }else if(status == PHAuthorizationStatusDenied){
            
        }else if(status == PHAuthorizationStatusAuthorized){
            
        }

    }];
}

//获取相册
+ (void)getPhotoAlbum{
    
}

@end
