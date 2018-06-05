//
//  JJImageManager.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJImageManager.h"

@interface JJImageManager()

@property (nonatomic, strong) PHCachingImageManager *phCachingImageManager;

@end


@implementation JJImageManager

+ (JJImageManager *)getInstance{
    static JJImageManager *m_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[JJImageManager alloc] init];
    });
    
    return m_instance;
}

//请求相册权限
+ (JJPHAuthorizationStatus)requestAlbumPemission{
    __block JJPHAuthorizationStatus jjstatus;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
        jjstatus = JJPHAuthorizationStatusNotAuthorized;
    }else if(status == PHAuthorizationStatusNotDetermined){
        jjstatus = JJPHAuthorizationStatusNotDetermined;
    }else{
        jjstatus = JJPHAuthorizationStatusAuthorized;
    }
    
    return jjstatus;
}

- (void)getAllAlbumsWithAlbumContentType:(JJAlbumContentType) contentType
                          showEmptyAlbum:(BOOL)showEmptyAlbum
                          showSmartAlbum:(BOOL)showSmartAlbum{
    
    //获取所有的相册
    NSArray *tempAlbumArray = [PHPhotoLibrary fetchAllAlbumsWithAlbumContentType:contentType showEmptyAlbum:showEmptyAlbum showSmartAlbum:showSmartAlbum];
    //创建一个 PHFetchOptions
    PHFetchOptions *fetchOptions = [PHPhotoLibrary createFetchOptionsWithAlbumContentType:contentType];
    
    //遍历结果
    for (int i = 0; i < tempAlbumArray.count; i++) {
        PHAssetCollection *phAssetCollection = [tempAlbumArray objectAtIndex:i];
        
    }
    
    
}

- (PHCachingImageManager *)phCachingImageManager {
    if (!_phCachingImageManager) {
        _phCachingImageManager = [[PHCachingImageManager alloc] init];
    }
    return _phCachingImageManager;
}

////获取相册
//+ (void)getPhotoAlbum{
//
//    // 列出所有相册智能相册
//    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//
//    // 列出所有用户创建的相册
//    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
//
//    // 获取所有资源的集合，并按资源的创建时间排序
//    PHFetchOptions *options = [[PHFetchOptions alloc] init];
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
//
//}

@end

@implementation PHPhotoLibrary (JJ)

+ (PHFetchOptions *)createFetchOptionsWithAlbumContentType:(JJAlbumContentType)contentType{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    switch (contentType) {
        case JJAlbumContentTypeOnlyPhoto:
            fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
            break;
        case JJAlbumContentTypeOnlyVideo:
            fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i",PHAssetMediaTypeVideo];
            break;
        case JJAlbumContentTypeOnlyAudio:
            fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i",PHAssetMediaTypeAudio];
            break;
        default:
            break;
    }
    
    return fetchOptions;
}

//获取所有相册
+ (NSArray *)fetchAllAlbumsWithAlbumContentType:(JJAlbumContentType) contentType showEmptyAlbum:(BOOL)showEmptyAlbum showSmartAlbum:(BOOL)showSmartAlbum{
    
    NSMutableArray *jjAlbumsArray = [[NSMutableArray alloc] init];
    
    
    //创建一个PHFetchOptions
    PHFetchOptions *fetchOptions = [JJImageManager createFetchOptionsWithAlbumContentType:contentType];
    
    PHFetchResult *fetchResult;
    if(showSmartAlbum){
        //允许显示系统的智能相册
        fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    }else{
        fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    }
    
    //遍历相册列表
    for (NSInteger i = 0; i < fetchResult.count; i++) {
        //获取一个相册
        PHCollection *collection = fetchResult[i];
        if([collection isKindOfClass:[PHAssetCollection class]]){
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *currentFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
            //若相册不为空，或者允许显示空相册，则保存相册结果到数组
            //如果是相机胶卷，则放到结果列表的第一位
            if (currentFetchResult.count > 0 || showEmptyAlbum) {
                if(assetCollection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary){
                    [jjAlbumsArray insertObject:assetCollection atIndex:0];
                }else{
                    [jjAlbumsArray addObject:assetCollection];
                }
            }
        }else{
            NSAssert(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }
    
    //获取所有用户自己创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //循环遍历用户自己创建的相册
    for (int i = 0; i < topLevelUserCollections.count; i++) {
        PHCollection *collection = [topLevelUserCollections objectAtIndex:i];
        if([collection isKindOfClass:[PHAssetCollection class]]){
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            if(showEmptyAlbum){
                //允许空相册
                [jjAlbumsArray addObject:assetCollection];
            }else{
                //不允许显示空相册
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
                if(fetchResult.count > 0){
                    [jjAlbumsArray addObject:assetCollection];
                }
            }
        }
    }
    
    
    //mac 待保留
    
    NSArray *resultAlbumArray = [jjAlbumsArray copy];
    return resultAlbumArray;
}

+ (PHAsset *)fetchLatestAssetWithAssetCollection:(PHAssetCollection *)assetCollection{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    //按时间顺序进行排序
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
    PHAsset *latestAsset = [fetchResult lastObject];
    return latestAsset;
}


@end
