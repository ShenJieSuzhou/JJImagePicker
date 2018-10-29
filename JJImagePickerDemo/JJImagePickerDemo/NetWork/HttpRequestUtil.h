//
//  HttpRequestUtil.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

typedef void(^requestCallBack)(NSDictionary *data);

@interface HttpRequestUtil : NSObject

+ (void)JJ_RequestTHeData:(NSString *)url callback:(requestCallBack) block;

@end
