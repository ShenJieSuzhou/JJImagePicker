//
//  JJPhoto.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPhoto.h"
#import "JJImageManager.h"
#import <MobileCoreServices/UTCoreTypes.h>
#define ScreenScale ([[UIScreen mainScreen] scale])
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation JJPhoto
//@synthesize thumbImage = _thumbImage;
//@synthesize originImage = _originImage;

- (instancetype)initWithPHAsset:(PHAsset *)phAsset{
    if(self = [super init]){
        _jjAsset = phAsset;
        switch (phAsset.mediaType) {
            case PHAssetMediaTypeImage:
                _assetType = JJAssetTypeImage;
                if([[phAsset valueForKey:@"uniformTypeIdentifier"] isEqualToString:(__bridge NSString *)kUTTypeGIF]){
                    _assetSubType = JJAssetSubTypeGIF;
                }else{
                    if(@available(iOS 9.1, *)){
                        if(phAsset.mediaSubtypes & PHAssetMediaSubtypePhotoLive){
                            _assetSubType = JJAssetSubTypeLivePhoto;
                        }else{
                            _assetSubType = JJAssetSubTypeImage;
                        }
                    } else{
                        _assetSubType = JJAssetSubTypeImage;
                    }
                }
                break;
            case PHAssetMediaTypeVideo:
                _assetType = JJAssetTypeVideo;
                break;
            case PHAssetMediaTypeAudio:
                _assetType = JJAssetTypeAudio;
                break;
            case PHAssetMediaTypeUnknown:
                _assetType = JJAssetTypeUnknow;
                break;
            default:
                break;
        }
    }
    
    return self;
}

- (PHAsset *)jjAsset{
    return _jjAsset;
}

- (NSString *)identifier {
    return _jjAsset.localIdentifier;
}

- (NSTimeInterval)duration{
    if(self.assetType != JJAssetTypeVideo){
        return 0;
    }
    
    return _jjAsset.duration;
}

- (UIImage *)originImage{
    __block UIImage *resultImage = nil;
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

//    phImageRequestOptions.networkAccessAllowed = YES;
//    phImageRequestOptions.synchronous = YES;

    [[JJImageManager getInstance].phCachingImageManager requestImageForAsset:_jjAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;
    }];
    
    return resultImage;
}

- (UIImage *)thumbnailWithSize:(CGSize)size{
    __block UIImage *resultImage;
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    [[JJImageManager getInstance].phCachingImageManager requestImageForAsset:_jjAsset
                                                                  targetSize:CGSizeMake(size.width * ScreenScale, size.height * ScreenScale) contentMode:PHImageContentModeAspectFill options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                      
                                                                      resultImage = result;
    }];
    
    return resultImage;
}

- (NSInteger)requestThumbnailImageWithSize:(CGSize)size
                                completion:(void(^)(UIImage *result, NSDictionary *info))completion{
    
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    return [[JJImageManager getInstance].phCachingImageManager requestImageForAsset:_jjAsset
                                                                         targetSize:CGSizeMake(size.width * ScreenScale, size.height * ScreenScale) contentMode:PHImageContentModeAspectFill options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                      
                                                                      if (completion) {
                                                                          completion(result, info);
                                                                      }
                                                                  }];
}


- (NSInteger)requestOriginImageWithCompletion:(void (^)(UIImage *result, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler{
    
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.networkAccessAllowed = YES; // 允许访问网络
    imageRequestOptions.progressHandler = phProgressHandler;
    
    return [[JJImageManager getInstance].phCachingImageManager requestImageForAsset:_jjAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if(completion){
            completion(result, info);
        }
    }];
}

- (NSInteger)requestPreviewImageWithCompletion:(void (^)(UIImage *result, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler{
    
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.networkAccessAllowed = YES;
    imageRequestOptions.progressHandler = phProgressHandler;
    
    return [[JJImageManager getInstance].phCachingImageManager requestImageForAsset:_jjAsset targetSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) contentMode:PHImageContentModeAspectFill options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if(completion){
            completion(result, info);
        }
    }];
}

- (NSInteger)requestLivePhotoWithCompletion:(void (^)(PHLivePhoto *livePhoto, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler{
    if([[PHCachingImageManager class] instancesRespondToSelector:@selector(requestLivePhotoForAsset:targetSize:contentMode:options:resultHandler:)]){
        PHLivePhotoRequestOptions *livePhotoRequestOptions = [[PHLivePhotoRequestOptions alloc] init];
        livePhotoRequestOptions.networkAccessAllowed = YES;
        livePhotoRequestOptions.progressHandler = phProgressHandler;
        
        return [[JJImageManager getInstance].phCachingImageManager requestLivePhotoForAsset:_jjAsset targetSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) contentMode:PHImageContentModeAspectFill options:livePhotoRequestOptions resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
            
            if(completion){
                completion(livePhoto, info);
            }
        }];
    }else{
        if(completion){
            completion(nil, nil);
        }
        
        return 0;
    }
}

- (void)assetSize:(void (^)(long long size))completion{
    
    
}




@end
