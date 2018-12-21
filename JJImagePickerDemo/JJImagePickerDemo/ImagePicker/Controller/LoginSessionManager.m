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

@implementation LoginSessionManager

+ (LoginSessionManager *)getInstance{
    
}

+ (BOOL)isUserLogin{
    
    if(![JJTokenManager getToken]){
        return NO;
    }
    
    return YES;
}

+ (void)verifyUserToken{
    LoginModel *userModel = [JJTokenManager getToken];
    NSString *token = userModel.token;
    
    [HttpRequestUtil JJ_VerifyLoginToken:@"" token:token callback:^(NSDictionary *data, NSError *error) {
        
    }];
}


@end
