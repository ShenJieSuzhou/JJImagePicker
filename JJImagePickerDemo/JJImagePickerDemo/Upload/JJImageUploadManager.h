//
//  JJImageUploadManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/2/14.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^uploadToQnCallBack)(BOOL isSuccess, NSString *file);

@interface JJImageUploadManager : NSObject

+ (JJImageUploadManager *)shareInstance;

- (void)uploadImageToQN:(UIImage *)image uploadResult:(uploadToQnCallBack)jjResult;


@end

