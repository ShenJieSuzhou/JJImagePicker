//
//  JJImagePickerHelper.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JJImagePickerHelper : NSObject

/**
 *  图片 checkBox 被选中时的动画
 *  @warning iOS6 下降级处理不调用动画效果
 *
 *  @param button 需要做动画的 checkbox 按钮
 */
+ (void)actionSpringAnimationForView:(UIView *)view;

/**
 * 搭配 actionSpringAnimationForView 添加animation之前建议先remove
 */
+ (void)removeactionSpringAnimationForView:(UIView *)view;

/**
 * 菊花 loading 动画
 */
+ (void)startLoadingAnimation:(UIViewController *)baseView;

/**
 * 关闭 菊花 loading 动画
 */
+ (void)stopLoadingAnimation:(UIViewController *)baseView;

@end
