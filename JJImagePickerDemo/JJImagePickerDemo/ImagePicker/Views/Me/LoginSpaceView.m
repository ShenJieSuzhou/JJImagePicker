//
//  LoginSpaceView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginSpaceView.h"
#define LOGIN_MARGIN 20.0f
#define YZMBTN_WIDTH 100.0f
#define YZMBTN_HEIGHT 30.0f
#define COMMON_HEIGHT 30.0f

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
@synthesize baseView = _baseView;

- (id)initWithFrame:(CGRect)frame rootView:(UIViewController *)root{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization:root];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization:(UIViewController *)root{
    _baseView = root;
    
    _logoView = [[UIImageView alloc] init];
    [_logoView setBackgroundColor:[UIColor clearColor]];
    _logoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_logoView];
    
    _APView = [[UIView alloc] initWithFrame:CGRectZero];
    [_APView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_APView];
    
    _acLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 50.0f, COMMON_HEIGHT)];
    [_acLabel setText:@"+86"];
    // 添加点击手势
    
    [self.APView addSubview:_acLabel];

//    _pwLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 45.0f, 30.0f, COMMON_HEIGHT)];
//    [_pwLabel setText:@"验证码"];
//    [self.APView addSubview:_pwLabel];
    
    _accountField = [[UITextField alloc] init];
    _accountField.placeholder = @"请输入手机号";
    _yzmField = [[UITextField alloc] init];
    _yzmField.placeholder = @"请输入验证码";
    
    [self.APView addSubview:_accountField];
    [self.APView addSubview:_yzmField];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setBackgroundColor:[UIColor greenColor]];
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
    
    [_APView setFrame:CGRectMake(LOGIN_MARGIN, 200.0f, w - 40.0f, 80.0f)];
    //电话输入框
    [_accountField setFrame:CGRectMake(55.0f, 5.0f, w - 40.0f - 80.0f - YZMBTN_WIDTH, COMMON_HEIGHT)];
    //验证码按钮
    _yzmBtn = [[GBverifyButton alloc] initWithFrame:CGRectMake(_APView.frame.size.width - LOGIN_MARGIN - YZMBTN_WIDTH, 5.0f, YZMBTN_WIDTH, YZMBTN_HEIGHT) root:_baseView Target:self Action:@selector(clickYZMBtn:)];
    [_yzmBtn setupUI:_APView];
    [_yzmBtn setTitleFont:[UIFont systemFontOfSize:10.0f]];
    [_yzmBtn setBackgroundColor:[UIColor blueColor]];
    [_APView addSubview:_yzmBtn];
    
    //分割线
    UIImageView *seperateLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 1.0f, 20.0f)];
    [seperateLine1 setBackgroundColor:[UIColor lightGrayColor]];
    UIImageView *seperateLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 40.0f, w - 60.0f, 1.0f)];
    [seperateLine2 setBackgroundColor:[UIColor lightGrayColor]];
    
    [_APView addSubview:seperateLine1];
    [_APView addSubview:seperateLine2];
    //验证码栏
    [_yzmField setFrame:CGRectMake(LOGIN_MARGIN, 45.0f, w - 2*LOGIN_MARGIN, COMMON_HEIGHT)];
   
    //登录按钮
    [_loginBtn setFrame:CGRectMake(LOGIN_MARGIN, 300.0f, w - 40.0f, 50.0f)];
}

- (void)setLogo:(UIImage *)logo{
    [_logoView setImage:logo];
}

- (void)login:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(LoginDataCallBack:pwd:)]){
        [_delegate LoginDataCallBack:_accountField.text pwd:_yzmField.text];
    }
}

- (void)clickYZMBtn:(UIButton *)sender{
    NSLog(@"123123");
//    [_yzmBtn setEnabled:NO];
    [_yzmBtn startGetMessage];
}

@end
