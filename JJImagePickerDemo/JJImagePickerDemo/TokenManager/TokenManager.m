//
//  TokenManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "TokenManager.h"

@implementation TokenManager
static TokenManager *m_instance = nil;

+ (TokenManager *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[TokenManager alloc] init];
    });
    
    return m_instance;
}

- (void)saveLoginInfo:(LoginModel *)loginModel{
 
    
}

- (LoginModel *)getLoginInfo{
    
    return nil;
}

@end
