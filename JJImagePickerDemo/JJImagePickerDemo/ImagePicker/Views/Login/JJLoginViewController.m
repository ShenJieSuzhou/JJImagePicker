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


@interface JJLoginViewController ()<JJLoginDelegate,JJWXLoginDelegate>
@property (strong, nonatomic) LoginSpaceView *loginSpaceView;
@property (strong, nonatomic) UIButton *wechatBtn;
@property (strong, nonatomic) UILabel *tipLabel;

@end

@implementation JJLoginViewController
@synthesize loginSpaceView = _loginSpaceView;
@synthesize wechatBtn = _wechatBtn;
@synthesize tipLabel = _tipLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    //test
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.jjTabBarView setHidden:YES];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchBtn setBackgroundColor:[UIColor clearColor]];
    [switchBtn setTitle:@"帐密登陆" forState:UIControlStateNormal];
    [switchBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [switchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(clickAccountPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:switchBtn withFrame:CGRectMake(self.view.frame.size.width - 100, 30, 80, 30)];
    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"登录"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];

    [self.view addSubview:self.loginSpaceView];
    
    
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

#pragma mark wechatLoginDelegate
- (void)wechatLoginSuccess{
    NSLog(@"%s", __func__);
    // 获取用户信息
    [HttpRequestUtil JJ_WechatUserInfo:GET_WECHAT_USERINFO openId:[JJTokenManager shareInstance].getWechatOpenID accessToken:[JJTokenManager shareInstance].getWechatToken callback:^(NSDictionary *data, NSError *error) {
        
        
        
    }];
}

- (void)wechatLoginDenied{
    NSLog(@"%s", __func__);
}

- (void)wechatLoginCancel{
    NSLog(@"%s", __func__);
}

@end
