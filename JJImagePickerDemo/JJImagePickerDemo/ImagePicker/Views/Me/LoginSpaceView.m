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
    
    _acLabel = [[UILabel alloc] init];
    [_acLabel setText:@"手机号"];
    [self addSubview:_acLabel];
    
    _pwLabel = [[UILabel alloc] init];
    [_pwLabel setText:@"验证码"];
    [self addSubview:_pwLabel];
    
    _accountField = [[UITextField alloc] init];
    _yzmField = [[UITextField alloc] init];
    [self addSubview:_accountField];
    [self addSubview:_yzmField];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    [_logoView setFrame:CGRectMake((w - 80)/2 , 80.0f, 80.0f, 80.0f)];
    [_APView setFrame:CGRectMake(40, 160.0f, w - 80.0f, 80.0f)];
    
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
