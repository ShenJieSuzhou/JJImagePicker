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
- (UIImage *)originImage;

/**
 *  Asset 的缩略图
 *
 *  @param size 指定返回的缩略图的大小，pt 为单位
 *
 *  @return Asset 的缩略图
 */
- (UIImage *)thumbnailWithSize:(CGSize)size;

@end
