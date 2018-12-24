//
//  LoginSessionManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginSessionManager.h"
#import "JJTokenManager.h"
#import "HttpRequestUtil.h"
#import "JSONKit.h"

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
        
        if([[data objectForKey:@"errorCode"] isEqualToString:@"0"]){
            NSString *uid = [data objectForKey:@"user_id"];
            NSString *userName = [data objectForKey:@"userName"];
            NSString *token = [data objectForKey:@"token"];
            NSString *result = [data objectForKey:@"result"];
            NSString *works = [data objectForKey:@"works"];
            
            //字符串解析成数组
            NSArray *workList = [[works substringWithRange:NSMakeRange(1, works.length - 1)] componentsSeparatedByString:@","];
            
            //取出token user_id username
            LoginModel *userModel = [[LoginModel alloc] initWithName:uid name:userName icon:@"" focus:@"" fans:@"" token:token works:workList];
            [JJTokenManager saveToken:userModel];
            [weakSelf.delegate loginByAccountPwdSuccessful:userModel];
        }else{
            NSString *errorMsg = [data objectForKey:@"errorMsg"];
            [weakSelf.delegate loginByAccountPwdFailed:errorMsg];
        }
    }];
}


- (BOOL)isUserLogin{
    if(![JJTokenManager getToken]){
        return NO;
    }
    
    return YES;
}

- (void)verifyUserToken{
    LoginModel *userModel = [JJTokenManager getToken];
    NSString *token = userModel.token;
    
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_VerifyLoginToken:@"" token:token callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [weakSelf.delegate networkError:error];
        }else{
            NSString *result = [data objectForKey:@"result"];
            if([result isEqualToString:@"1"]){
                [weakSelf.delegate tokenVerifySuccessful];
            }else if([result isEqualToString:@"0"]){
                NSString *errorMsg = [data objectForKey:@"errorMsg"];
                [weakSelf.delegate tokenVerifyError:errorMsg];
            }
        }
    }];
}

- (void)setUserInfo:(LoginModel *)model{
    self.userModel = model;
}

- (LoginModel *)getUserModel{
    return self.userModel;
}


@end
