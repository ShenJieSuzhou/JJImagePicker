//
//  CustomSlider.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSlider : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIColor *jjColor;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UISlider *jjSlider;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title color:(UIColor *)color;

- (void)setJJSliderValue:(CGFloat *)value;

@end
