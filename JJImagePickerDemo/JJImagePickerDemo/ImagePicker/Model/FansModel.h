//
//  FansModel.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/28.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansModel : NSObject

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *iconUrl;

- (instancetype)initWithUser:(NSString *)userid name:(NSString *)userName iconUrl:(NSString *)iconUrl;

@end

