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
+ (JJTokenManager *)shareInstance;

//  添加用户信息
- (void)setUserLoginInfo:(LoginModel *)info;
//  移除所有用户信息
- (void)removeAllUserInfo;

//  保存用户的id
- (void)saveUserID:(NSString *)userID;
//  获取用户的id
- (NSString *)getUserID;
//  取消用户的ID
- (void)cancelUserID;

//  保存用户avatar头像
- (void)saveUserAvatar:(NSString *)avatar;
- (NSString *)gettUserAvatar;
- (void)cancelUserAvatar;

//  保存用户的gender
- (void)saveUserGender:(NSNumber *)gender;
- (NSString *)getUserGender;
- (void)cancelUserGender;

//  保存用户的mobile
- (void)saveUserMobile:(NSString *)mobile;
- (NSString *)getUserMobile;
- (void)canceelUserMobile;

//  保存用户的username
- (void)saveUserName:(NSString *)name;
- (NSString *)getUserName;
- (void)canceelUserName;

//  保存用户的sign个人简介
- (void)saveUserSign:(NSString *)sign;
- (NSString *)getUserSign;
- (void)cancelUserSign;

//// 保存用户的作品
//- (void)saveUserWorks:(NSArray *)works;
//- (NSString *)getUserWorks;
//- (void)cancelUserWorks;

//  用户token
- (void)saveUserToken:(NSString *)token;
- (NSString *)getUserToken;
- (void)cancelUserToken;

@end

