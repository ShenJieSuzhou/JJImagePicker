//
//  JJCacheUtil.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/5.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJCacheUtil.h"

@implementation JJCacheUtil

+ (void)diskImageExistsWithUrl:(NSString *)url completion:(void(^)(UIImage *image))completion{
    NSURL * nsurl = [NSURL URLWithString:url];
    [[SDWebImageManager sharedManager] diskImageExistsForURL:nsurl completion:^(BOOL isInCache) {
        if (isInCache) {
            if (completion) {
                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:nsurl];
                UIImage *adImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
                completion (adImage);
            }
        }
        else {
            [[SDWebImageManager sharedManager] loadImageWithURL:nsurl options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (completion) {
                    completion (image);
                }
                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:nsurl];
                [[SDWebImageManager sharedManager].imageCache storeImage:image imageData:data forKey:key toDisk:YES completion:^{
                    
                }];
            }];
        }
    }];
}

@end
