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


@interface JJLoginViewController ()
@property (strong, nonatomic) LoginSpaceView *loginSpaceView;


@end

@implementation JJLoginViewController
@synthesize loginSpaceView = _loginSpaceView;


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

    [self.view addSubview:self.loginSpaceView];
    
}

- (LoginSpaceView *)loginSpaceView{
    if(!_loginSpaceView){
        _loginSpaceView = [[LoginSpaceView alloc] initWithFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, 400.0f) rootView:self];
        [_loginSpaceView setLogo:[UIImage imageNamed:@"filter2"]];
    }
    
    return _loginSpaceView;
}


/*
 * 取消登陆
 */
- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
 * 帐密登陆
 */
- (void)clickAccountPwdBtn:(UIButton *)sender{
    JJZMLoginViewController *loginView = [JJZMLoginViewController new];
    [self presentViewController:loginView animated:YES completion:^{

    }];
}

@end
