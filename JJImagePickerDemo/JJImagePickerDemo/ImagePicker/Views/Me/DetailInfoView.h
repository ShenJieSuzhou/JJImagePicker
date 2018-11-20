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

@end

@interface DetailInfoView : UIView

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) UIButton *settingBtn;

@property (weak, nonatomic) id<DetailInfoViewDelegate> delegate;

@end
