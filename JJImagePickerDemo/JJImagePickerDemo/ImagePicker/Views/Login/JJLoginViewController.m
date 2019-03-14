//
//  JJLoginViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJLoginViewController.h"
#import "LoginSpaceView.h"
#import "JJZMLoginViewController.h"
#import "HttpRequestUtil.h"
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "JJWechatManager.h"
#import "JJTokenManager.h"
#import "HttpRequestUrlDefine.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "GlobalDefine.h"
#import <Masonry/Masonry.h>
#import "JJZMLoginView.h"
#import "JJForgetPwViewController.h"
#import "JJRegisterViewController.h"


@interface JJLoginViewController ()<JJLoginDelegate,JJWXLoginDelegate,JJZMLoginDelegate>

@property (strong, nonatomic) LoginSpaceView *loginSpaceView;
@property (strong, nonatomic) JJZMLoginView *zmLoginView;
@property (strong, nonatomic) UIButton *wechatBtn;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UILabel *titleHead;
@property (strong, nonatomic) UIButton *switchBtn;

@end

@implementation JJLoginViewController
@synthesize loginSpaceView = _loginSpaceView;
@synthesize wechatBtn = _wechatBtn;
@synthesize tipLabel = _tipLabel;
@synthesize titleHead = _titleHead;
@synthesize switchBtn = _switchBtn;
@synthesize zmLoginView = _zmLoginView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    // 欢迎使用糖果相机
    [self.view addSubview:self.titleHead];
    
    // 切换按钮
    [self.view addSubview:self.switchBtn];
    
    // 手机验证码登录
    [self.view addSubview:self.loginSpaceView];
    
    // 账密登录
    [self.view addSubview:self.zmLoginView];
    [self.zmLoginView setHidden:YES];
    
    [self.titleHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 60));
        make.top.mas_equalTo(self.view.mas_top).offset(100.0f);
        make.left.mas_equalTo(self.view.mas_left).offset(20.0f);
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.right.mas_equalTo(self.view.mas_right).offset(-20.0f);
        make.bottom.mas_equalTo(self.titleHead.mas_bottom);
    }];
    
    [self.loginSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 200.0f));
        make.top.mas_equalTo(self.titleHead.mas_bottom).offset(40.0f);
    }];
    
    [self.zmLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 300.0f));
        make.top.mas_equalTo(self.titleHead.mas_bottom).offset(40.0f);
    }];
    
    // 第三方登录
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_tipLabel setText:@"-第三方登录-"];
    [_tipLabel setTextAlignment:NSTextAlignmentCenter];
    [_tipLabel setTextColor:[UIColor lightGrayColor]];
    [_tipLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.view addSubview:_tipLabel];

    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 30.0f));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-150.0f);
    }];
    
    _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [_wechatBtn addTarget:self action:@selector(clickWechatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatBtn];
    [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(20.0f);
    }];
    
    if (![WXApi isWXAppInstalled]) {
        [_tipLabel setHidden:YES];
        [_wechatBtn setHidden:YES];
    }else{
        [_tipLabel setHidden:NO];
        [_wechatBtn setHidden:NO];
    }
    
}

- (LoginSpaceView *)loginSpaceView{
    if(!_loginSpaceView){
        _loginSpaceView = [[LoginSpaceView alloc] initWithFrame:CGRectZero];
        _loginSpaceView.delegate = self;
    }
    
    return _loginSpaceView;
}

- (JJZMLoginView *)zmLoginView{
    if(!_zmLoginView){
        _zmLoginView = [[JJZMLoginView alloc] initWithFrame:CGRectZero];
        _zmLoginView.delegate = self;
    }
    
    return _zmLoginView;
}

- (UILabel *)titleHead{
    if(!_titleHead){
        _titleHead = [UILabel new];
        [_titleHead setText:@"欢迎来到糖果"];
        [_titleHead setTextColor:[UIColor blackColor]];
        [_titleHead setTextAlignment:NSTextAlignmentLeft];
        [_titleHead setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    }
    
    return _titleHead;
}

- (UIButton *)switchBtn{
    if(!_switchBtn){
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchBtn setBackgroundColor:[UIColor clearColor]];
        [_switchBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [_switchBtn setTitle:@"快速登录" forState:UIControlStateSelected];
        [_switchBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_switchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(clickAccountPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _switchBtn;
}


/*
 * 帐密登陆
 */
- (void)clickAccountPwdBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        [UIView animateWithDuration:5.0 animations:^{
            [self.loginSpaceView setHidden:YES];
            [self.zmLoginView setHidden:NO];
        }];
    }else{
        [UIView animateWithDuration:5.0 animations:^{
            [self.zmLoginView setHidden:YES];
            [self.loginSpaceView setHidden:NO];
        }];
    }
}

/**
 微信登录
 */
- (void)clickWechatBtn:(UIButton *)sender{
    [JJWechatManager shareInstance].delegate = self;
    [[JJWechatManager shareInstance] clickWechatLogin:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.loginSpaceView dismissTheKeyboard];
    [self.zmLoginView dismissTheKeyboard];
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


#pragma mark - JJLoginDelegate
- (void)LoginDataCallBack:(NSString *)telephone code:(NSString *)code{
    //验证电话号码跟短信验证码格式
    
    //请求登录
    [HttpRequestUtil JJ_LoginByPhoneAndCode:@"" phone:telephone code:code callback:^(NSDictionary *data, NSError *error) {
        if(!error){
            
        }else{
            
        }
    }];
}

/*
 * @brief 请求验证码
 * @param telephone 电话号码
 */
- (void)LoginRequestCode:(NSString *)telephone{
    //验证电话号吗是否合法
    
    //请求发送验证码
    [HttpRequestUtil JJ_RequestSMSCode:@"" phone:telephone callback:^(NSDictionary *data, NSError *error) {
        if(!error){
            
        }else{
            
        }
    }];
}

#pragma mark - JJZmLoginDelegate
- (void)getAccountPwdLogin:(NSString *)account code:(NSString *)pwd{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_LoginByAccountPwd:AC_LOGIN_REQUEST account:account pwd:pwd callback:^(NSDictionary *data, NSError *error) {
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

- (void)callRegisterAccount{
    JJRegisterViewController *registerView = [JJRegisterViewController new];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (void)callForgetPassword{
    JJForgetPwViewController *forgetPWView = [JJForgetPwViewController new];
    [self.navigationController pushViewController:forgetPWView animated:YES];
}

#pragma mark - wechatLoginDelegate
- (void)wechatLoginSuccess{
    NSLog(@"%s", __func__);
    // 获取用户信息
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_WechatUserLogin:THIRDPLATFORM_LOGIN openId:[JJTokenManager shareInstance].getWechatOpenID accessToken:[JJTokenManager shareInstance].getWechatToken type:@"1" extend:@"" callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"0"]){
            [SVProgressHUD showErrorWithStatus:JJ_LOGININFO_EXCEPTION];
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

- (void)wechatLoginDenied{
    NSLog(@"%s", __func__);
    [SVProgressHUD showErrorWithStatus:JJ_WECHATLOGIN_DENIED];
    [SVProgressHUD dismissWithDelay:2.0f];
}

- (void)wechatLoginCancel{
    NSLog(@"%s", __func__);
    [SVProgressHUD showErrorWithStatus:JJ_WECHATLOGIN_CANCEL];
    [SVProgressHUD dismissWithDelay:2.0f];
}

@end
