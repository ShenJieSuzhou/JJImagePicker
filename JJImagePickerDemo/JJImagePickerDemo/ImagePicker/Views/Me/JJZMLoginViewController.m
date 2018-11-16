//
//  JJZMLoginViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/16.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJZMLoginViewController.h"
#import "JJForgetPwViewController.h"

#define AP_MARGIN 20.0f
#define AP_HEIGHT 81.0f
#define AP_LOGINBTN_HEIGHT 50.0f


@interface JJZMLoginViewController ()

@property (strong, nonatomic) UIView *loginView;

@property (strong, nonatomic) UITextField *accountF;

@property (strong, nonatomic) UITextField *pwdF;

@property (strong, nonatomic) UIButton *forgetPwdBtn;

@property (strong, nonatomic) UIButton *loginBtn;

@end

@implementation JJZMLoginViewController
@synthesize loginView = _loginView;
@synthesize accountF = _accountF;
@synthesize pwdF = _pwdF;
@synthesize forgetPwdBtn = _forgetPwdBtn;
@synthesize loginBtn = _loginBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.jjTabBarView setHidden:YES];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 20.0f, 20.0f)];
    
    //UI 构建
    [self setupUI];
    
}

- (void)setupUI{
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    _loginView = [[UIView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height + AP_MARGIN, w, AP_HEIGHT)];
    [_loginView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_loginView];
    
    //电话输入框
    _accountF = [[UITextField alloc] initWithFrame:CGRectMake(AP_MARGIN, 0, w - 40.0f, 40.0f)];
    _accountF.placeholder = @"手机/用户名";
    
    _pwdF = [[UITextField alloc] initWithFrame:CGRectMake(AP_MARGIN, 41, w - 40.0f, 40.0f)];
    _pwdF.placeholder = @"密码";
    
    UIImageView * seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(AP_MARGIN, 40, w - 40.0f, 1)];
    [seperateLine setBackgroundColor:[UIColor grayColor]];
    
    [_loginView addSubview:_accountF];
    [_loginView addSubview:seperateLine];
    [_loginView addSubview:_pwdF];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setFrame:CGRectMake(AP_MARGIN, 200.0f, w - 40.0f, AP_LOGINBTN_HEIGHT)];
    [_loginBtn setBackgroundColor:[UIColor greenColor]];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPwdBtn setFrame:CGRectMake(w - 100 - AP_MARGIN, 280.0f, 100.0f, 30.0f)];
    [_forgetPwdBtn setBackgroundColor:[UIColor clearColor]];
    [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPwdBtn.titleLabel setTextColor:[UIColor blueColor]];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPwdBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login:(UIButton *)sender{

}

- (void)forgetPwd:(UIButton *)sender{
    JJForgetPwViewController *jjForgetPwView = [JJForgetPwViewController new];
    [self presentViewController:jjForgetPwView animated:YES completion:^{
        
    }];
}

/*
 * 取消登陆
 */
- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
