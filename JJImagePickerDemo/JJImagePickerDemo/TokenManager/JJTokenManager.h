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

////  添加用户信息
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
- (NSString *)getUserAvatar;
- (void)cancelUserAvatar;

//  保存用户作品
- (void)saveUserWorks:(NSMutableArray *)works;
- (NSMutableArray *)getUserWorks;
- (void)cancelUserWorks;


//  保存用户的gender
- (void)saveUserGender:(NSNumber *)gender;
- (NSString *)getUserGender;
- (void)cancelUserGender;

//  保存用户的mobile
- (void)saveUserMobile:(NSString *)mobile;
- (NSString *)getUserMobile;
- (void)cancelUserMobile;

//  保存用户的username
- (void)saveUserName:(NSString *)name;
- (NSString *)getUserName;
- (void)cancelUserName;

//  保存用户的密码
- (void)saveUserPassword:(NSString *)pwd;
- (NSString *)getPassword;
- (void)cancelPassword;

//  保存用户的sign个人简介
- (void)saveUserSign:(NSString *)sign;
- (NSString *)getUserSign;
- (void)cancelUserSign;

//// 保存用户的生日
- (void)saveUserBirth:(NSString *)birth;
- (NSString *)getUserBirth;
- (void)cancelUserBirth;

//  用户token
- (void)saveUserToken:(NSString *)token;
- (NSString *)getUserToken;
- (void)cancelUserToken;

//  用户关注
- (void)saveFocusPlayerNum:(NSString *)focus;
- (NSString *)getFocusPlayerNum;
- (void)cancelFocusPlayerNum;

////  用户粉丝
- (void)saveUserFans:(NSString *)fans;
- (NSString *)getUserFans;
- (void)cancelUserFans;

// 微信登录Token
- (void)saveWechatToken:(NSString *)token;
- (NSString *)getWechatToken;
- (void)cancelWechatToken;

//微信登录openid
- (void)saveWechatOpenID:(NSString *)openid;
- (NSString *)getWechatOpenID;
- (void)cancelWechatOpenID;

// 微信登录 refresh_Token
- (void)saveWechatRefreshtoken:(NSString *)refreshToken;
- (NSString *)getWechatRefreshtoken;
- (void)cancelWechatRefreshtoken;

// 登录方式
- (void)saveLoginType:(int)type;
- (int)getLoginType;
- (void)cancelLoginType;

@end

