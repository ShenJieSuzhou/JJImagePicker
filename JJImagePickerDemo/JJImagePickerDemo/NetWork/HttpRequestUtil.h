//
//  HttpRequestUtil.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

typedef void(^requestCallBack)(NSDictionary *data, NSError *error);

@interface HttpRequestUtil : NSObject

//请求主页信息
+ (void)JJ_RequestTHeData:(NSString *)url callback:(requestCallBack) block;

//请求验证码
+ (void)JJ_RequestSMSCode:(NSString *)url phone:(NSString *)telephone callback:(requestCallBack) block;

//手机验证码登录
+ (void)JJ_LoginByPhoneAndCode:(NSString *)url phone:(NSString *)telephone code:(NSString *)code callback:(requestCallBack) block;

//账号密码登录
+ (void)JJ_LoginByAccountPwd:(NSString *)url account:(NSString *)account pwd:(NSString *)pwd callback:(requestCallBack) block;

@end
