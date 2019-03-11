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


@interface JJLoginViewController ()<JJLoginDelegate,JJWXLoginDelegate>

@property (strong, nonatomic) LoginSpaceView *loginSpaceView;
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.titleHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 60));
        make.top.mas_equalTo(self).offset(100.0f);
        make.left.mas_equalTo(self).offset(20.0f);
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.right.mas_equalTo(self).offset(20.0f);
        make.bottom.mas_equalTo(self.titleHead);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 欢迎使用糖果相机
    [self.view addSubview:self.titleHead];

    // 账号密码登录
    [self.view addSubview:self.switchBtn];

    
    // 手机验证码登录
//    [self.view addSubview:self.loginSpaceView];

    
    // 第三方登录
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 160.0f, self.view.frame.size.width, 40.0f)];
    [_tipLabel setText:@"-第三方登录-"];
    [_tipLabel setTextAlignment:NSTextAlignmentCenter];
    [_tipLabel setTextColor:[UIColor lightGrayColor]];
    [_tipLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.view addSubview:_tipLabel];
    
    _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatBtn setFrame:CGRectMake((self.view.frame.size.width - 156.0f)/2, self.view.frame.size.height - 100.0f, 156.f, 32.f)];
    [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"icon48_wx_button"] forState:UIControlStateNormal];
    [_wechatBtn addTarget:self action:@selector(clickWechatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatBtn];
}

- (LoginSpaceView *)loginSpaceView{
    if(!_loginSpaceView){
        _loginSpaceView = [[LoginSpaceView alloc] initWithFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, 400.0f) rootView:self];
        _loginSpaceView.delegate = self;
        [_loginSpaceView setLogo:[UIImage imageNamed:@"myApp"]];
    }
    
    return _loginSpaceView;
}

- (UILabel *)titleHead{
    if(!_titleHead){
        _titleHead = [UILabel new];
        [_titleHead setText:@"欢迎使用糖果相机"];
        [_titleHead setTextColor:[UIColor blackColor]];
        [_titleHead setTextAlignment:NSTextAlignmentLeft];
        [_titleHead setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    }
    
    return _titleHead;
}

- (UIButton *)switchBtn{
    if(!_switchBtn){
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchBtn setBackgroundColor:[UIColor clearColor]];
        [_switchBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    }
    
    return _switchBtn;
}

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

/*
 * 取消登陆
 */
- (void)clickCancelBtn:(UIButton *)sender{
    UIViewController *vc = self.presentingViewController;
    
    //要跳转的界面
    while (![vc isKindOfClass:[ViewController class]]) {
        vc = vc.presentingViewController;
    }
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}

/*
 * 帐密登陆
 */
- (void)clickAccountPwdBtn:(UIButton *)sender{
    JJZMLoginViewController *loginView = [JJZMLoginViewController new];
    [self presentViewController:loginView animated:YES completion:^{

    }];
}


/**
 微信登录
 */
- (void)clickWechatBtn:(UIButton *)sender{
    [JJWechatManager shareInstance].delegate = self;
    [[JJWechatManager shareInstance] clickWechatLogin:self];
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark wechatLoginDelegate
- (void)wechatLoginSuccess{
    NSLog(@"%s", __func__);
    // 获取用户信息
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    
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
        
        // update 用户信息
        if([[data objectForKey:@"errorCode"] isEqualToString:@"1"]){
            NSString *uid = [data objectForKey:@"user_id"];
            NSString *userName = [data objectForKey:@"userName"];
            NSString *token = [data objectForKey:@"token"];
            NSString *fans = [data objectForKey:@"fans"];
            NSString *foucs = [data objectForKey:@"focus"];
            NSString *iconUrl = [data objectForKey:@"iconUrl"];
            int gender = [[data objectForKey:@"genda"] intValue];
            NSString *birth = [data objectForKey:@"birth"];
            NSString *phone = [data objectForKey:@"telephone"];
            //取出token user_id username
            LoginModel *userModel = [[LoginModel alloc] initWithName:uid name:userName icon:iconUrl focus:foucs fans:fans gender:gender birth:birth phone:phone token:token works:nil];
            [[JJTokenManager shareInstance] setUserLoginInfo:userModel];

            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:2.0f];
            [weakSelf dismissViewController];
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
