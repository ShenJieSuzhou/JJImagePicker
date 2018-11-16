//
//  JJForgetPwViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/16.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJForgetPwViewController.h"

@interface JJForgetPwViewController ()

@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation JJForgetPwViewController
@synthesize descLabel = _descLabel;

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
    
    CGFloat w = self.view.frame.size.height;
    CGFloat h = self.view.frame.size.width;
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, w, h)];
//    [_descLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_descLabel setText:@"如忘记密码，请使用手机验证码登录后修改密码"];
    [self.view addSubview:_descLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * 取消登陆
 */
- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
