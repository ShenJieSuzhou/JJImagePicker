//
//  LoginSessionManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginSessionManager.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"
#import "HttpRequestUtil.h"
#import "JSONKit.h"
#import "NSString+JJUI.h"

static LoginSessionManager *mInstance = nil;

@implementation LoginSessionManager
@synthesize delegate = _delegate;
@synthesize userModel = _userModel;

+ (LoginSessionManager *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mInstance = [[LoginSessionManager alloc] init];
    });
    return mInstance;
}

- (void)loginByAccountPwd:(NSString *)url account:(NSString *)account pwd:(NSString *)password{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_LoginByAccountPwd:url account:account pwd:password callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [weakSelf.delegate networkError:error];
            return;
        }
        
        if(!data){
            //登录失败
            [weakSelf.delegate dataOccurError:@"登录失败,网络异常"];
            return;
        }
        
        if([[data objectForKey:@"errorCode"] isEqualToString:@"1"]){
            NSString *uid = [data objectForKey:@"user_id"];
            NSString *userName = [data objectForKey:@"userName"];
            NSString *token = [data objectForKey:@"token"];
            NSArray *works = [data objectForKey:@"works"];
            NSString *fans = [data objectForKey:@"fans"];
            NSString *foucs = [data objectForKey:@"focus"];
            NSString *iconUrl = [data objectForKey:@"iconUrl"];
            int gender = [[data objectForKey:@"genda"] intValue];
            NSString *birth = [data objectForKey:@"birth"];
            NSString *phone = [data objectForKey:@"telephone"];
            
            //取出token user_id username
            LoginModel *userModel = [[LoginModel alloc] initWithName:uid name:userName icon:iconUrl focus:foucs fans:fans gender:gender birth:birth phone:phone token:token works:[NSMutableArray arrayWithArray:works]];
            [weakSelf.delegate loginByAccountPwdSuccessful:userModel];
        }else{
            NSString *errorMsg = [data objectForKey:@"errorMsg"];
            [weakSelf.delegate loginByAccountPwdFailed:errorMsg];
        }
    }];
}

- (BOOL)isUserLogin{
    if([[JJTokenManager shareInstance] getUserToken].length == 0){
        return NO;
    }
    
    return YES;
}

- (void)verifyUserToken{
    NSString *token = [[JJTokenManager shareInstance] getUserToken];
    NSString *userID = [[JJTokenManager shareInstance] getUserID];
    
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_VerifyLoginToken:VERIFY_TOKEN_REQUEST token:token userid:userID callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [weakSelf.delegate networkError:error];
        }else{
            NSString *result = [data objectForKey:@"result"];
            if([result isEqualToString:@"1"]){
                [weakSelf.delegate tokenVerifySuccessful];
            }else if([result isEqualToString:@"0"]){
                //清除token
                [[JJTokenManager shareInstance] removeAllUserInfo];
                NSString *errorMsg = [data objectForKey:@"errorMsg"];
                [weakSelf.delegate tokenVerifyError:errorMsg];
            }
        }
    }];
}

//- (void)setUserInfo:(LoginModel *)model{
//    self.userModel = model;
//}
//
//- (LoginModel *)getUserModel{
//    return self.userModel;
//}


@end
