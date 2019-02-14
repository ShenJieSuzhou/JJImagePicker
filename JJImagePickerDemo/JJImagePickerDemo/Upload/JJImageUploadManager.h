//
//  JJImageUploadManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/2/14.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JJImageUploadManager : NSObject

+ (JJImageUploadManager *)shareInstance;

- (void)uploadImageToQN:(NSString *)imageUrl image:(UIImage *)image;


@end

