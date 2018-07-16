//
//  JJImageManager.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "JJPhotoAlbum.h"

//asset 授权状态
typedef NS_ENUM(NSInteger, JJPHAuthorizationStatus){
    JJPHAuthorizationStatusNotDetermined,      // 还不确定有没有授权
    JJPHAuthorizationStatusAuthorized,         // 已经授权
    JJPHAuthorizationStatusNotAuthorized       // 手动禁止了授权
};

//相册展示内容
typedef NS_ENUM(NSUInteger, JJAlbumContentType){
    JJAlbumContentTypeAll,                                  // 展示所有资源
    JJAlbumContentTypeOnlyPhoto,                            // 只展示照片
    JJAlbumContentTypeOnlyVideo,                            // 只展示视频
    JJAlbumContentTypeOnlyAudio                             // 只展示音频
};

typedef void(^enumerationBlock)(JJPhotoAlbum *resultAlbum);


@interface JJImageManager : NSObject

/*
 * 获取单例
 */
+ (JJImageManager *)getInstance;

/*
 * 请求相册权限
 */
+ (JJPHAuthorizationStatus)requestAlbumPemission;

/*
 * 创建一个相册类型
 * @param contentType 相册的内容类型
 * @return 返回一个合适的 PHFetchOptions
 */
+ (PHFetchOptions *)createFetchOptionsWithAlbumContentType:(JJAlbumContentType)contentType;

/*
 * 获取所有相册
 * @param contentType    相册的内容类型
 * @param showEmptyAlbum 是否显示空相册
 * @param showSmartAlbum 是否显示智能相册
 * @return 返回相册数组
 */
+ (NSArray *)fetchAllAlbumsWithAlbumContentType:(JJAlbumContentType) contentType showEmptyAlbum:(BOOL)showEmptyAlbum showSmartAlbum:(BOOL)showSmartAlbum;

/*
 * 获取一个PHAssertCollection中创建日期最新的资源
 */
+ (PHAsset *)fetchLatestAssetWithAssetCollection:(PHAssetCollection *)assetCollection;

/*
 * 获取所有相册
 * @param contentType       相册类型
 * @param showEmptyAlbum    是否显示空相册
 * @param showSmartAlbum    是否显示只能相册
 * @param
 */
- (void)getAllAlbumsWithAlbumContentType:(JJAlbumContentType) contentType
                          showEmptyAlbum:(BOOL)showEmptyAlbum
                          showSmartAlbum:(BOOL)showSmartAlbum
                              usingBlock:(enumerationBlock)block;


/// 获取一个 PHCachingImageManager 的实例
- (PHCachingImageManager *)phCachingImageManager;


@end
