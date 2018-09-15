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
    [self.titleLabel setFont:[UIFont fontWithName:@"Verdana" size:11.0f]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setText:_title];
    [self addSubview:self.titleLabel];
    
    self.jjSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self addSubview:self.jjSlider];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    

}

- (void)setJJSliderValue:(CGFloat *)value{
    
}

@end
