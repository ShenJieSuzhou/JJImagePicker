//
//  LoginModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (instancetype)initWithName:(NSString *)uid name:(NSString *)userName token:(NSString *)token{
    self = [super init];
    if(self){
        self.userId = uid;
        self.userName = userName;
        self.token = token;
    }
    
    return self;
}

@end
