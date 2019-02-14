//
//  JJImageUploadManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/2/14.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJImageUploadManager.h"
#import <Qiniu/QiniuSDK.h>

@implementation JJImageUploadManager

+ (JJImageUploadManager *)shareInstance{
    static JJImageUploadManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JJImageUploadManager alloc] init];
    });
    
    return instance;
}

- (void)uploadImageToQN:(NSString *)imageUrl image:(UIImage *)image{
    NSString *token = @"从服务端SDK获取";
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
    [upManager putData:data key:@"hello" token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
              } option:nil];
}


@end
