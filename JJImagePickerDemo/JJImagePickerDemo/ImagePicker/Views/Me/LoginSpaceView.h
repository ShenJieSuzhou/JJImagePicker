//
//  LoginSpaceView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBverifyButton.h"


@protocol JJLoginDelegate <NSObject>

- (void)LoginDataCallBack:(NSString *)account pwd:(NSString *)password;

@end

@interface LoginSpaceView : UIView

@property (strong, nonatomic) UIImageView *logoView;

@property (strong, nonatomic) UIView *APView;

@property (strong, nonatomic) UITextField *accountField;

@property (strong, nonatomic) UILabel *acLabel;

@property (strong, nonatomic) UITextField *yzmField;

@property (strong, nonatomic) UILabel *pwLabel;

@property (strong, nonatomic) GBverifyButton *yzmBtn;

@property (strong, nonatomic) UIButton *loginBtn;

@property (weak, nonatomic) id<JJLoginDelegate> delegate;

@property (strong, nonatomic) UIViewController *baseView;

- (id)initWithFrame:(CGRect)frame rootView:(UIViewController *)root;

- (void)setLogo:(UIImage *)logo;

@end

