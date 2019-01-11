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

+ (JJTokenManager *)shareInstance {
    static JJTokenManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JJTokenManager alloc] init];
    });
    return manager;
}

//  保存用户的username
- (void)saveUserName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//  获取用户的username
- (NSString *)getUserName {
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    if (!name) {
        return @"游客";
    }
    return name;
}
//  取消用户username
- (void)cancelUserName {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUserPassword:(NSString *)pwd{
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"UserPwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getPassword{
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPwd"];
    if (!pwd) {
        return @"";
    }
    return pwd;
}

-(void)cancelPassword{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserPwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的id
- (void)saveUserID:(NSNumber *)userID {
    [[NSUserDefaults standardUserDefaults] setObject:userID.stringValue forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserID {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
    if (!userID) {
        return @"";
    }
    return userID;
}
- (void)cancelUserID {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户avatar头像
- (void)saveUserAvatar:(NSString *)avatar {
    [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"UserAvatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserAvatar {
    NSString *avatar = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAvatar"];
    if (!avatar) {
        return @"";
    }
    return avatar;
}
- (void)cancelUserAvatar {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserAvatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的gender
- (void)saveUserGender:(NSNumber *)gender {
    [[NSUserDefaults standardUserDefaults] setObject:gender.stringValue forKey:@"UserGender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserGender {
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserGender"];
    if (!gender) {
        return @"蒙面侠";
    }
    return gender;
}
- (void)cancelUserGender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserGender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUserBirth:(NSString *)birth{
    [[NSUserDefaults standardUserDefaults] setObject:birth forKey:@"UserBirth"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserBirth{
    NSString *birth = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserBirth"];
    if (!birth) {
        return @"1970-01-01";
    }
    return birth;
}

- (void)cancelUserBirth{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserBirth"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的mobile
- (void)saveUserMobile:(NSString *)mobile {
    [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"UserMobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserMobile {
    NSString *mobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserMobile"];
    if (!mobile) {
        return @"";
    }
    return mobile;
}
- (void)cancelUserMobile {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserMobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//  保存用户的sign个人简介
- (void)saveUserSign:(NSString *)sign {
    [[NSUserDefaults standardUserDefaults] setObject:sign forKey:@"UserSign"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserSign {
    NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSign"];
    if (!sign) {
        return @"";
    }
    return sign;
}
- (void)cancelUserSign {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserSign"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//  用户token
- (void)saveUserToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"UserToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserToken"];
    if (!token) {
        return @"";
    }
    return token;
}
- (void)cancelUserToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  用户关注
- (void)saveFocusPlayerNum:(NSString *)focus{
    [[NSUserDefaults standardUserDefaults] setObject:focus forKey:@"Focus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getFocusPlayerNum{
    NSString *focus = [[NSUserDefaults standardUserDefaults] objectForKey:@"Focus"];
    if (!focus) {
        return @"";
    }
    return focus;
}

- (void)cancelFocusPlayerNum{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Focus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

////  用户粉丝
- (void)saveUserFans:(NSString *)fans{
    [[NSUserDefaults standardUserDefaults] setObject:fans forKey:@"Fans"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserFans{
    NSString *focus = [[NSUserDefaults standardUserDefaults] objectForKey:@"Fans"];
    if (!focus) {
        return @"";
    }
    return focus;
}

- (void)cancelUserFans{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Fans"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//  移除所有用户信息
- (void)removeAllUserInfo {
    [self cancelUserID];
    [self cancelUserSign];
    [self cancelUserName];
    [self cancelUserAvatar];
    [self cancelUserGender];
    [self cancelUserMobile];
    [self cancelUserToken];
    [self cancelPassword];
    [self cancelUserBirth];
}

//  添加用户信息
- (void)setUserLoginInfo:(LoginModel *)info{
    [self saveUserName:info.userName];
    [self saveUserAvatar:info.iconUrl];
    [self saveUserID:info.userId];
    [self saveUserGender:[NSNumber numberWithInt:info.gender]];
    [self saveUserMobile:info.telephone];
    [self saveUserToken:info.token];
    [self saveUserFans:info.fans];
    [self saveFocusPlayerNum:info.focus];
}

@end
