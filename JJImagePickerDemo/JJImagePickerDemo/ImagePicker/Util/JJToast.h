//
//  JJToast.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/13.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

typedef NS_ENUM(NSInteger, WToastDuration) {
    kWTShort = 1,
    kWTLong = 5
};

typedef NS_ENUM(NSInteger, WToastGravity) {
    kWTGravityBottom = 0,
    kWTGravityMiddle = 1,
    kWTGravityTop = 2
};


@interface JJToast : UIView

+ (void)showWithText:(NSString *)text;
+ (void)showWithImage:(UIImage *)image;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners;

+ (void)showWithText:(NSString *)text gravity:(WToastGravity)gravity;
+ (void)showWithImage:(UIImage *)image gravity:(WToastGravity)gravity;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration gravity:(WToastGravity)gravity;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration gravity:(WToastGravity)gravity;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners gravity:(WToastGravity)gravity;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners gravity:(WToastGravity)gravity;

+ (void)hideToast;
+ (void)hideToastAnimated:(BOOL)animated;

@end
