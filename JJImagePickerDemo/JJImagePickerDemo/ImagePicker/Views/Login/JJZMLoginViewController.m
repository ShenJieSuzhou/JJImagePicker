//
//  JJZMLoginViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/16.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJZMLoginViewController.h"
#import "JJForgetPwViewController.h"
#import "HttpRequestUtil.h"
#import "JJToast.h"
#import "JJTokenManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HttpRequestUrlDefine.h"
#import "ViewController.h"

#define AP_MARGIN 20.0f
#define AP_HEIGHT 102.0f
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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.jjTabBarView setHidden:YES];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"账号登录"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    
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
    _accountF = [[UITextField alloc] initWithFrame:CGRectMake(AP_MARGIN, 0, w - 40.0f, 50.0f)];
    _accountF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountF.placeholder = @"手机/用户名";
    [_accountF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _pwdF = [[UITextField alloc] initWithFrame:CGRectMake(AP_MARGIN, 52, w - 40.0f, 50.0f)];
    _pwdF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdF.secureTextEntry = YES;
    _pwdF.placeholder = @"密码";
    [_pwdF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    UIImageView * seperateLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(AP_MARGIN, 51, w - 40.0f, 1)];
    [seperateLine1 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    UIImageView * seperateLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(AP_MARGIN, 101, w - 40.0f, 1)];
    [seperateLine2 setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    
    [_loginView addSubview:_accountF];
    [_loginView addSubview:seperateLine1];
    [_loginView addSubview:_pwdF];
    [_loginView addSubview:seperateLine2];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn.layer setCornerRadius:10.0f];
    [_loginBtn setFrame:CGRectMake(AP_MARGIN, 220.0f, w - 40.0f, AP_LOGINBTN_HEIGHT)];
    [_loginBtn setBackgroundColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f]];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPwdBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [_forgetPwdBtn setFrame:CGRectMake(w - 100 - AP_MARGIN, 280.0f, 100.0f, 30.0f)];
    [_forgetPwdBtn setBackgroundColor:[UIColor clearColor]];
    [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPwdBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login:(UIButton *)sender{
    [SVProgressHUD show];
    NSString *account = _accountF.text;
    NSString *pwd = _pwdF.text;
    
    [HttpRequestUtil JJ_LoginByAccountPwd:[NSString stringWithFormat:@"%@%@", SERVER_IP, AC_LOGIN_REQUEST] account:account pwd:pwd callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            if (error.code == -1001) {
                //网络异常
                [SVProgressHUD showErrorWithStatus:@"登录失败,请检查您的网络"];
                [SVProgressHUD dismissWithDelay:2.0f];
            }
            return;
        }
        
        if(!data){
            //登录失败
            [SVProgressHUD showErrorWithStatus:@"登录失败,网络异常"];
            [SVProgressHUD dismissWithDelay:2.0f];
            return;
        }

        if([[data objectForKey:@"errorCode"] isEqualToString:@"0"]){
            NSString *uid = [data objectForKey:@"user_id"];
            NSString *userName = [data objectForKey:@"userName"];
            NSString *token = [data objectForKey:@"token"];
            NSString *result = [data objectForKey:@"result"];
            
            //取出token user_id username
            LoginModel *userModel = [[LoginModel alloc] initWithName:uid name:userName token:token];
            [JJTokenManager saveToken:userModel];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:2.0f];
            [self dismiss];
        }else{
//            NSString *errorCode = [data objectForKey:@"errorCode"];
            NSString *errorMsg = [data objectForKey:@"errorMsg"];
            [SVProgressHUD showErrorWithStatus:errorMsg];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    }];
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

- (void)dismiss{
    UIViewController *vc = self.presentingViewController;
    //ReadBookController要跳转的界面
    while (![vc isKindOfClass:[ViewController class]]) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}


@end
