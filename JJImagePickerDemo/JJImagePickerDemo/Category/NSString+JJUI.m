//
//  NSString+JJUI.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "NSString+JJUI.h"

@implementation NSString (JJUI)

+ (NSString *)jj_timeStringWithMinsAndSecsFromSecs:(double)seconds{
    NSUInteger min = floor(seconds / 60);
    NSUInteger sec = floor(seconds - min * 60);
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)min, (long)sec];
}

@end
