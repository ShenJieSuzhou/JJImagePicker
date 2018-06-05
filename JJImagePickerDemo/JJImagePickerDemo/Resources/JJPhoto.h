//
//  JJPhoto.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "JJImageManager.h"

/// Asset 的类型
typedef NS_ENUM(NSUInteger, JJAssetType) {
    JJAssetTypeUnknow,                                    // 未知类型
    JJAssetTypeImage,                                     // 图片类型
    JJAssetTypeVideo,                                     // 视频类型
    JJAssetTypeAudio                                      // 音频类型
};

typedef NS_ENUM(NSUInteger, JJAssetSubType) {
    JJAssetSubTypeUnknow,                                 // 未知类型
    JJAssetSubTypeImage,                                  // 静态图片
    JJAssetSubTypeLivePhoto NS_ENUM_AVAILABLE_IOS(9_1),   // Live Photo
    JJAssetSubTypeGIF                                     // GIF类型
};

@interface JJPhoto : NSObject

- (instancetype)initWithPHAsset:(PHAsset *)phAsset;

@property(nonatomic, assign, readonly) JJAssetType assetType;
@property(nonatomic, assign, readonly) JJAssetSubType assetSubType;

@property (nonatomic, strong) PHAsset *asset;
//Asset 标识
@property (nonatomic, copy) NSString *identifier;
////缩略图
//@property (nonatomic, strong) UIImage *thumbImage;
////原图
//@property (nonatomic, strong) UIImage *originImage;

/// Asset 的原图（包含系统相册“编辑”功能处理后的效果）
//- (UIImage *)originImage;

/**
 *  Asset 的缩略图
 *
 *  @param size 指定返回的缩略图的大小，pt 为单位
 *
 *  @return Asset 的缩略图
 */
//- (UIImage *)thumbnailWithSize:(CGSize)size;

/*
 * 异步请求 asset 的缩略图
 * @param size 指定返回的缩略图的大小
 * @param competion 回调，回调中包含了图片信息，该函数会被多次调用，
                    第一次获得小尺寸的低清图，然后不断被调用，直到获取到高清图，到这个时候第二个参数返回的信息为nil
 * @param f返回请求的图片id
 */
- (NSInteger)requestThumbnailImageWithSize:(CGSize)size
                                completion:(void(^)(UIImage *result, NSDictionary *info))completion;


/*
 * 异步请求 asset 的原图
 * @param competion         回调，回调中包含了图片信息，该函数会被多次调用，第一次获得小尺寸的低清图，然后不断被调用，
 *                          直到获取到高清图，到这个时候第二个参数返回的信息为 nil
 *
 * @param phProgressHandler 处理请求进度的 handler, 不在主线程上执行，在 block 中修改 UI 时注意需要手工放到主线程处理。
 *
 * @param f返回请求的图片id
 */
- (NSInteger)requestOriginImageWithCompletion:(void (^)(UIImage *result, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler;

/**
 *  异步请求 Asset 的预览图
 *
 *  @param completion        完成请求后调用的 block，参数中包含了请求的预览图以及图片信息，这个 block 会被多次调用，
 *                           其中第一次调用获取到的尺寸很小的低清图，然后不断调用，直到获取到高清图。
 *  @param phProgressHandler 处理请求进度的 handler，不在主线程上执行，在 block 中修改 UI 时注意需要手工放到主线程处理。
 *
 *  @return 返回请求图片的请求 id
 */
- (NSInteger)requestPreviewImageWithCompletion:(void (^)(UIImage *result, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler;

/*
 *  异步请求 Live Photo
 *
 *  @param completion        完成请求后调用的 block，参数中包含了请求的预览图以及图片信息，这个 block 会被多次调用，
 *                           其中第一次调用获取到的尺寸很小的低清图，然后不断调用，直到获取到高清图。
 *  @param phProgressHandler 处理请求进度的 handler，不在主线程上执行，在 block 中修改 UI 时注意需要手工放到主线程处理。
 *
 *  @return 返回请求图片的请求 id
 */
- (NSInteger)requestLivePhotoWithCompletion:(void (^)(PHLivePhoto *livePhoto, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler NS_AVAILABLE_IOS(9_1);

/*
 * 异步请求 video
 *
 *  @param completion        完成请求后调用的 block，参数中包含了请求的预览图以及图片信息，这个 block 会被多次调用，
 *                           其中第一次调用获取到的尺寸很小的低清图，然后不断调用，直到获取到高清图。
 *  @param phProgressHandler 处理请求进度的 handler，不在主线程上执行，在 block 中修改 UI 时注意需要手工放到主线程处理。
 *
 *  @return 返回请求图片的请求 id
 */
- (NSInteger)requestPlayerItemWithCompletion:(void (^)(AVPlayerItem *playerItem, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetVideoProgressHandler)phProgressHandler;

/*
 * 异步请求 gif
 *
 * @param completion 完成请求后调用的 block，参数中包含了请求的图片 Data, 该图片是否为 GIF 的判断值
 */
- (void)requestImageData:(void (^)(NSData *imageData, NSDictionary<NSString *, id> *info, BOOL isGIF, BOOL isHEIC))completion;

@end
