//
//  JJLikeButton.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/28.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJLikeButton : UIButton

/** 圆圈颜色 */
@property (nonatomic , strong ) UIColor *circleColor;

/** 线条颜色 */
@property (nonatomic , strong ) UIColor *lineColor;

//========================

/** 选中图片颜色 */
@property (nonatomic , strong ) UIColor *imageColorOn;

/** 未选中图片颜色 */
@property (nonatomic , strong ) UIColor *imageColorOff;

//== 图片 与 图片颜色二选一 ==

/** 选中图片 */
@property (nonatomic , strong ) UIImage *imageOn;

/** 未选中图片 */
@property (nonatomic , strong ) UIImage *imageOff;

//========================

/** 动画时长 */
@property (nonatomic , assign ) double duration;

@property (nonatomic , strong ) CAShapeLayer *circleShape;

@property (nonatomic , strong ) CAShapeLayer *circleMask;

@property (nonatomic , strong ) CAShapeLayer *imageShape;

@property (nonatomic , strong ) CALayer *imageLayer;

@property (nonatomic , strong ) NSMutableArray *lineArray;

/**
 *  初始化炫酷按钮
 *
 *  @param image      图片
 *  @param imageFrame 图片frame
 *
 *  @return 按钮对象
 */
+ (id)coolButtonWithImage:(UIImage *)image ImageFrame:(CGRect)imageFrame;

/**
 *  选中
 */
- (void)select;

/**
 *  未选中
 */
- (void)deselect;

@end

