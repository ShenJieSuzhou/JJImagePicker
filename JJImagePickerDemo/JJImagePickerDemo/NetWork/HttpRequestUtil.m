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

+ (void)JJ_VerifyLoginToken:(NSString *)url token:(NSString *)token callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

@end
