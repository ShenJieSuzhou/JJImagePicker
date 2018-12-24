//
//  LoginModel.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSArray *worksArray;

@property (nonatomic, strong) NSString *iconUrl;

@property (nonatomic, strong) NSString *focus;

@property (nonatomic, strong) NSString *fans;

- (instancetype)initWithName:(NSString *)uid name:(NSString *)userName icon:(NSString *)iconUrl focus:(NSString *)focus fans:(NSString *)fans token:(NSString *)token works:(NSArray *)works;

@end


