//
//  DetailInfoView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "DetailInfoView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define DETAIL_HEIGTH 180.0f


@implementation DetailInfoView
@synthesize backgroundView = _backgroundView;
@synthesize iconView = _iconView;
@synthesize settingBtn = _settingBtn;
@synthesize delegate = _delegate;
@synthesize userName = _userName;
@synthesize loginBtn = _loginBtn;
@synthesize foucsBtn = _foucsBtn;
@synthesize fansBtn = _fansBtn;

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
    [_iconView setBackgroundImage:[UIImage imageNamed:@"userPlaceHold"] forState:UIControlStateNormal];
    [_iconView addTarget:self action:@selector(pickUpHeaderImg:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_iconView];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_settingBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_settingBtn addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
    [_loginBtn.titleLabel setTextColor:[UIColor blackColor]];
    [_loginBtn addTarget:self action:@selector(clickToLoginV:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    
    _userName = [[UILabel alloc] init];
    [_userName setTextColor:[UIColor blackColor]];
    [_userName setFont:[UIFont fontWithName:@"Verdana" size:16.0f]];
    [self addSubview:_userName];
    
    _foucsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_foucsBtn setTitle:@"关注 0" forState:UIControlStateNormal];
    [_foucsBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_foucsBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_foucsBtn addTarget:self action:@selector(clickToFocusV:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_foucsBtn];
    
    _fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fansBtn setTitle:@"粉丝 0" forState:UIControlStateNormal];
    [_fansBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_fansBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_fansBtn addTarget:self action:@selector(clickToFansV:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fansBtn];
    
    
    [self setLoginState:NO];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backgroundView setFrame:CGRectMake(0, 0, self.frame.size.width, DETAIL_HEIGTH)];
    [_iconView setFrame:CGRectMake(40.0f, DETAIL_HEIGTH - 100.0f, 80.0f, 80.0f)];
    [_settingBtn setFrame:CGRectMake(self.frame.size.width - 100.0f, 20.0f, 80.0f, 60.0f)];
    [_loginBtn setFrame:CGRectMake(120.0f, DETAIL_HEIGTH - 80.0f, 120.0f, 40.0f)];
    [_userName setFrame:CGRectMake(130.0f, DETAIL_HEIGTH - 80.0f, 120.0f, 40.0f)];
    [_foucsBtn setFrame:CGRectMake(140.0f, DETAIL_HEIGTH - 50.0f, 50.0f, 40.0f)];
    [_fansBtn setFrame:CGRectMake(200.0f, DETAIL_HEIGTH - 50.0f, 50.0f, 40.0f)];
}

- (void)setLoginState:(BOOL)isLogin{
    if(!isLogin){
        [_loginBtn setHidden:NO];
        [_userName setHidden:YES];
    }else{
        [_loginBtn setHidden:YES];
        [_loginBtn setHidden:NO];
    }
}

- (void)updateViewInfo:(NSString *)iconurl name:(NSString *)name focus:(NSString *)focusNum fans:(NSString *)fansNum{
    
    [_iconView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl]]] forState:UIControlStateNormal];
    [_userName setText:name];
    [_foucsBtn setTitle:[NSString stringWithFormat:@"关注 %@", focusNum] forState:UIControlStateNormal];
    [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝 %@", fansNum] forState:UIControlStateNormal];
}


- (void)pickUpHeaderImg:(UIButton *)sender{
    [_delegate pickUpHeaderImgCallback];
}

- (void)clickSetting:(UIButton *)sender{
    [_delegate appSettingClickCallback];
}

- (void)clickToLoginV:(UIButton *)sender{
    [_delegate clickToLoginCallback];
}

- (void)clickToFocusV:(UIButton *)sender{
    
}

- (void)clickToFansV:(UIButton *)sender{
    
}

@end
