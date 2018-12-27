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

//  保存用户的id
- (void)saveUserID:(NSNumber *)userID {
    [[NSUserDefaults standardUserDefaults] setObject:userID.stringValue forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserID {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
    if (!userID) {
        return @" ";
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
- (NSString *)gettUserAvatar {
    NSString *avatar = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAvatar"];
    if (!avatar) {
        return @" ";
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
        return @" ";
    }
    return gender;
}
- (void)cancelUserGender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserGender"];
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
        return @" ";
    }
    return mobile;
}
- (void)canceelUserMobile {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserMobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的height
- (void)saveUserHeight:(NSString *)height {
    [[NSUserDefaults standardUserDefaults] setObject:height forKey:@"UserHeight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserHeight {
    NSString *height = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserHeight"];
    if (!height) {
        return @" ";
    }
    return height;
}
- (void)cancelUserHeight {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserHeight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的weight
- (void)saveUserWeight:(NSString *)weight {
    [[NSUserDefaults standardUserDefaults] setObject:weight forKey:@"UserWeight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserWeight {
    NSString *weight = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserWeight"];
    if (!weight) {
        return @" ";
    }
    return weight;
}
- (void)cancelUserWeight {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserWeight"];
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
        return @" ";
    }
    return sign;
}
- (void)cancelUserSign {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserSign"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的createTime
- (void)saveUserCreateTime:(NSNumber *)createTime {
    [[NSUserDefaults standardUserDefaults] setObject:createTime.stringValue forKey:@"UserCreateTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserCreateTime {
    NSString *createTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserCreateTime"];
    if (!createTime) {
        return @" ";
    }
    return createTime;
}
- (void)cancelUserCreateTime {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserCreateTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  保存用户的trainGoal训练目的
- (void)saveUserTrainGoal:(NSString *)trainGoal {
    [[NSUserDefaults standardUserDefaults] setObject:trainGoal forKey:@"UserTrainGoal"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserTrainGoal {
    NSString *trainGoal = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserTrainGoal"];
    if (!trainGoal) {
        return @" ";
    }
    return trainGoal;
}
- (void)cancelUserTrainGoal {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserTrainGoal"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  训练基础
- (void)saveUserTrainBase:(NSString *)trainBase {
    [[NSUserDefaults standardUserDefaults] setObject:trainBase forKey:@"UserTrainBase"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserTrainBase {
    NSString *trainBase = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserTrainBase"];
    if (!trainBase) {
        return @" ";
    }
    return trainBase;
}
- (void)cancelUserTrainBase {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserTrainBase"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  训练频率
- (void)saveUserTrainFrequency:(NSString *)trainFrequency {
    [[NSUserDefaults standardUserDefaults] setObject:trainFrequency forKey:@"UserTrainFrequency"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserTrainFrequency {
    NSString *trainFrequency = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserTrainFrequency"];
    if (!trainFrequency) {
        return @" ";
    }
    return trainFrequency;
}
- (void)cancelUserTrainFrequency {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserTrainFrequency"];
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

//  移除所有用户信息
- (void)removeAllUserInfo {
    [self cancelUserID];
    [self cancelUserSign];
    [self canceelUserName];
    [self cancelUserAvatar];
    [self cancelUserGender];
//    [self cancelUserHeight];
//    [self cancelUserWeight];
    [self canceelUserMobile];
//    [self cancelUserCreateTime];
//    [self cancelUserTrainBase];
//    [self cancelUserTrainGoal];
//    [self cancelUserTrainFrequency];
    [self cancelUserToken];
}

//  添加用户信息
- (void)setUserInfoWithDic:(LoginModel *)info {
    [self saveUserName:info.userName];
    [self saveUserAvatar:info.iconUrl];
    [self saveUserID:info.userId];
//    [self saveUserGender:1];
    [self saveUserMobile:@""];
//    [self saveUserSign:userDic[@"sign"]];
//    [self saveUserTrainBase:userDic[@"trainBase"]];
//    [self saveUserTrainGoal:userDic[@"trainGoal"]];
//    [self saveUserTrainFrequency:userDic[@"trainFrequency"]];
//    [self saveUserWeight:userDic[@"weight"]];
//    [self saveUserHeight:userDic[@"height"]];
    [self saveUserToken:info.token];
}

//// 存储token
//+(void)saveToken:(LoginModel *)token
//{
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    NSData *tokenData;
//    if (@available(iOS 11.0, *)) {
//        NSString *value = [NSString stringWithFormat:@"%@,%@", token.token, token.userId];
//        tokenData = [NSKeyedArchiver archivedDataWithRootObject:value requiringSecureCoding:YES error:nil];
//    } else {
//        // Fallback on earlier versions
//        NSString *value = [NSString stringWithFormat:@"%@,%@", token.token, token.userId];
//        tokenData = [NSKeyedArchiver archivedDataWithRootObject:value];
//    }
//
//    [userDefaults setObject:tokenData forKey:TOKEN_KEY];
//    [userDefaults synchronize];
//}
//
//// 读取token
//+(NSString *)getToken
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *tokenData = [userDefaults objectForKey:TOKEN_KEY];
//    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
//    [userDefaults synchronize];
//    return token;
//}
//
//// 清空token
//+(void)cleanToken
//{
//    NSUserDefaults *UserLoginState = [NSUserDefaults standardUserDefaults];
//    [UserLoginState removeObjectForKey:TOKEN_KEY];
//    [UserLoginState synchronize];
//}
//
//
//// 跟新token
//+(LoginModel *)refreshToken
//{
//    return nil;
//}


@end
