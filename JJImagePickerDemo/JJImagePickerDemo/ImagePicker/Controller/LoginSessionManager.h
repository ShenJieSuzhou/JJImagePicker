//
//  LoginSessionManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@protocol LoginSessionDelegate <NSObject>

@optional
- (void)tokenVerifySuccessful;

- (void)tokenVerifyError:(NSString *)errorDesc;

- (void)networkError:(NSError *)error;

- (void)dataOccurError:(NSString *)errorMsg;

- (void)loginByAccountPwdSuccessful:(LoginModel *)model;

- (void)loginByAccountPwdFailed:(NSString *)errorMsg;

@end

@interface LoginSessionManager : NSObject
@property (weak, nonatomic) id<LoginSessionDelegate> delegate;
@property (strong, nonatomic) LoginModel *userModel;

+ (LoginSessionManager *)getInstance;

/**
 帐密登录
 @param url 地址
 @param account 账号
 @param password 密码
 */
- (void)loginByAccountPwd:(NSString *)url account:(NSString *)account pwd:(NSString *)password;


/**
 是否登录

 @return 结果
 */
- (BOOL)isUserLogin;



/**
 验证token是否过期

 @param userModel 用户信息
 */
- (void)verifyUserToken;


/**
 设置用户模型

 @param model 用户模型
 */
- (void)setUserInfo:(LoginModel *)model;


/**
 得到用户模型

 @return 用户模型
 */
- (LoginModel *)getUserModel;



@end

