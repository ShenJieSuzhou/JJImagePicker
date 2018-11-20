//
//  DetailInfoView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "DetailInfoView.h"
#define DETAIL_HEIGTH 180.0f


@implementation DetailInfoView
@synthesize backgroundView = _backgroundView;
@synthesize iconView = _iconView;
@synthesize settingBtn = _settingBtn;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_backgroundView setBackgroundColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f]];
    [self addSubview:_backgroundView];
    
    _iconView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_iconView setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_iconView addTarget:self action:@selector(pickUpHeaderImg:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_iconView];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_settingBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_settingBtn addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backgroundView setFrame:CGRectMake(0, 0, self.frame.size.width, DETAIL_HEIGTH)];
    [_iconView setFrame:CGRectMake(40.0f, DETAIL_HEIGTH - 100.0f, 80.0f, 80.0f)];
    [_settingBtn setFrame:CGRectMake(self.frame.size.width - 100.0f, 100.0f, 80.0f, 60.0f)];
}

- (void)pickUpHeaderImg:(UIButton *)sender{
    [_delegate pickUpHeaderImgCallback];
}

- (void)clickSetting:(UIButton *)sender{
    [_delegate appSettingClickCallback];
}

@end
