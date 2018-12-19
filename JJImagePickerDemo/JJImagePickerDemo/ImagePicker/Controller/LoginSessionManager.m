//
//  LoginSessionManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginSessionManager.h"
#import "JJTokenManager.h"


@implementation LoginSessionManager

+ (BOOL)isUserLogin{
    
    if(![JJTokenManager getToken]){
        return NO;
    }
    
    return YES;
}

+ (void)verifyUserToken{
    
    
}


@end
