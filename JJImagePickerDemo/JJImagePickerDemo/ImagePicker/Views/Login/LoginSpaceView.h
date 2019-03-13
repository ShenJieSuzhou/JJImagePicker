//
//  LoginSpaceView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "GBverifyButton.h"


@protocol JJLoginDelegate <NSObject>

- (void)LoginDataCallBack:(NSString *)telephone code:(NSString *)code;

- (void)LoginRequestCode:(NSString *)telephone;

@end

@interface LoginSpaceView : UIView

@property (strong, nonatomic) UIView *APView;

@property (strong, nonatomic) UITextField *accountField;

@property (strong, nonatomic) UIImageView *acImageV;

@property (strong, nonatomic) UITextField *yzmField;

@property (strong, nonatomic) UIImageView *pwImageV;

@property (strong, nonatomic) GBverifyButton *yzmBtn;

@property (strong, nonatomic) UIButton *loginBtn;

@property (weak, nonatomic) id<JJLoginDelegate> delegate;

@property (strong, nonatomic) UIImageView *sep1;

@property (strong, nonatomic) UIImageView *sep2;

- (void)dismissTheKeyboard;

@end

