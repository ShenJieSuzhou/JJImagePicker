//
//  JJZMLoginView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/13.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJZMLoginView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>


#define AP_MARGIN 20.0f
#define AP_HEIGHT 102.0f
#define AP_LOGINBTN_HEIGHT 50.0f

@implementation JJZMLoginView
@synthesize loginView = _loginView;

@synthesize accountF = _accountF;
@synthesize pwdF = _pwdF;

@synthesize forgetPwdBtn = _forgetPwdBtn;
@synthesize loginBtn = _loginBtn;
@synthesize registerBtn = _registerBtn;

@synthesize seperateLine1 = _seperateLine1;
@synthesize seperateLine2 = _seperateLine2;

@synthesize acImgV = _acImgV;
@synthesize pwImgV = _pwImgV;

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
    [self setupUI];
}

- (void)setupUI{
    _loginView = [[UIView alloc] initWithFrame:CGRectZero];
    [_loginView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_loginView];

    // icon
    _acImgV = [[UIImageView alloc] init];
    _acImgV.contentMode = UIViewContentModeScaleAspectFit;
    [_acImgV setImage:[UIImage imageNamed:@"account"]];
    [_loginView addSubview:_acImgV];
    
    _pwImgV = [[UIImageView alloc] init];
    _pwImgV.contentMode = UIViewContentModeScaleAspectFit;
    [_pwImgV setImage:[UIImage imageNamed:@"pw"]];
    [_loginView addSubview:_pwImgV];
    
    // 电话输入框
    _accountF = [[UITextField alloc] init];
    _accountF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountF.placeholder = @"手机/用户名";
    [_accountF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

    _pwdF = [[UITextField alloc] init];
    _pwdF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdF.secureTextEntry = YES;
    _pwdF.placeholder = @"密码";
    [_pwdF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

    _seperateLine1 = [[UIImageView alloc] init];
    [_seperateLine1 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];

    _seperateLine2 = [[UIImageView alloc] init];
    [_seperateLine2 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];

    [_loginView addSubview:_accountF];
    [_loginView addSubview:_seperateLine1];
    [_loginView addSubview:_pwdF];
    [_loginView addSubview:_seperateLine2];

    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn.layer setCornerRadius:10.0f];
    [_loginBtn setBackgroundColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f]];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickZMLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:_loginBtn];

    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPwdBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [_forgetPwdBtn setBackgroundColor:[UIColor clearColor]];
    [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:_forgetPwdBtn];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_registerBtn setBackgroundColor:[UIColor clearColor]];
    [_registerBtn setTitle:@"还没有账号? 快去注册吧!" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:_registerBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.frame.size);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    [_acImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.loginView.mas_top);
        make.left.mas_equalTo(self.loginView.mas_left).offset(40.0f);
    }];
    
    // 账号
    [_accountF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginView.mas_top);
        make.left.mas_equalTo(self.acImgV.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.loginView.mas_right).offset(-40.0f);
        make.bottom.mas_equalTo(self.acImgV.mas_bottom);
    }];
    
    //分割
    [self.seperateLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 1));
        make.top.mas_equalTo(self.accountF.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.loginView.mas_left).offset(40.0f);
    }];
    
    [self.pwImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.seperateLine1.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.loginView.mas_left).offset(40.0f);
    }];
    
    // 密码
    [self.pwdF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperateLine1.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.pwImgV.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.loginView.mas_right).offset(-40.0f);
        make.bottom.mas_equalTo(self.pwImgV.mas_bottom);
    }];
    
    [self.seperateLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 1));
        make.top.mas_equalTo(self.pwdF.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.loginView.mas_left).offset(40.0f);
    }];
    
    // 忘记密码
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120.0f, 30.0f));
        make.top.mas_equalTo(self.seperateLine2.mas_bottom).offset(20.0f);
        make.right.mas_equalTo(self.loginView.mas_right).offset(-40.0f);
    }];
    
    // 登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 40));
        make.top.mas_equalTo(self.seperateLine2.mas_bottom).offset(80.0f);
        make.left.mas_equalTo(self.loginView.mas_left).offset(40.0f);
    }];
    
    // 注册账号
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 40));
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(20.0f);
        make.left.mas_equalTo(self.loginView.mas_left).offset(40.0f);
    }];
}

- (void)clickZMLogin:(UIButton *)sender{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *account = _accountF.text;
    NSString *pwd = _pwdF.text;
    
    if([account isEqualToString:@""] || [pwd isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"账号密码不能为空"];
        [SVProgressHUD dismissWithDelay:2.0f];
        return;
    }
    
    [_delegate getAccountPwdLogin:account code:pwd];
}

- (void)forgetPwd:(UIButton *)sender{
    [_delegate callForgetPassword];
}

- (void)registerAccount:(UIButton *)sender{
    [_delegate callRegisterAccount];
}

// 关闭键盘
- (void)dismissTheKeyboard{
    [_accountF resignFirstResponder];
    [_pwdF resignFirstResponder];
}

@end
