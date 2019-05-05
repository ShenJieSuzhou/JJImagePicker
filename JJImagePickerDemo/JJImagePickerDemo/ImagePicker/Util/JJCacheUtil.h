//
//  JJCacheUtil.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/5.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageManager.h>

@interface JJCacheUtil : NSObject

/**
 检查图片是否存在
 @param url 图片地址
 @param completion 完成
 */
+ (void)diskImageExistsWithUrl:(NSString *)url completion:(void(^)(UIImage *image))completion;


@end


