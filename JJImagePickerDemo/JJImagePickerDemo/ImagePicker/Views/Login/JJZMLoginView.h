//
//  JJZMLoginView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/13.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJZMLoginDelegate <NSObject>

- (void)getAccountPwdLogin:(NSString *)account code:(NSString *)pwd;

- (void)callRegisterAccount;

- (void)callForgetPassword;

@end

@interface JJZMLoginView : UIView

@property (strong, nonatomic) UIView *loginView;

@property (strong, nonatomic) UIImageView *acImgV;

@property (strong, nonatomic) UITextField *accountF;

@property (strong, nonatomic) UIImageView *pwImgV;

@property (strong, nonatomic) UITextField *pwdF;

@property (strong, nonatomic) UIButton *forgetPwdBtn;

@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) UIImageView * seperateLine1;

@property (strong, nonatomic) UIImageView * seperateLine2;

@property (strong, nonatomic) UIButton *registerBtn;

@property (weak, nonatomic) id<JJZMLoginDelegate> delegate;

- (void)dismissTheKeyboard;

@end

