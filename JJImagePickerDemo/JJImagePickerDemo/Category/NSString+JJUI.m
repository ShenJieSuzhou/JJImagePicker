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

+ (NSArray *)stringToJSON:(NSString *)jsonStr {
    if(jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                return tmp;
            } else if([tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSDictionary class]]) {
                return [NSArray arrayWithObject:tmp];
            } else {
                return nil;
                
            }
            
        } else {
            return nil;
            
        }
    } else {
        return nil;
    }
}

@end
