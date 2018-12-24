//
//  LoginModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (instancetype)initWithName:(NSString *)uid name:(NSString *)userName icon:(NSString *)iconUrl focus:(NSString *)focus fans:(NSString *)fans token:(NSString *)token works:(NSArray *)works{
    self = [super init];
    if(self){
        self.userId = uid;
        self.userName = userName;
        self.token = token;
        self.worksArray = works;
        self.iconUrl = iconUrl;
        self.focus = focus;
        self.fans = fans;
    }
    
    return self;
}

@end
