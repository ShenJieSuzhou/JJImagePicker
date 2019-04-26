//
//  BindPhoneViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/3.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "DeviceType.h"
#import <Masonry/Masonry.h>

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    //验证码按钮
//    self.yzmBtn = [[GBverifyButton alloc] initWithFrame:CGRectMake(self.bindView.frame.size.width - 80 - 30, 88.0f, 80, 40) root:self Target:self Action:@selector(clickCodeBtn:)];
//    [self.yzmBtn setupUI:self.bindView];
//    [self.yzmBtn setTitleFont:[UIFont systemFontOfSize:12.0f]];
//    [self.yzmBtn setBackgroundColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f]];
//    [self.bindView addSubview:self.yzmBtn];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIView *letfView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, 20.0f)];
    self.phoneTF.leftView = letfView;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneTF.layer setCornerRadius:20.0f];
    [self.phoneTF.layer setMasksToBounds:YES];
    
    UIView *letfView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, 20.0f)];
    self.codeTF.leftView = letfView1;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.codeTF.layer setCornerRadius:20.0f];
    [self.codeTF.layer setMasksToBounds:YES];
    
    if([self isIphoneX]){
        [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 88.0f));
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.navBar).offset(20.0f);
            make.top.mas_equalTo(self.navBar).offset(45.0f);
        }];
        
        [self.myTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navBar);
            make.top.equalTo(self.navBar).offset(45.0f);
        }];
        
        [self.bindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60.0f, 260.0f));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0f);
        }];
        
        [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.bindView);
            make.top.equalTo(self.bindView).offset(20.0f);
        }];
        
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200.0f, 45.0f));
            make.left.mas_equalTo(self.phoneTF);
            make.top.equalTo(self.bindView).offset(85.0f);
        }];
        
        [self.bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 40.0f));
            make.centerX.equalTo(self.bindView);
            make.top.equalTo(self.bindView).offset(145.0f);
        }];
        
    }else{
        [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64.0f));
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.navBar).offset(20.0f);
            make.top.mas_equalTo(self.navBar).offset(27.0f);
        }];
        
        [self.myTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navBar);
            make.top.equalTo(self.navBar).offset(30.0f);
        }];
        
        [self.bindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60.0f, 260.0f));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0f);
        }];
        
        [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.bindView);
            make.top.equalTo(self.bindView).offset(20.0f);
        }];
        
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200.0f, 45.0f));
            make.left.mas_equalTo(self.phoneTF);
            make.top.equalTo(self.bindView).offset(85.0f);
        }];
        
        [self.bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 40.0f));
            make.centerX.equalTo(self.bindView);
            make.top.equalTo(self.bindView).offset(145.0f);
        }];
    }
}

- (IBAction)clickBindBtn:(id)sender {
    
}

- (IBAction)clickCloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)clickCodeBtn:(id)sender{
    
}

- (BOOL)isIphoneX{
    if ([[DeviceType deviceModelName] isEqualToString:@"iPhone X"] || [[DeviceType deviceModelName] isEqualToString:@"iPhone XR"] || [[DeviceType deviceModelName] isEqualToString:@"iPhone XS"] || [[DeviceType deviceModelName] isEqualToString:@"iPhone XS Max"]) {
        return YES;
    }else{
        return NO;
    }
}

@end
