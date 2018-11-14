//
//  LoginSpaceView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginSpaceView.h"


@implementation LoginSpaceView
@synthesize logoView = _logoView;
@synthesize APView = _APView;
@synthesize accountField = _accountField;
@synthesize yzmField = _yzmField;
@synthesize yzmBtn = _yzmBtn;
@synthesize loginBtn = _loginBtn;
@synthesize acLabel = _acLabel;
@synthesize pwLabel = _pwLabel;
@synthesize delegate = _delegate;

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
    _logoView = [[UIImageView alloc] init];
    [_logoView setBackgroundColor:[UIColor clearColor]];
    _logoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_logoView];
    
    _APView = [[UIView alloc] initWithFrame:CGRectZero];
    [_APView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_APView];
    
    _acLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 50.0f, 30.0f)];
    [_acLabel setText:@"+86"];
    [self.APView addSubview:_acLabel];

    _pwLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 45.0f, 30.0f, 30.0f)];
    [_pwLabel setText:@"验证码"];
    [self.APView addSubview:_pwLabel];
    
    _accountField = [[UITextField alloc] init];
    _accountField.placeholder = @"请输入手机号";
    _yzmField = [[UITextField alloc] init];
    _yzmField.placeholder = @"请输入验证码";
    [self.APView addSubview:_accountField];
    [self.APView addSubview:_yzmField];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setBackgroundColor:[UIColor grayColor]];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    //logo
    [_logoView setFrame:CGRectMake((w - 80)/2 , 80.0f, 80.0f, 80.0f)];
    //输入框
    [_APView setFrame:CGRectMake((w - 40)/2, 160.0f, w - 80.0f, 80.0f)];
//    _yzmBtn = [[GBverifyButton alloc] initWithFrame:CGRectMake(<#CGFloat x#>, 5.0f, 80.0f, 30.0f) delegate:nil Target:self Action:]
    
    [_accountField setFrame:CGRectMake(55.0f, 5.0f, w - 80.0f - 55.0f - , 30.0f)];
    UIImageView *seperateLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, w - 80.0f, 1.0f)];
    UIImageView *seperateLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, w - 80.0f, 1.0f)];
    
    [_APView addSubview:seperateLine1];
    [_APView addSubview:seperateLine2];
    
    //登录框
    [_loginBtn setFrame:CGRectMake(20, 280.0f, w, h)];
}

- (void)setLogo:(UIImage *)logo{
    [_logoView setImage:logo];
}

- (void)login:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(LoginDataCallBack:pwd:)]){
        [_delegate LoginDataCallBack:_accountField.text pwd:_yzmField.text];
    }
}

@end
