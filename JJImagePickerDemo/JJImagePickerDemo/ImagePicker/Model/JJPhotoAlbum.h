//
//  JJPhotoAlbum.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJPhoto.h"
#import "JJImageManager.h"

//相册展示内容的类型
typedef NS_ENUM(NSInteger, JJAlbumContentType){
    JJAlbumContentTypeAll,                                  // 展示所有资源
    JJAlbumContentTypeOnlyPhoto,                            // 只展示照片
    JJAlbumContentTypeOnlyVideo,                            // 只展示视频
    JJAlbumContentTypeOnlyAudio                             // 只展示音频
};

//typedef NS_ENUM(NSInteger, JJAlbumSortType){
//
//};


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
