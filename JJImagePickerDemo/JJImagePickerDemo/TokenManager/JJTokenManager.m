//
//  TokenManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJTokenManager.h"

NSString *const TOKEN_KEY = @"eyJhbGciOiJI";
@implementation JJTokenManager

// 存储token
+(void)saveToken:(LoginModel *)token
{
    NSError *error;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *tokenData;
    if (@available(iOS 11.0, *)) {
        tokenData = [NSKeyedArchiver archivedDataWithRootObject:token requiringSecureCoding:YES error:nil];
    } else {
        // Fallback on earlier versions
        tokenData = [NSKeyedArchiver archivedDataWithRootObject:token];
    }
    
    [userDefaults setObject:tokenData forKey:TOKEN_KEY];
    [userDefaults synchronize];
}

// 读取token
+(LoginModel *)getToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *tokenData = [userDefaults objectForKey:TOKEN_KEY];
    LoginModel *token = [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
    [userDefaults synchronize];
    return token;
}

// 清空token
+(void)cleanToken
{
    NSUserDefaults *UserLoginState = [NSUserDefaults standardUserDefaults];
    [UserLoginState removeObjectForKey:TOKEN_KEY];
    [UserLoginState synchronize];
}


// 跟新token
+(LoginModel *)refreshToken
{
    return nil;
}


@end
