//
//  JJRegisterViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/13.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJRegisterViewController.h"
#import <Masonry/Masonry.h>
#import "HttpRequestUtil.h"
#import "HttpRequestUrlDefine.h"
#import "GlobalDefine.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JJTokenManager.h"
#import "LoginModel.h"

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

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
    if([_accountF.text length] == 0){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"用户名不能为空"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if([_accountF.text length] > 24){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"用户名不能超过24个字符"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if(![self isChineseWithStr:_accountF.text]){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"用户名不能包含中文"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    
    if([_pwdF1.text length] == 0 || [_pwdF2.text length] == 0){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"密码不能为空"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if(![self isChineseWithStr:_pwdF1.text]){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"密码不能包含中文"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if([_pwdF1.text length] < 6 || [_pwdF2.text length] < 6){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"密码不能少于6个字符"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if(![_pwdF1.text isEqualToString:_pwdF2.text]){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"密码不一致"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    NSString *account = _accountF.text;
    NSString *password = _pwdF1.text;
    
    
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD show];
    [HttpRequestUtil JJ_RegisterNewUser:REGISTER_USER_REQUEST account:account pwd:password callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"0"]){
            [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
            [SVProgressHUD dismissWithDelay:2.0f];
            return;
        }
        
        if([[data objectForKey:@"errorCode"] isEqualToString:@"1"]){
            // update 用户信息
            [weakSelf updateUserLoginInfo:data];
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:2.0f];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCCESS_NOTIFICATION object:nil];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

- (void)updateUserLoginInfo:(NSDictionary *)userInfo{
    NSString *uid = [userInfo objectForKey:@"user_id"];
    NSString *userName = [userInfo objectForKey:@"userName"];
    NSString *token = [userInfo objectForKey:@"token"];
    NSString *fans = [userInfo objectForKey:@"fans"];
    NSString *foucs = [userInfo objectForKey:@"focus"];
    NSString *iconUrl = [userInfo objectForKey:@"iconUrl"];
    int gender = [[userInfo objectForKey:@"genda"] intValue];
    NSString *birth = [userInfo objectForKey:@"birth"];
    NSString *phone = [userInfo objectForKey:@"telephone"];
    //取出token user_id username
    LoginModel *userModel = [[LoginModel alloc] initWithName:uid name:userName icon:iconUrl focus:foucs fans:fans gender:gender birth:birth phone:phone token:token works:nil];
    [[JJTokenManager shareInstance] setUserLoginInfo:userModel];
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


/**
 判断是否是中文

 @param str 字符串
 @return 结果
 */
- (BOOL)isChineseWithStr:(NSString *)str
{
    for(int i = 0; i < [str length]; i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }else{
            return NO;
        }
    }
    
    return NO;
}

@end
