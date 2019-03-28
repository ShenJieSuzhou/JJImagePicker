//
//  HomeTopView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomeTopView.h"
#import <Masonry/Masonry.h>

@implementation HomeTopView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1]];
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_titleLabel setText:@"发现"];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:30.0f]];
    [self addSubview:_titleLabel];
}

- (void)layoutSubviews{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200.0f, 30.0f));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
    }];
}

@end
