//
//  DetailInfoView.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailInfoViewDelegate <NSObject>

- (void)pickUpHeaderImgCallback;

- (void)appSettingClickCallback;

- (void)clickToLoginCallback;

@end

@interface DetailInfoView : UIView

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UILabel  *userName;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *foucsBtn;
@property (nonatomic, strong) UIButton *fansBtn;

@property (weak, nonatomic) id<DetailInfoViewDelegate> delegate;

- (void)setLoginState:(BOOL)isLogin;

- (void)updateViewInfo:(NSString *)iconurl name:(NSString *)name focus:(NSString *)focusNum fans:(NSString *)fansNum;

@end
