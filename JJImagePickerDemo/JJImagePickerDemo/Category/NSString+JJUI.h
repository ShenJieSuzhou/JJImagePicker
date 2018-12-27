//
//  NSString+JJUI.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JJUI)

/**
 * 将秒数转换为同时包含分钟和秒数的格式的字符串，例如 100->"01:40"
 */
+ (NSString *)jj_timeStringWithMinsAndSecsFromSecs:(double)seconds;

+ (NSArray *)stringToJSON:(NSString *)jsonStr;


@end
