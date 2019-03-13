//
//  JJRegisterViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/13.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJRegisterViewController.h"
#import <Masonry/Masonry.h>


@interface JJRegisterViewController ()

@end

@implementation JJRegisterViewController
@synthesize registerView = _registerView;

@synthesize titleHead = _titleHead;
@synthesize accountF = _accountF;
@synthesize pwdF1 = _pwdF1;
@synthesize pwdF2 = _pwdF2;

@synthesize registerBtn = _registerBtn;

@synthesize seperateLine1 = _seperateLine1;
@synthesize seperateLine2 = _seperateLine2;
@synthesize seperateLine3 = _seperateLine3;
@synthesize acImgV = _acImgV;
@synthesize pwImgV1 = _pwImgV1;
@synthesize pwImgV2 = _pwImgV2;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.jjTabBarView setHidden:YES];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.registerView];
    
    [self.registerView addSubview:self.titleHead];
    
    // icon
    _acImgV = [[UIImageView alloc] init];
    _acImgV.contentMode = UIViewContentModeScaleAspectFit;
    [_acImgV setImage:[UIImage imageNamed:@"account"]];
    
    
    // 电话输入框
    _accountF = [[UITextField alloc] init];
    _accountF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountF.placeholder = @"用户名";
    [_accountF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _seperateLine1 = [[UIImageView alloc] init];
    [_seperateLine1 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    // 密码
    _pwImgV1 = [[UIImageView alloc] init];
    _pwImgV1.contentMode = UIViewContentModeScaleAspectFit;
    [_pwImgV1 setImage:[UIImage imageNamed:@"pw"]];
    
    
    _pwdF1 = [[UITextField alloc] init];
    _pwdF1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdF1.secureTextEntry = YES;
    _pwdF1.placeholder = @"密码";
    [_pwdF1 setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _seperateLine2 = [[UIImageView alloc] init];
    [_seperateLine2 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    // 再次输入密码
    _pwImgV2 = [[UIImageView alloc] init];
    _pwImgV2.contentMode = UIViewContentModeScaleAspectFit;
    [_pwImgV2 setImage:[UIImage imageNamed:@"pw"]];

    
    _pwdF2 = [[UITextField alloc] init];
    _pwdF2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdF2.secureTextEntry = YES;
    _pwdF2.placeholder = @"请再次输入密码";
    [_pwdF2 setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _seperateLine3 = [[UIImageView alloc] init];
    [_seperateLine3 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    [self.registerView addSubview:_acImgV];
    [self.registerView addSubview:_accountF];
    [self.registerView addSubview:_seperateLine1];
    [self.registerView addSubview:_pwImgV1];
    [self.registerView addSubview:_pwdF1];
    [self.registerView addSubview:_seperateLine2];
    [self.registerView addSubview:_pwImgV2];
    [self.registerView addSubview:_pwdF2];
    [self.registerView addSubview:_seperateLine3];
    
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_registerBtn.layer setCornerRadius:15.0f];
    [_registerBtn setBackgroundColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f]];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerUserToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView addSubview:_registerBtn];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view.frame.size);
        make.top.mas_equalTo(self.customNaviBar.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [self.titleHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 60));
        make.top.mas_equalTo(self.registerView.mas_top).offset(20.0f);
        make.left.mas_equalTo(self.view.mas_left).offset(20.0f);
    }];
    
    [_acImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.registerView.mas_top).offset(120.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
    // 账号
    [_accountF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerView.mas_top).offset(120.0f);
        make.left.mas_equalTo(self.acImgV.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.registerView.mas_right).offset(-40.0f);
        make.bottom.mas_equalTo(self.acImgV.mas_bottom);
    }];
    
    //分割
    [self.seperateLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 80, 1));
        make.top.mas_equalTo(self.accountF.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
    // 密码
    [self.pwImgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.seperateLine1.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
    [self.pwdF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperateLine1.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.pwImgV1.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.registerView.mas_right).offset(-40.0f);
        make.bottom.mas_equalTo(self.pwImgV1.mas_bottom);
    }];
    
    [self.seperateLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 80, 1));
        make.top.mas_equalTo(self.pwdF1.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
    [self.pwImgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.seperateLine2.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
    [self.pwdF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperateLine2.mas_bottom).offset(30.0f);
        make.left.mas_equalTo(self.pwImgV2.mas_right).offset(10.0f);
        make.right.mas_equalTo(self.registerView.mas_right).offset(-40.0f);
        make.bottom.mas_equalTo(self.pwImgV2.mas_bottom);
    }];
    
    [self.seperateLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 80, 1));
        make.top.mas_equalTo(self.pwdF2.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
    // 注册账号
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 80, 40));
        make.top.mas_equalTo(self.seperateLine3.mas_bottom).offset(40.0f);
        make.left.mas_equalTo(self.registerView.mas_left).offset(40.0f);
    }];
    
}

- (UILabel *)titleHead{
    if(!_titleHead){
        _titleHead = [UILabel new];
        [_titleHead setText:@"欢迎注册糖果"];
        [_titleHead setTextColor:[UIColor blackColor]];
        [_titleHead setTextAlignment:NSTextAlignmentLeft];
        [_titleHead setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    }
    
    return _titleHead;
}


- (UIView *)registerView{
    if(!_registerView){
        _registerView = [UIView new];
        [_registerView setBackgroundColor:[UIColor whiteColor]];
    }
    
    return _registerView;
}

- (void)registerUserToLogin:(UIButton *)sender{
    NSLog(@"登录");
}


/*
 * 返回
 */
- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_accountF resignFirstResponder];
    [_pwdF1 resignFirstResponder];
    [_pwdF2 resignFirstResponder];
}

@end
