//
//  JJPhoto.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPhoto.h"

@implementation JJPhoto
@synthesize thumbImage = _thumbImage;
@synthesize originImage = _originImage;

- (instancetype)initWithPHAsset:(PHAsset *)phAsset{
    if(self = [super init]){
        _asset = phAsset;
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

- (PHAsset *)asset{
    return _asset;
}

@end
