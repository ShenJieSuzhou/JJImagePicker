//
//  HttpRequestUtil.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "HttpRequestUtil.h"
#import <AFNetwork/AFNetwork.h>

@implementation HttpRequestUtil

+ (void)JJ_RequestTHeData:(NSString *)url callback:(requestCallBack) block{
    
//    [[AFNetwork shareManager] requestWithMethod:GET url:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
//        block(dict);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    [[AFNetwork shareManager] requestURL:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        block(nil, error);
    }];
}

+ (void)JJ_RequestSMSCode:(NSString *)url phone:(NSString *)telephone callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:telephone, @"phone", nil];
    [[AFNetwork shareManager] requestURL:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_LoginByPhoneAndCode:(NSString *)url phone:(NSString *)telephone code:(NSString *)code callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:telephone, @"phone", code, @"smsCode",nil];
    [[AFNetwork shareManager] requestURL:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_LoginByAccountPwd:(NSString *)url account:(NSString *)account pwd:(NSString *)pwd callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:account, @"account", pwd, @"pwd",nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_VerifyLoginToken:(NSString *)url token:(NSString *)token userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_UpdateUserNickName:(NSString *)url name:(NSString *)name userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_UpdateUserGender:(NSString *)url gender:(int)gender userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_UpdateUserBirth:(NSString *)url birth:(NSString *)birth userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_UpdateUserAvatar:(NSString *)url avatar:(NSString *)avatar userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_NewUserSetPassword:(NSString *)url pwd:(NSString *)pwd userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_SetUserNewPassword:(NSString *)url oldPwd:(NSString *)oldpwd newPwd:(NSString *)newPwd userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_ReqBindPhoneCode:(NSString *)url phone:(NSString *)phone userid:(NSString *)userid callback:(requestCallBack) block{
    
}

+ (void)JJ_BindUserPhone:(NSString *)url phone:(NSString *)phone code:(NSString *)code userid:(NSString *)userid callback:(requestCallBack) block{
    
}

@end
