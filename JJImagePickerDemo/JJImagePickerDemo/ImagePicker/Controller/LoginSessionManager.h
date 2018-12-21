//
//  LoginSessionManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface LoginSessionManager : NSObject

+ (LoginSessionManager *)getInstance;

/**
 是否登录

 @return 结果
 */
+ (BOOL)isUserLogin;



/**
 验证token是否过期

 @param userModel 用户信息
 */
+ (void)verifyUserToken;



@end

