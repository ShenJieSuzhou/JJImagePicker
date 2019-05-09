//
//  LoginPWDViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/3.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "LoginPWDViewController.h"
#import <Masonry/Masonry.h>
#import "DeviceType.h"
#import "HttpRequestUrlDefine.h"
#import "HttpRequestUtil.h"
#import "JJTokenManager.h"
#import "GlobalDefine.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface LoginPWDViewController ()

@end

@implementation LoginPWDViewController
@synthesize delegate = _delegate;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIView *letfView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, 20.0f)];
    self.nPwdField.leftView = letfView;
    self.nPwdField.leftViewMode = UITextFieldViewModeAlways;
    self.nPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.nPwdField.layer setCornerRadius:20.0f];
    [self.nPwdField.layer setMasksToBounds:YES];
    
    UIView *letfView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, 20.0f)];
    self.oldPwdField.leftView = letfView1;
    self.oldPwdField.leftViewMode = UITextFieldViewModeAlways;
    self.oldPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.oldPwdField.layer setCornerRadius:20.0f];
    [self.oldPwdField.layer setMasksToBounds:YES];
    
    UIView *letfView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, 20.0f)];
    self.mPwdField.leftView = letfView2;
    self.mPwdField.leftViewMode = UITextFieldViewModeAlways;
    self.mPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mPwdField.layer setCornerRadius:20.0f];
    [self.mPwdField.layer setMasksToBounds:YES];
    
    UIView *letfView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, 20.0f)];
    self.checkMPwdField.leftView = letfView3;
    self.checkMPwdField.leftViewMode = UITextFieldViewModeAlways;
    self.checkMPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.checkMPwdField.layer setCornerRadius:20.0f];
    [self.checkMPwdField.layer setMasksToBounds:YES];
    
    //调整位置
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
        
        [self.nUserView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60.0f, 130.0f));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0f);
        }];
        
        [self.nPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.nUserView);
            make.top.equalTo(self.nUserView).offset(20.0f);
        }];
        
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 40.0f));
            make.centerX.equalTo(self.nUserView);
            make.top.equalTo(self.nUserView).offset(90.0f);
        }];
        
        [self.oUserView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60.0f, 250.0f));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0f);
        }];
        
        [self.oldPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(20.0f);
        }];
        
        [self.mPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(85.0f);
        }];
        
        [self.checkMPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(150.0f);
        }];
        
        [self.nSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 40.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(220.0f);
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
        
        [self.nUserView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60.0f, 130.0f));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0f);
        }];
        
        [self.nPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.nUserView);
            make.top.equalTo(self.nUserView).offset(20.0f);
        }];
        
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 40.0f));
            make.centerX.equalTo(self.nUserView);
            make.top.equalTo(self.nUserView).offset(90.0f);
        }];
        
        [self.oUserView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60.0f, 250.0f));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0f);
        }];
        
        [self.oldPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(20.0f);
        }];
        
        [self.mPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(85.0f);
        }];
        
        [self.checkMPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 45.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(150.0f);
        }];
        
        [self.nSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 40.0f));
            make.centerX.equalTo(self.oUserView);
            make.top.equalTo(self.oUserView).offset(220.0f);
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    [self.closeBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if(!self.isFreshMan){
        [self.nUserView setHidden:YES];
    }else{
        [self.oUserView setHidden:YES];
    }
}

/**
 第一次设置密码
 */
- (IBAction)nclickSaveBtn:(id)sender {

}

/**
 更新密码
 */
- (IBAction)mClickSaveBtn:(id)sender {
    if([self.oldPwdField.text length] == 0 || [self.oldPwdField.text length] == 0 || [self.mPwdField.text length] == 0 || [self.mPwdField.text length] == 0 || [self.checkMPwdField.text length] == 0 || [self.checkMPwdField.text length] == 0){
        
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if([self IsChinese:self.oldPwdField.text] && [self IsChinese:self.mPwdField.text] && [self IsChinese:self.checkMPwdField.text]){
        [SVProgressHUD showErrorWithStatus:@"密码不能包含中文"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if([_mPwdField.text length] < 6 || [_mPwdField.text length] < 6){
        [SVProgressHUD showErrorWithStatus:@"密码不能少于6个字符"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if(![_mPwdField.text isEqualToString:_checkMPwdField.text]){
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD show];
    [HttpRequestUtil JJ_SetUserNewPassword:UPDATE_MY_PASSWORD token:[JJTokenManager shareInstance].getUserToken oldPwd:self.oldPwdField.text newPwd:self.mPwdField.text userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"1"]){
            [weakSelf.delegate setPwdSuccessCallBack:weakSelf];
        }else{
            [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    }];
}

/**
 取消
 */
- (void)clickCancelBtn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isIphoneX{
    if ([[DeviceType deviceModelName] isEqualToString:@"iPhone X"] || [[DeviceType deviceModelName] isEqualToString:@"iPhone XR"] || [[DeviceType deviceModelName] isEqualToString:@"iPhone XS"] || [[DeviceType deviceModelName] isEqualToString:@"iPhone XS Max"]) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)IsChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    
    return NO;
}

@end
