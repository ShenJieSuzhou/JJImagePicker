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

@synthesize worksNumView = _worksNumView;
@synthesize workTitle = _workTitle;
@synthesize workNum = _workNum;

@synthesize focusView = _focusView;
@synthesize focusTitle = _focusTitle;
@synthesize focusNum = _focusNum;

@synthesize fansTitle = _fansTitle;
@synthesize fansView = _fansView;
@synthesize fansNum = _fansNum;


- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    // 登录成功后显示的控件
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_backgroundView];
    
    _iconView = [[UIImageView alloc] init];
    [_iconView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    [_iconView.layer setMasksToBounds:YES];
    [self addSubview:_iconView];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setBackgroundImage:[UIImage imageNamed:@"UserSetting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];
    
    _userName = [[UILabel alloc] init];
    [_userName setTextColor:[UIColor whiteColor]];
    [_userName setFont:[UIFont fontWithName:@"Verdana" size:16.0f]];
    [_userName setText:@""];
    [self addSubview:_userName];
    
    // 作品
    _worksNumView = [UIView new];
    [_worksNumView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_worksNumView];
    
    _workTitle = [UILabel new];
    [_workTitle setText:@"发布"];
    [_workTitle setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_worksNumView addSubview:_workTitle];
    
    _workNum = [UILabel new];
    [_workNum setText:@"0"];
    [_workNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_worksNumView addSubview:_workNum];
    
    // 关注
    _focusView = [UIView new];
    [_focusView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_focusView];
    
    _focusTitle = [UILabel new];
    [_focusTitle setText:@"关注"];
    [_focusTitle setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_focusView addSubview:_focusTitle];
    
    
    _focusNum = [UILabel new];
    [_focusNum setText:@"0"];
    [_focusNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_focusView addSubview:_focusNum];
    
    // 粉丝
    _fansView = [UIView new];
    [_fansView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_fansView];
    
    _fansTitle = [UILabel new];
    [_fansTitle setText:@"粉丝"];
    [_fansTitle setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_fansView addSubview:_fansTitle];
    
    _fansNum = [UILabel new];
    [_fansNum setText:@"0"];
    [_fansNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_fansView addSubview:_fansNum];
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
    
//    [_foucsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100.0f, 40.0f));
//        make.left.equalTo(self.iconView.mas_right).offset(20.0f);
//        make.bottom.equalTo(self.iconView);
//    }];
//
//    [_fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100.0f, 40.0f));
//        make.left.equalTo(self.foucsBtn.mas_right).offset(20.0f);
//        make.bottom.equalTo(self.iconView);
//    }];
//
//    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
//        make.centerY.equalTo(self);
//        make.right.equalTo(self).offset(-20.0f);
//    }];
    
//    [_loginBox mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.size.mas_equalTo(self);
//    }];
//
//    [_loginIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(80.0f, 80.0f));
//        make.centerY.equalTo(self.loginBox);
//        make.left.equalTo(self.loginBox).offset(40.0f);
//    }];
//
//    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(150.0f, 80.0f));
//        make.centerY.equalTo(self.loginBox);
//        make.left.equalTo(self.loginIcon.mas_right).offset(20.0f);
//    }];
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

//    [_iconView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl]]] forState:UIControlStateNormal];
//    [_userName setText:name];
//    [_foucsBtn setTitle:[NSString stringWithFormat:@"关注 %@", focusNum] forState:UIControlStateNormal];
//    [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝 %@", fansNum] forState:UIControlStateNormal];
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
