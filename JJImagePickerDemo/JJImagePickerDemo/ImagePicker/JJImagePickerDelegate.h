//
//  JJImagePickerDelegate.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJImagePickerShareDelegate <NSObject>

- (void)JJImagePicker:(NSMultableArray *)selectedImages withImageCount:(NSUIInteger)count;

@end









