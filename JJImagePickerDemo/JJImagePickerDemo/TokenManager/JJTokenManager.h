//
//  TokenManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface JJTokenManager : NSObject
// 存储token
+(void)saveToken:(LoginModel *)token;

// 读取token
+(LoginModel *)getToken;

// 清空token
+(void)cleanToken;

// 跟新token
+(LoginModel *)refreshToken;


@end

