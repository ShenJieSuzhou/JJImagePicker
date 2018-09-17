//
//  CustomSlider.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSliderDelegate <NSObject>

- (void)customSliderValueChangeCallBacK:(float)value;

@end

@interface CustomSlider : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIColor *jjColor;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UISlider *jjSlider;

@property (nonatomic, weak) id<CustomSliderDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title color:(UIColor *)color;

- (void)setJJSliderTitle:(NSString *)title;

- (void)setJJSliderValue:(float)value;

@end
