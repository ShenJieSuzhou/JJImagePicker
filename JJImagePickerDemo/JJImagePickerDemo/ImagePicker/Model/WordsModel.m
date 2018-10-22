//
//  WordsModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/22.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WordsModel.h"

@implementation WordsModel
@synthesize words = _words;
@synthesize font = _font;
@synthesize color = _color;

- (void)setFont:(UIFont *)font{
    _font = font;
}

- (void)setColor:(UIColor *)color{
    _color = color;
}

- (void)setWords:(NSString *)words{
    _words = words;
}

@end
