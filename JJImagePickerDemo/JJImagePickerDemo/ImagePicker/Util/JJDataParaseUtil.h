//
//  JJDataParaseUtil.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/2.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJDataParaseUtil : NSObject

+ (NSString*)getDataAsString:(id)data;
+ (BOOL) getDataAsBool:(id)data;
+ (int) getDataAsInt:(id)data;
+ (long) getDataAsLong:(id)data;
+ (float) getDataAsFloat:(id)data;
+ (double) getDataAsDouble:(id)data;
+ (NSDate*) getDataAsDate:(id)data;
+ (NSData*) toJSONData:(id)data;
+ (NSString*) toJSONString:(id)data;
+ (int) getDateAsAge:(NSDate*)date;

@end

