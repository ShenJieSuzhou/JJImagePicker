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

+ (void)JJ_RegisterNewUser:(NSString *)url account:(NSString *)account pwd:(NSString *)pwd callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:account, @"account", pwd, @"pwd", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
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

+ (void)JJ_GetMyWorksArray:(NSString *)url token:(NSString *)token userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {        
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_GetOthersWorksArray:(NSString *)url token:(NSString *)token userid:(NSString *)userid fansid:(NSString *)fansid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", userid, @"user_id", fansid, @"fans_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_PublishMyPhotoWorks:(NSString *)url token:(NSString *)token photoInfo:(NSString *)photoInfo userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", photoInfo, @"photoInfo", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_INCREMENT_LIKECOUNT:(NSString *)url token:(NSString *)token photoId:(NSString *)photoId userid:(NSString *)userid createrID:(NSString *)createrID callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", photoId, @"photoId", userid, @"user_id",  createrID, @"createrID",nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_DECREMENT_LIKECOUNT:(NSString *)url token:(NSString *)token photoId:(NSString *)photoId userid:(NSString *)userid fansid:(NSString *)fansid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", photoId, @"photoId", userid, @"user_id", fansid, @"fans_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_UpdateUserNickName:(NSString *)url token:(NSString *)token name:(NSString *)name userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token",name, @"nickName", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_UpdateUserGender:(NSString *)url token:(NSString *)token gender:(int)gender userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", [NSNumber numberWithInt:gender], @"gender", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_UpdateUserBirth:(NSString *)url token:(NSString *)token birth:(NSString *)birth userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", birth, @"birth", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_UpdateUserAvatar:(NSString *)url token:(NSString *)token avatar:(NSString *)avatar userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", avatar, @"avatar", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_NewUserSetPassword:(NSString *)url token:(NSString *)token pwd:(NSString *)pwd userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", pwd, @"pwd", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_SetUserNewPassword:(NSString *)url token:(NSString *)token oldPwd:(NSString *)oldpwd newPwd:(NSString *)newPwd userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", oldpwd, @"oldpwd", newPwd, @"newPwd",userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_ReqBindPhoneCode:(NSString *)url token:(NSString *)token phone:(NSString *)phone userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", phone, @"phone", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_BindUserPhone:(NSString *)url token:(NSString *)token phone:(NSString *)phone code:(NSString *)code userid:(NSString *)userid callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", phone, @"phone", code, @"code", userid, @"user_id", nil];
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_WechatGetAccessToken:(NSString *)url code:(NSString *)code callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:code, @"code", nil];
    
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}


+ (void)JJ_WechatRefreshToken:(NSString *)url appid:(NSString *)appid grantType:(NSString *)type refreshToken:(NSString *)refreshToken callback:(requestCallBack) block{
    NSString *accessUrlStr = [NSString stringWithFormat:@"%@?appid=%@&grant_type=%@&refresh_token=%@", url, appid, type, refreshToken];
    
    [[AFNetwork shareManager] requestWithMethod:GET url:accessUrlStr params:nil success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
    
}

+ (void)JJ_WechatUserLogin:(NSString *)url openId:(NSString *)openID accessToken:(NSString *)token type:(NSString *)type extend:(NSString *)extend callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"accessToken", openID, @"openId", type, @"type", extend, @"extend" ,nil];
    
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

+ (void)JJ_WechatRegisterUserInfo:(NSString *)url nickName:(NSString *)nickName headImgUrl:(NSString *)headImgUrl callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nickName, @"nickName", headImgUrl, @"headImgUrl", nil];
    
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}


+ (void)JJ_HomePageRquestData:(NSString *)url token:(NSString *)token userid:(NSString *)userid pageIndex:(NSString *)pageIndex callback:(requestCallBack) block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:token, @"token", userid, @"user_id", pageIndex, @"pageIndex", nil];
    
    [[AFNetwork shareManager] requestWithMethod:POST url:url params:params success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

@end
