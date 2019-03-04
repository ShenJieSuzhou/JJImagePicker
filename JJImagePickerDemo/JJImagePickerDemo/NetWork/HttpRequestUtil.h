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

/**
 验证token有效性

 @param token token
 @param block 回调
 */
+ (void)JJ_VerifyLoginToken:(NSString *)url token:(NSString *)token userid:(NSString *)userid callback:(requestCallBack) block;

/**
 获取自己的作品

 @param url 请求地址
 @param token token
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_GetMyWorksArray:(NSString *)url token:(NSString *)token userid:(NSString *)userid callback:(requestCallBack) block;


/**
 发布自己的作品

 @param url 请求地址
 @param token token
 @param photoInfo 新鲜事
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_PublishMyPhotoWorks:(NSString *)url token:(NSString *)token photoInfo:(NSString *)photoInfo userid:(NSString *)userid callback:(requestCallBack) block;


/**
 跟新用户昵称

 @param url 请求地址
 @param name 昵称
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_UpdateUserNickName:(NSString *)url token:(NSString *)token name:(NSString *)name userid:(NSString *)userid callback:(requestCallBack) block;


/**
 跟新用户Gender

 @param url 请求地址
 @param gender 性别
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_UpdateUserGender:(NSString *)url token:(NSString *)token gender:(int)gender userid:(NSString *)userid callback:(requestCallBack) block;


/**
 跟新用户生日

 @param url 请求地址
 @param birth 生日
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_UpdateUserBirth:(NSString *)url token:(NSString *)token birth:(NSString *)birth userid:(NSString *)userid callback:(requestCallBack) block;


/**
 更新用户头像

 @param url 请求地址
 @param avatar 头像地址
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_UpdateUserAvatar:(NSString *)url token:(NSString *)token avatar:(NSString *)avatar userid:(NSString *)userid callback:(requestCallBack) block;


/**
 新用户设置密码

 @param url 请求地址
 @param pwd 密码
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_NewUserSetPassword:(NSString *)url token:(NSString *)token pwd:(NSString *)pwd userid:(NSString *)userid callback:(requestCallBack) block;


/**
 老用户设置新密码

 @param url 请求地址
 @param oldpwd 老密码
 @param newPwd 新密码
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_SetUserNewPassword:(NSString *)url token:(NSString *)token oldPwd:(NSString *)oldpwd newPwd:(NSString *)newPwd userid:(NSString *)userid callback:(requestCallBack) block;



/**
 绑定手机请求验证码

 @param url 请求地址
 @param phone 电话号码
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_ReqBindPhoneCode:(NSString *)url token:(NSString *)token phone:(NSString *)phone userid:(NSString *)userid callback:(requestCallBack) block;

/**
 绑定手机

 @param url 请求地址
 @param phone 电话
 @param code 验证码
 @param userid 用户ID
 @param block 回调
 */
+ (void)JJ_BindUserPhone:(NSString *)url token:(NSString *)token phone:(NSString *)phone code:(NSString *)code userid:(NSString *)userid callback:(requestCallBack) block;


/**
 微信登录 获取access_token

 @param url  https://api.weixin.qq.com/sns/oauth2/access_token?
 @param appid 应用的appid
 @param secret 应用的secret
 @param code 获取的code参数
 @param block 回调
 */
+ (void)JJ_WechatLogin:(NSString *)url appid:(NSString *)appid secret:(NSString *)secret code:(NSString *)code callback:(requestCallBack) block;

@end
