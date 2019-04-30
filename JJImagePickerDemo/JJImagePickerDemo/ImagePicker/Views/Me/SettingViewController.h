//
//  SettingViewController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
@class SettingViewController;
@protocol LoginOutDelegate <NSObject>
- (void)userLoginOutCallBack:(SettingViewController *)viewController;
@end

@interface SettingViewController : CustomPhotoViewController

@property (weak, nonatomic) id<LoginOutDelegate> delegate;
@property (strong, nonatomic) UISwitch *switchFunc;

@end
