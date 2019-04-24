//
//  PushuUtil.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/24.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushUtil : NSObject

//设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime;

//设置推送延时时间，内容
+ (void) scheduleLocalNotification:(NSInteger)delayTime
                          userInfo:(NSDictionary *)userInfo;
//设置定时推送
+  (void)registerLocalNotification;

/** 删除全部通知*/
+ (void)removeAllLocalNotifications;

/** 通知授权*/
+ (void)authLocalNotifition;

@end

