//
//  JJPublicText.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPublicText.h"

@implementation JJPublicText
@synthesize publishText = _publishText;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    //添加图片视图
    _publishText = [[UITextView alloc] init];
    _publishText.placeholder = @"这一刻的想法...";
    _publishText.placeholderColor = [UIColor lightGrayColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_publishText setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
