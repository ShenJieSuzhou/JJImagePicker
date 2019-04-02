//
//  JJDataParaseUtil.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/2.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJDataParaseUtil.h"

@implementation JJDataParaseUtil

+ (NSString*)getDataAsString:(id)data
{
    if ([data isKindOfClass:[NSString class]]) {
        return data;
    }
    else if([data isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@", data];
    }
    return nil;
}

+ (BOOL) getDataAsBool:(id)data
{
    if ([data isKindOfClass:[NSNumber class]] ||[data isKindOfClass:[NSString class]]) {
        return [data boolValue];
    }
    return FALSE;
}

+ (int) getDataAsInt:(id)data
{
    if ([data isKindOfClass:[NSNumber class]] ||[data isKindOfClass:[NSString class]]) {
        return [data intValue];
    }
    return 0;
}

+ (long) getDataAsLong:(id)data
{
    if ([data isKindOfClass:[NSNumber class]] ||[data isKindOfClass:[NSString class]]) {
        return (long)[data longLongValue];
    }
    return 0;
}

+ (float) getDataAsFloat:(id)data
{
    if ([data isKindOfClass:[NSNumber class]] ||[data isKindOfClass:[NSString class]]) {
        return [data floatValue];
    }
    return 0.0f;
}
+ (double) getDataAsDouble:(id)data
{
    if ([data isKindOfClass:[NSNumber class]] ||[data isKindOfClass:[NSString class]]) {
        return [data doubleValue];
    }
    return 0.0f;
}

+ (NSDate*) getDataAsDate:(id)data
{
    if ([data isKindOfClass:[NSDate class]]) {
        return [data date];
    }
    else if([data isKindOfClass:[NSString class]]){
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter dateFromString:data];
    }
    else if([data isKindOfClass:[NSNumber class]]){
        return [[NSDate alloc] initWithTimeIntervalSince1970:[data doubleValue]/1000];
    }
    return nil;
}

+ (NSData*) toJSONData:(id)data
{
    if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        if ([jsonData length] > 0 && !error)
        {
            return jsonData;
        }
    }
    return nil;
}


+ (NSString*) toJSONString:(id)data
{
    if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        if ([jsonData length] > 0 && !error)
        {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

+ (int) getDateAsAge:(NSDate*)date
{
    if (![date isKindOfClass:[NSDate class]]) {
        return 0;
    }
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return (int)iAge;
}

@end
