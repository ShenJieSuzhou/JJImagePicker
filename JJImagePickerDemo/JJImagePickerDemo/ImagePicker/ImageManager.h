//
//  ImageManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ImageManager : NSObject

//请求相册权限
+ (void)requestAlbumPemission;

//获取相册
+ (void)getPhotoAlbum;

@end
