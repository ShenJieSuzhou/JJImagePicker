//
//  CustomSlider.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider

@synthesize title = _title;
@synthesize titleLabel = _titleLabel;
@synthesize jjSlider = _jjSlider;
@synthesize jjColor = _jjColor;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title color:(UIColor *)color{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlizationTitle:title color:color];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlizationTitle:(NSString *)title color:(UIColor *)color{
    _title = title;
    _jjColor = color;
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFont:[UIFont fontWithName:@"Verdana" size:14.0f]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setText:_title];
    [self addSubview:self.titleLabel];
    
    self.jjSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    self.jjSlider.minimumValue = 0.0f;
    self.jjSlider.maximumValue = 100.0f;
    self.jjSlider.value = 50.0f;
    [self.jjSlider setContinuous:YES];
    self.jjSlider.minimumTrackTintColor = color;
    self.jjSlider.maximumTrackTintColor = [UIColor whiteColor];
    self.jjSlider.thumbTintColor = [UIColor whiteColor];
    [self.jjSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.jjSlider];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    [self.titleLabel setFrame:CGRectMake(20, 10, 40, 40)];
    [self.jjSlider setFrame:CGRectMake(70, 10, size.width - 90, 40)];
}

- (void)setJJSliderTitle:(NSString *)title{
    [self.titleLabel setText:title];
}

- (void)setJJSliderValue:(float)value{
    self.jjSlider.value = value;
}

-(void)sliderValueChanged:(UISlider *)slider
{
    if(![_delegate respondsToSelector:@selector(customSliderValueChangeCallBacK:)]){
        return;
    }

    [_delegate customSliderValueChangeCallBacK:slider.value];
}

@end
