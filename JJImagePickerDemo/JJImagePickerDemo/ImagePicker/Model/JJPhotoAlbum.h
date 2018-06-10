//
//  JJPhotoAlbum.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJPhoto.h"

@interface JJPhotoAlbum : NSObject


- (instancetype)initWithPHCollection:(PHAssetCollection *)phAssetCollection;

- (instancetype)initWithPHCollection:(PHAssetCollection *)phAssetCollection fetchAssetOptions:(PHFetchOptions *)phFetchOption;

// 相册名称
- (NSString *)albumName;

//相册数量
- (NSInteger)numberOfAsset;

//相册的缩略图
- (UIImage *)albumThumbWithSize:(CGSize)size;

/*
 * 获取相册内的所有资源
 *
 */
- (void)getAlbumAssetWithOptions:(void (^)(JJPhoto *result))assetBlcok;


@end
