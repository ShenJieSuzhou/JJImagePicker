//
//  JJLoginViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJLoginViewController.h"

@interface JJLoginViewController ()
@property (strong, nonatomic) UIView *workSpaceView;

@end

@implementation JJLoginViewController
@synthesize workSpaceView = _workSpaceView;


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 20.0f, 20.0f)];
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchBtn setBackgroundColor:[UIColor clearColor]];
    [switchBtn setTitle:@"帐密登陆" forState:UIControlStateNormal];
    [switchBtn.titleLabel setTextColor:[UIColor blackColor]];
    [switchBtn addTarget:self action:@selector(clickAccountPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:switchBtn];

    
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
    
}

@end
