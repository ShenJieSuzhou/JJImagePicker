//
//  JJLoadConfig.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJLoadConfig : NSObject

+ (JJLoadConfig *)getInstance;

- (NSDictionary *)getCustomContent;

@end