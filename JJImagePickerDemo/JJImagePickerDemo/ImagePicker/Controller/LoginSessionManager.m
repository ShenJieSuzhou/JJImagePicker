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

static LoginSessionManager *mInstance = nil;

@implementation LoginSessionManager
@synthesize delegate = _delegate;

+ (LoginSessionManager *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mInstance = [[LoginSessionManager alloc] init];
    });
    return mInstance;
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
            [weakSelf.delegate networkError];
        }else{
            [weakSelf.delegate tokenVerifySuccessful];
        }
    }];
}


@end
