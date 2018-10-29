//
//  HttpRequestUtil.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "HttpRequestUtil.h"
#import <AFNetwork/AFNetwork.h>

@implementation HttpRequestUtil

+ (void)JJ_RequestTHeData:(NSString *)url callback:(requestCallBack) block{
    
//    [[AFNetwork shareManager] requestWithMethod:GET url:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
//        block(dict);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    [[AFNetwork shareManager] requestURL:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        block(dict);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

@end
