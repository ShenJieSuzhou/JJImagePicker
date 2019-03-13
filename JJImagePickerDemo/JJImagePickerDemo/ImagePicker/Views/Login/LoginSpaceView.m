//
//  LoginSpaceView.m
//  JJImagePickerDemo
//
//  Created by 沈蓝 on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "LoginSpaceView.h"
#define LOGIN_MARGIN 20.0f
#define YZMBTN_WIDTH 100.0f
#define YZMBTN_HEIGHT 30.0f
#define COMMON_HEIGHT 40.0f

@implementation LoginSpaceView

@synthesize APView = _APView;
@synthesize accountField = _accountField;
@synthesize yzmField = _yzmField;
@synthesize yzmBtn = _yzmBtn;
@synthesize loginBtn = _loginBtn;
@synthesize acImageV = _acImageV;
@synthesize pwImageV = _pwImageV;
@synthesize delegate = _delegate;
@synthesize sep1 = _sep1;
@synthesize sep2 = _sep2;

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
    _APView = [[UIView alloc] initWithFrame:CGRectZero];
    [_APView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_APView];
    
    // 分割线
    _sep1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_sep1 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    _sep2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_sep2 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    [self.APView addSubview:_sep1];
    [self.APView addSubview:_sep2];
    
    // icon
    _acImageV = [[UIImageView alloc] init];
    _acImageV.contentMode = UIViewContentModeScaleAspectFit;
    [_acImageV setImage:[UIImage imageNamed:@"iPhone X"]];
    [self.APView addSubview:_acImageV];
    
    _pwImageV = [[UIImageView alloc] init];
    _pwImageV.contentMode = UIViewContentModeScaleAspectFit;
    [_pwImageV setImage:[UIImage imageNamed:@"yzm"]];
    [self.APView addSubview:_pwImageV];
    
    // 输入框
    _accountField = [[UITextField alloc] init];
    _accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountField.placeholder = @"请输入手机号";
    [_accountField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _yzmField = [[UITextField alloc] init];
    _yzmField.secureTextEntry = NO;
    _yzmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _yzmField.placeholder = @"请输入验证码";
    [_yzmField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    [self.APView addSubview:_accountField];
    [self.APView addSubview:_yzmField];
    
    //验证码按钮
    _yzmBtn = [[GBverifyButton alloc] initWithFrame:CGRectZero];
    [_yzmBtn setBackgroundColor:[UIColor clearColor]];
    [self.APView addSubview:_yzmBtn];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setBackgroundColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f]];
    [_loginBtn.layer setCornerRadius:20.0f];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.APView addSubview:_loginBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.APView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.frame.size);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    
    [self.acImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(self.APView.mas_top);
        make.left.mas_equalTo(self.APView.mas_left).offset(40.0f);
        make.right.mas_equalTo(self.APView.mas_left).offset(70.0f);
    }];
    
    //电话输入框
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.APView.mas_top);
        make.left.mas_equalTo(self.acImageV.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.mas_right).offset(-40.0f);
        make.bottom.mas_equalTo(self.acImageV.mas_bottom);
    }];
    
    //分割
    [self.sep1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 1));
        make.top.mas_equalTo(self.accountField.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.APView.mas_left).offset(40.0f);
    }];
    
    [self.pwImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sep1.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.APView.mas_left).offset(40.0f);
        make.right.mas_equalTo(self.APView.mas_left).offset(70.0f);
    }];
    
    //验证码栏
    [self.yzmField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sep1.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.pwImageV.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.mas_right).offset(-140.0f);
        make.bottom.mas_equalTo(self.pwImageV.mas_bottom);
    }];
    
    [self.yzmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.top.mas_equalTo(self.sep1.mas_bottom).offset(30.0f);
        make.right.mas_equalTo(self.APView.mas_right).offset(-40.0f);
        make.centerY.mas_equalTo(self.yzmField.mas_centerY);
    }];
    
    [self.sep2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 180, 1));
        make.top.mas_equalTo(self.yzmField.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.APView.mas_left).offset(40.0f);
    }];
   
    //登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 40));
         make.top.mas_equalTo(self.sep2.mas_bottom).offset(40.0f);
        make.left.mas_equalTo(self.APView.mas_left).offset(40.0f);
    }];
}


- (void)clickLoginBtn:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(LoginDataCallBack:code:)]){
        [_delegate LoginDataCallBack:_accountField.text code:_yzmField.text];
    }
}

// 关闭键盘
- (void)dismissTheKeyboard{
    [_accountField resignFirstResponder];
    [_yzmField resignFirstResponder];
}

@end
