//
//  JJPhotoAlbum.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPhotoAlbum.h"
#import "JJImageManager.h"

@interface JJPhotoAlbum()

@property (nonatomic, strong) PHAssetCollection *phAssetCollection;

@property (nonatomic, strong) PHFetchResult *phFetchResult;

@end


@implementation JJPhotoAlbum


- (instancetype)initWithPHCollection:(PHAssetCollection *)phAssetCollection{
    return [self initWithPHCollection:phAssetCollection fetchAssetOptions:nil];
}

- (instancetype)initWithPHCollection:(PHAssetCollection *)phAssetCollection fetchAssetOptions:(PHFetchOptions *)phFetchOption{
    self = [super init];
    if(self){
        PHFetchResult *phFetchResult = [PHAsset fetchAssetsInAssetCollection:phAssetCollection options:phFetchOption];
        self.phFetchResult = phFetchResult;
        self.phAssetCollection = phAssetCollection;
    }
    
    return self;
}


// 相册名称
- (NSString *)albumName{
    NSString *name = self.phAssetCollection.localizedTitle;
    return name;
}

//相册数量
- (NSInteger)numberOfAsset{
    return self.phFetchResult.count;
}

//相册的缩略图
- (UIImage *)albumThumbWithSize:(CGSize)size{
    __block UIImage *resultImage;
    NSInteger count = self.phFetchResult.count;
    if(count > 0){
        PHAsset *asset = self.phFetchResult[count - 1];
        PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
        phImageRequestOptions.synchronous = YES;
        phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        
        [[[JJImageManager getInstance] phCachingImageManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            resultImage = result;
        }];
    }

    return resultImage;
}

/*
 * 获取相册内的所有资源
 *
 */
- (void)getAlbumAssetWithOptions:(void (^)(JJPhoto *result))assetBlcok{
    NSInteger resultCount = self.phFetchResult.count;
    //日期最新的排在前面
    for(NSInteger i = resultCount - 1; i >= 0; i--){
        PHAsset *phAsset = self.phFetchResult[i];
        JJPhoto *photo = [[JJPhoto alloc] initWithPHAsset:phAsset];
        if(assetBlcok){
            assetBlcok(photo);
        }
    }
    
    /**
     *  For 循环遍历完毕，这时再调用一次，并传递 nil 作为实参，作为枚举资源结束的标记。
     */
    if(assetBlcok){
        assetBlcok(nil);
    }
    
}

@end
