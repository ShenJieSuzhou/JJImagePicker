//
//  TokenManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface TokenManager : NSObject

+ (TokenManager *)getInstance;

- (void)saveLoginInfo:(LoginModel *)loginModel;

- (LoginModel *)getLoginInfo;


@end

