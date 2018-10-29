//
//  HomeContentmManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeContentmManager : NSObject

+ (HomeContentmManager *)shareInstance;

- (void)setHomeContent:(NSDictionary *)dic;

- (NSMutableArray *)getHomeContent;

@end


