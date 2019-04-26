//
//  AdjustModel.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "AdjustModel.h"

@implementation AdjustModel

- (instancetype)init{
    if(self = [super init]){
        _brightness = 0.0f;
        _skin = 0.0f;
        _exposure = 0.0f;
        _temperature = 6500.0f;
        _contrast = 0.0f;
        _saturation = 0.0f;
        _shape = 0.0f;
        _darkangle = 0.0f;
    }
    return self;
}

@end
