//
//  DetailInfoView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "DetailInfoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation DetailInfoView
@synthesize backgroundView = _backgroundView;
@synthesize iconView = _iconView;
@synthesize settingBtn = _settingBtn;
@synthesize delegate = _delegate;
@synthesize userName = _userName;
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
    [_iconView.layer setCornerRadius:8.0f];
    [_iconView.layer setMasksToBounds:YES];
    [self addSubview:_iconView];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setBackgroundImage:[UIImage imageNamed:@"UserSetting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];
    
    _userName = [[UILabel alloc] init];
    [_userName setTextColor:[UIColor whiteColor]];
    [_userName setFont:[UIFont fontWithName:@"Verdana" size:16.0f]];
    [_userName setText:@"------"];
    [self addSubview:_userName];
    
    _foucsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_foucsBtn setTitle:@"关注 0" forState:UIControlStateNormal];
    [_foucsBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_foucsBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_foucsBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_foucsBtn addTarget:self action:@selector(clickToFocusV:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_foucsBtn];
    
    _fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fansBtn setTitle:@"粉丝 0" forState:UIControlStateNormal];
    [_fansBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_fansBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_fansBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_fansBtn addTarget:self action:@selector(clickToFansV:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fansBtn];
    
    
    [self setLoginState:NO];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backgroundView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80.0f, 80.0f));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(40.0f);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180.0f, 30.0f));
        make.left.equalTo(self.iconView.mas_right).offset(20.0f);
        make.top.equalTo(self.iconView);
    }];
    
    [_foucsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 40.0f));
        make.left.equalTo(self.iconView.mas_right).offset(20.0f);
        make.bottom.equalTo(self.iconView);
    }];
    
    [_fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 40.0f));
        make.left.equalTo(self.foucsBtn.mas_right).offset(20.0f);
        make.bottom.equalTo(self.iconView);
    }];
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20.0f);
    }];
}

- (void)setLoginState:(BOOL)isLogin{
//    if(!isLogin){
//        [_loginBtn setHidden:NO];
//        [_userName setHidden:YES];
//    }else{
//        [_loginBtn setHidden:YES];
//        [_userName setHidden:NO];
//    }
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
//    [_delegate clickToLoginCallback];
}

- (void)clickToFocusV:(UIButton *)sender{
    
}

- (void)clickToFansV:(UIButton *)sender{
    
}

@end
