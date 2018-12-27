//
//  Works.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Works : NSObject

@property (nonatomic, strong) NSString *path;

@property (nonatomic, strong) NSString *photoid;

@property (nonatomic, strong) NSString *userid;

@property (nonatomic, strong) NSString *work;

- (instancetype)initWithPath:(NSString *)path photoID:(NSString *)photoID userid:(NSString *)userid work:(NSString *)work;

@end


