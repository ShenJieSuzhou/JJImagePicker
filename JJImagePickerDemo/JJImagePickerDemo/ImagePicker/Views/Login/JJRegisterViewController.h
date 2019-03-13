//
//  JJRegisterViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/13.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"

@interface JJRegisterViewController : CustomPhotoViewController

@property (strong, nonatomic) UIView *registerView;

@property (strong, nonatomic) UILabel *titleHead;

@property (strong, nonatomic) UIImageView *acImgV;

@property (strong, nonatomic) UITextField *accountF;

@property (strong, nonatomic) UIImageView *pwImgV1;

@property (strong, nonatomic) UITextField *pwdF1;

@property (strong, nonatomic) UIImageView *pwImgV2;

@property (strong, nonatomic) UITextField *pwdF2;

@property (strong, nonatomic) UIImageView * seperateLine1;

@property (strong, nonatomic) UIImageView * seperateLine2;

@property (strong, nonatomic) UIImageView * seperateLine3;

@property (strong, nonatomic) UIButton *registerBtn;

@end

